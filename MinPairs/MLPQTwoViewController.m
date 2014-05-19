//
//  MLPQTwoViewController.m
//  MinPairs
//
//  Created by Brandon on 2014-04-26.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//
#import "MLPQOneViewController.h"
#import "MLPQTwoViewController.h"
#import "MLPQThreeViewController.h"

@interface MLPQTwoViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textAnswer;
@property (weak, nonatomic) IBOutlet UILabel *typeTimeLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UIImageView *statusImg;
@property (strong,nonatomic)MLItem* correctItem;
@property (weak, nonatomic) IBOutlet UIImageView *checkMarkImg;
@property (weak, nonatomic) IBOutlet UIButton *answerBtn;

@end

@implementation MLPQTwoViewController

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
    self.textAnswer.delegate = self;
    self.sequeName=@"PQTwo";
    int rand = arc4random_uniform(2);
    MLPair* itemPair =[self pickRandomItemPairPairForCategory:self.filterCatPair];

    self.correctItem=(rand==0)?itemPair.first:itemPair.second;
    NSLog(@"Correct item is %@",self.correctItem.itemDescription);
    [self registerQuizTimeLabelsAndEventSelectLabel:nil event:nil readLabel:nil event:nil typeLabel:self.typeTimeLabel event:^(void){
        MLTestResult* currentResult =[[MLTestResult alloc]initTestResultWithCorrect:0+self.previousResult.testQuestionsCorrect
            wrong:1+self.previousResult.testQuestionsWrong
            type:self.previousResult.testType
            date:self.previousResult.testDate
            timeInSec:self.timeCount+self.previousResult.testTime
            extraInfo:self.previousResult.testExtra];
        [self onAnswer:currentResult];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self onAnswerBtn:self.answerBtn];
    return NO;
}

- (IBAction)onPlayBtn:(id)sender
{
    [self playItem:self.correctItem];
    NSLog(@"Played sound for %@",self.correctItem.itemDescription);
}
- (IBAction)onAnswerBtn:(id)sender
{
    self.pauseTimer=YES;
    NSString* raw = self.textAnswer.text;
    NSString* noWS=[raw stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* cleanStr=[noWS lowercaseString];
    NSLog(@"User typed %@",cleanStr);
    int corr;
    int wrong;
    if([cleanStr isEqualToString: [self.correctItem.itemDescription lowercaseString] ])
    {
        corr=1;
        wrong=0;
        self.statusImg.image=[UIImage imageNamed:@"checkmark_plain_white"];
    }
    else
    {
        corr=0;
        wrong=1;
        self.statusImg.image=[UIImage imageNamed:@"xmark_plain_white"];
    }
    
    MLTestResult* currentResult =[[MLTestResult alloc]initTestResultWithCorrect:corr+self.previousResult.testQuestionsCorrect
        wrong:wrong+self.previousResult.testQuestionsWrong
        type:self.previousResult.testType
        date:self.previousResult.testDate
        timeInSec:self.timeCount+self.previousResult.testTime
        extraInfo:self.previousResult.testExtra];
    [sender setHidden: YES];
    [self.checkMarkImg setHidden:YES];
    [self performSelector:@selector(onAnswer:) withObject:currentResult afterDelay:2.0];
    //[self onAnswer:currentResult];
}
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    //hides keyboard
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
