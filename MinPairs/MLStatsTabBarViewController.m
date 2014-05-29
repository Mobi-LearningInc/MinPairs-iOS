//
//  MLStatsTabBarViewController.m
//  MinPairs
//
//  Created by Brandon on 2014-05-25.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLStatsTabBarViewController.h"
#import "MLTestResultDatabase.h"
#import "MLTheme.h"

@interface MLStatsTabBarViewController ()

@end

@implementation MLStatsTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)onHomeClicked:(UIBarButtonItem *)sender
{
    [[self navigationController] popViewControllerAnimated:true];
}

- (IBAction)onFilterClicked:(UIBarButtonItem *)sender
{
    
}

- (void)viewDidLoad
{
    UIBarButtonItem* filterBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mFilter.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(onFilterClicked:)];
    [filterBtn setTintColor: [MLTheme navButtonColour]];
    self.navigationItem.rightBarButtonItem = filterBtn;
    
    [MLTheme setTheme: self];
    [super viewDidLoad];

    MLTestResultDatabase* db = [[MLTestResultDatabase alloc] initTestResultDatabase];
    NSArray* testResults = [db getTestResults];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"yyyy MMM dd HH:mm:ss"];
    
    NSMutableDictionary* duplicates = [[NSMutableDictionary alloc] init];
    _lineGraphResults = [[NSMutableDictionary alloc] init];
    
    
    
    
    /** Bar Graph Results **/
    
    for (int i = 0; i < [testResults count]; ++i)
    {
        NSDate* date = [formatter dateFromString: [testResults[i] testDate]];
        NSString* str = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
        
        int score = [testResults[i] testQuestionsCorrect];
        
        NSArray* data = [duplicates objectForKey: str];
        if (data)
        {
            NSNumber* added_score = data[0];
            added_score = @([added_score intValue] + score);
            
            NSNumber* dup_count = data[1];
            dup_count = @([dup_count intValue] + 1);
            [duplicates setObject: data forKey: str];
        }
        else
        {
            data = @[[NSNumber numberWithInt: score], [NSNumber numberWithInt: 1]];
            [duplicates setObject: data forKey: str];
        }
        
        [_lineGraphResults setObject:[NSNumber numberWithInt:score] forKey: [NSString stringWithFormat:@"Game #%d", i]];
    }
    
    _barGraphResults = [[NSMutableDictionary alloc] init];
    
    for (NSString* key in duplicates)
    {
        NSArray* arr = [duplicates objectForKey: key];
        int dup_count = [((NSNumber*)arr[1]) intValue];
        
        if (dup_count > 1)
        {
            float val = [((NSNumber*)arr[0]) floatValue];
            val /= dup_count;
            [_barGraphResults setObject:[NSNumber numberWithFloat:val] forKey:key];
        }
        else
        {
            [_barGraphResults setObject:[NSNumber numberWithFloat:[((NSNumber*)arr[0]) floatValue]] forKey:key];
        }
    }
    
    /*[_barGraphResults setObject:[NSNumber numberWithFloat:10] forKey: @"fake"];
    [_barGraphResults setObject:[NSNumber numberWithFloat:7.5] forKey: @"fake2"];
    [_barGraphResults setObject:[NSNumber numberWithFloat:3.5] forKey: @"fake3"];
    [_barGraphResults setObject:[NSNumber numberWithFloat:9.5] forKey: @"fake4"];
    [_barGraphResults setObject:[NSNumber numberWithFloat:5.5] forKey: @"fake5"];
    [_barGraphResults setObject:[NSNumber numberWithFloat:6.5] forKey: @"fake6"];
    [_barGraphResults setObject:[NSNumber numberWithFloat:7.5] forKey: @"fake7"];*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
