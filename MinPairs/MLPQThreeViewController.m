//
//  MLPQThreeViewController.m
//  MinPairs
//
//  Created by Brandon on 2014-04-26.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLPQThreeViewController.h"
#import "MLPQTwoViewController.h"
#import "MLPQOneViewController.h"
#import "MLButtonGroup.h"
#import "MLItem.h"
#import "MLCategory.h"
#import "MLPair.h"
#import "MLMainDataProvider.h"
#import "MLBasicAudioPlayer.h"
#import "MLTestResult.h"
@interface MLPQThreeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *leftPlayBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightPlayBtn;
@property (weak, nonatomic) IBOutlet MLButtonGroup *btnGroup;
@property (weak, nonatomic) IBOutlet UIButton *radioBtnLeft;
@property (weak, nonatomic) IBOutlet UIButton *radioBtnRight;
@property (strong,nonatomic) MLItem* itemLeft;
@property (strong,nonatomic) MLItem* itemRight;
@property (weak, nonatomic) IBOutlet UILabel *itemMainLable;
@property (weak, nonatomic) IBOutlet UILabel *readTimeLabel;

@property (strong, nonatomic)MLItem* correctAnswer;
@end

@implementation MLPQThreeViewController

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
    self.sequeName=@"PQThree";
    int rSwap = arc4random_uniform(2);
    if (rSwap==0)
    {
        self.itemLeft=[self pickRandomItem:[self getItemsForCategory:self.catFromFilterLeft]];
        self.itemRight=[self pickRandomItem:[self getItemsForCategory:self.catFromFilterRight]];
    }
    else
    {
        self.itemRight=[self pickRandomItem:[self getItemsForCategory:self.catFromFilterLeft]];
        self.itemLeft=[self pickRandomItem:[self getItemsForCategory:self.catFromFilterRight]];
    }
    [self.radioBtnLeft setTitle:@"pick left" forState:UIControlStateNormal];
    [self.radioBtnRight setTitle:@"pick right" forState:UIControlStateNormal];
    int rand = arc4random_uniform(2);
    MLItem* cor= rand==0?self.itemLeft:self.itemRight;
    self.itemMainLable.text=cor.itemDescription;
    self.correctAnswer=cor;
    NSLog(@"Correct answer is %@",self.correctAnswer.itemDescription);
    [self registerQuizTimeLabelsAndEventSelectLabel:nil event:nil readLabel:self.readTimeLabel event:^(void){
        MLTestResult* currentResult =[[MLTestResult alloc]initTestResultWithCorrect:0+self.previousResult.testQuestionsCorrect
             wrong:1+self.previousResult.testQuestionsWrong
             type:self.previousResult.testType
             date:self.previousResult.testDate
            timeInSec:self.timeCount+self.previousResult.testTime
             extraInfo:self.previousResult.testExtra];
        [self onAnswer:currentResult];
    } typeLabel:nil event:nil];
}

- (IBAction)onLeftPlayBtnTap:(id)sender
{
    [self playItem:self.itemLeft];
    NSLog(@"Played sound for %@",self.itemLeft.itemDescription);
}
- (IBAction)onRightPlayBtnTap:(id)sender
{
    [self playItem:self.itemRight];
    NSLog(@"Played sound for %@",self.itemRight.itemDescription);
}

- (IBAction)onAnswerButton:(id)sender
{
    
    int corr;
    int wrong;
    MLItem* selected =(self.btnGroup.selectedIndex==0)?self.itemLeft:self.itemRight;
    NSLog(@"User selected %@",selected.itemDescription);
    if(self.correctAnswer==selected)
    {
        corr=1;
        wrong=0;
    }
    else
    {
        corr=0;
        wrong=1;
    }
    MLTestResult* currentResult =[[MLTestResult alloc]initTestResultWithCorrect:corr+self.previousResult.testQuestionsCorrect wrong:wrong+self.previousResult.testQuestionsWrong type:self.previousResult.testType date:self.previousResult.testDate timeInSec:self.timeCount+self.previousResult.testTime extraInfo:self.previousResult.testExtra];
    [self onAnswer:currentResult];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
