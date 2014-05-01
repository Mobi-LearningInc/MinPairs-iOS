//
//  MLAllvsAllControllerViewController.m
//  MinPairs
//
//  Created by Brandon on 2014-04-26.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLPQOneViewController.h"
#import "MLPQTwoViewController.h"
#import "MLPQThreeViewController.h"
@interface MLPQOneViewController ()

@end

@implementation MLPQOneViewController

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
    self.sequeName=@"PQOne";
    
}
- (IBAction)onAnswerBtn:(id)sender
{
    // test values
    int corr=0;
    int wrong=1;
    int time = 41;
    self.currentResult =[[MLTestResult alloc]initTestResultWithCorrect:corr+self.previousResult.testQuestionsCorrect wrong:wrong+self.previousResult.testQuestionsWrong type:self.previousResult.testType date:self.previousResult.testDate timeInSec:time+self.previousResult.testTime extraInfo:self.previousResult.testExtra];
    [self onAnswer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
