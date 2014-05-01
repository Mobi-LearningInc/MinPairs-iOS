//
//  MLPQBaseViewController.m
//  MinPairs
//
//  Created by Oleksiy Martynov on 4/30/14.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLPQBaseViewController.h"
#import "MLPQOneViewController.h"
#import "MLPQTwoViewController.h"
#import "MLPQThreeViewController.h"
#import "MLTestResultDatabase.h"
#import "MLSettingDatabase.h"
@interface MLPQBaseViewController ()


@end

@implementation MLPQBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self.questionCount==0)//Show instrustion on first msg
    {
    NSString* modeStr = [NSString stringWithFormat: @"You are currently in: %s mode.", [self practiceMode] ? "PracticeMode" : "QuizMode."];
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Notice" message:modeStr delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
    }
    UIBarButtonItem *quitBtn = [[UIBarButtonItem alloc] initWithTitle:@"Quit" style:UIBarButtonItemStyleBordered target:self action:@selector(onQuitBtn)];
    self.navigationItem.leftBarButtonItem=quitBtn;
    MLSettingDatabase * settingDB= [[MLSettingDatabase alloc]initSettingDatabase];
    MLSettingsData* setting= [settingDB getSetting];
    MLPair* pair = setting.settingFilterCatPair;
    self.catFromFilterLeft=pair.first;
    self.catFromFilterRight=pair.second;
    NSString* titleStr = [NSString stringWithFormat:@"%@ vs %@", self.catFromFilterLeft.categoryDescription, self.catFromFilterRight.categoryDescription];
    self.title =titleStr;
    self.controllerArray=[NSMutableArray arrayWithObjects:@"PQOne",@"PQTwo",@"PQThree", nil];
}
-(void)onQuitBtn
{
    NSLog(@"Quit called");
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Quit" message:@"Are you sure you want to quit? All progress will be lost." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",@"Cancel", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)onAnswer
{
    if(self.currentResult)
    {
    if (self.questionCount+1>ML_MLPQBASE_QUESTION_LIMIT)
    {
        [self saveResultAndReturnHome];
    }
    else
    {
    [self pushSequeOnStack: [NSNumber numberWithBool: [self.previousResult.testType isEqualToString:ML_TEST_TYPE_PRACTICE]?true:false]];
    }
    }
    else
    {
        NSLog(@"Classes inheriting from MLPQBaseViewCOntroller must set currentResult before calling onAnswer!");
    }
}
-(void) pushSequeOnStack:(NSNumber*)mode
{
    NSMutableArray* workArr = [NSMutableArray array];
    for (int i =0; i<self.controllerArray.count; i++)
    {
        if (![[self.controllerArray objectAtIndex:i]isEqualToString:self.sequeName])
        {
            [workArr addObject:[self.controllerArray objectAtIndex:i]];
        }
    }
    int range=workArr.count;
    unsigned int r = arc4random_uniform(range);
    [self performSegueWithIdentifier:[workArr objectAtIndex:r] sender: mode];
}
-(void)saveResultAndReturnHome
{

    MLTestResultDatabase* resultDb = [[MLTestResultDatabase alloc]initTestResultDatabase];
    [resultDb saveTestResult:self.currentResult];
    NSString* msgTitle =[NSString stringWithFormat:@"%@ results",self.currentResult.testType];
    NSString* msgBody = [NSString stringWithFormat:@"Test result : \nQuestions Correct: %i,\nQuestions Wrong:%i,\n Time: %i",self.currentResult.testQuestionsCorrect,self.currentResult.testQuestionsWrong,self.currentResult.testTime];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:msgTitle message:msgBody delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    
    if([[segue identifier]isEqualToString:@"PQOne"])
    {
        MLPQOneViewController* vc = [segue destinationViewController];
        vc.practiceMode = [sender boolValue];
        vc.questionCount=++self.questionCount;;
        vc.previousResult=self.currentResult;
    }
    else if([[segue identifier]isEqualToString:@"PQTwo"])
    {
        MLPQTwoViewController* vc = [segue destinationViewController];
        vc.practiceMode = [sender boolValue];
        vc.questionCount=++self.questionCount;;
        vc.previousResult=self.currentResult;
    }
    else if ([[segue identifier]isEqualToString:@"PQThree"])
    {
        MLPQThreeViewController* vc = [segue destinationViewController];
        vc.practiceMode = [sender boolValue];
        vc.questionCount=++self.questionCount;;
        vc.previousResult=self.currentResult;
    }
}

@end
