//
//  MLStatsTabBarViewController.m
//  MinPairs
//
//  Created by Brandon on 2014-05-25.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLStatsTabBarViewController.h"
#import "MLHelpViewController.h"
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

- (IBAction)onHelpClicked:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"AppHelp" sender:self];
}

- (void)viewDidLoad
{
    UIBarButtonItem* filterBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mFilter.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(onFilterClicked:)];
    
    UIBarButtonItem* helpBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mHelp.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(onHelpClicked:)];
    
    self.navigationItem.rightBarButtonItems = @[helpBtn, filterBtn];
    
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
        
        [_lineGraphResults setObject:[NSNumber numberWithInt:score] forKey: [NSString stringWithFormat:@"Game #%d", i + 1]];
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString: @"AppHelp"])
    {
        MLHelpViewController* vc = [segue destinationViewController];
        vc.pageId = 6;
    }
}

@end
