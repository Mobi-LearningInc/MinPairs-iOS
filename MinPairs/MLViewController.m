//
//  MLViewController.m
//  MinPairs
//
//  Created by ituser on 4/23/2014.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLViewController.h"
#import "MLPQOneViewController.h"
#import "MLPQTwoViewController.h"
#import "MLPQThreeViewController.h"
#import "MLSettingDatabase.h"
#import "MLCategory.h"
#import "MLTestResultDatabase.h"
@interface MLViewController ()
@property int practiceQuestionCount;
@property int quizQuestionCount;
@end

@implementation MLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"p count %i",self.practiceQuestionCount++);
    //testing settings
    MLSettingDatabase* sDB = [[MLSettingDatabase alloc]initSettingDatabase];
    MLSettingsData* setting=[sDB getSetting];
    MLCategory* catL=setting.settingFilterCatPair.first;
    MLCategory* catR=setting.settingFilterCatPair.second;
    NSLog(@"setting data : times(%i%i%i) filter(%i,%i)",setting.settingTimeSelect,setting.settingTimeRead,setting.settingTimeType,catL.categoryId,catR.categoryId);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPracticeClicked:(UIButton *)sender
{
    [self pushSequeOnStack: [NSNumber numberWithBool: true]];
}

- (IBAction)onQuizzesClicked:(UIButton *)sender
{
    [self pushSequeOnStack: [NSNumber numberWithBool: false]];
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
