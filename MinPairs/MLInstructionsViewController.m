//
//  MLInstructionsViewController.m
//  MinPairs
//
//  Created by Brandon on 2014-05-10.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLInstructionsViewController.h"
#import "MLPQOneViewController.h"
#import "MLPQTwoViewController.h"
#import "MLPQThreeViewController.h"
#import "MLPlatform.h"
#import "MLTheme.h"

@interface MLInstructionsViewController ()

@end

@implementation MLInstructionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (IBAction)onHomeClicked:(UIBarButtonItem *)sender
{
    [[self navigationController] popViewControllerAnimated:true];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [MLTheme updateTheme];
}

- (void)viewDidLoad
{
    [MLTheme setTheme: self];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onTouchToStartClicked:(UIButton *)sender
{
    [self pushSequeOnStack: [self mode]];
}

-(void) pushSequeOnStack:(NSNumber*)mode
{
    unsigned int r = arc4random_uniform(30);
    
    if (r < 10)
    {
        [self performSegueWithIdentifier:@"PQOne" sender: mode];
        
    }
    else if (r < 20)
    {
        [self performSegueWithIdentifier:@"PQTwo" sender: mode];
    }
    else
    {
        [self performSegueWithIdentifier:@"PQThree" sender: mode];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if([[segue identifier]isEqualToString:@"PQOne"]||[[segue identifier]isEqualToString:@"PQTwo"]||[[segue identifier]isEqualToString:@"PQThree"])
    {
        NSString* typeStr = ([sender boolValue])?ML_TEST_TYPE_PRACTICE:ML_TEST_TYPE_QUIZ;
        NSDate* now = [NSDate date];
        NSDateFormatter* formatter =[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy MMM dd HH:mm:ss"];
        NSString* dateStr = [formatter stringFromDate:now];
        MLTestResult* initialResult= [[MLTestResult alloc]initTestResultWithCorrect:0 wrong:0 type:typeStr date:dateStr timeInSec:0 extraInfo:@"testing"];
        if([[segue identifier]isEqualToString:@"PQOne"])
        {
            MLPQOneViewController* vc = [segue destinationViewController];
            vc.practiceMode = [sender boolValue];
            vc.previousResult=initialResult;
            vc.questionCount=1;
        }
        else if([[segue identifier]isEqualToString:@"PQTwo"])
        {
            MLPQTwoViewController* vc = [segue destinationViewController];
            vc.practiceMode = [sender boolValue];
            vc.previousResult=initialResult;
            vc.questionCount=1;
        }
        else if ([[segue identifier]isEqualToString:@"PQThree"])
        {
            MLPQThreeViewController* vc = [segue destinationViewController];
            vc.practiceMode = [sender boolValue];
            vc.previousResult=initialResult;
            vc.questionCount=1;
        }
    }
}

@end
