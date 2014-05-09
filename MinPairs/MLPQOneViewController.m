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
@property (weak, nonatomic) IBOutlet UIButton *leftImgBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightImgBtn;
@property (strong,nonatomic) MLItem* itemLeft;
@property (strong,nonatomic) MLItem* itemRight;
@property (strong,nonatomic) MLItem* correctItem;
@property (weak, nonatomic) IBOutlet UILabel *selectTimeLabel;
@property BOOL leftSelected;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property BOOL rightSelected;
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
    int rSwap = arc4random_uniform(2);
    if (rSwap==0)
    {
        MLPair* itemPair =[self pickRandomItemPairPairForCategory:self.filterCatPair];
        self.itemLeft = itemPair.first;
        self.itemRight = itemPair.second;
    }
    else
    {
        MLPair* itemPair =[self pickRandomItemPairPairForCategory:self.filterCatPair];
        self.itemLeft = itemPair.second;
        self.itemRight = itemPair.first;
    }
    UIImage* imgLeft =([UIImage imageNamed:self.itemLeft.itemImageFile]==NULL)?[UIImage imageNamed:@"na1.png"]:[UIImage imageNamed:self.itemLeft.itemImageFile];
    UIImage* imgRight=([UIImage imageNamed:self.itemRight.itemImageFile]==NULL)?[UIImage imageNamed:@"na1.png"]:[UIImage imageNamed:self.itemRight.itemImageFile];
    [self.leftImgBtn setImage:imgLeft forState:UIControlStateNormal];
    [self.rightImgBtn setImage:imgRight forState:UIControlStateNormal];
    int rand = arc4random_uniform(2);
    MLItem* cor= rand==0?self.itemLeft:self.itemRight;
    self.correctItem=cor;
    NSLog(@"Correct item is %@",self.correctItem.itemDescription);
    self.leftSelected=true;
    self.rightSelected=false;
    [self performSelector:@selector(highlightBtn:) withObject:self.leftImgBtn afterDelay:0];
    [self registerQuizTimeLabelsAndEventSelectLabel:self.selectTimeLabel event:^(void){
        MLTestResult* currentResult =[[MLTestResult alloc]initTestResultWithCorrect:0+self.previousResult.testQuestionsCorrect
            wrong:1+self.previousResult.testQuestionsWrong
            type:self.previousResult.testType
            date:self.previousResult.testDate
            timeInSec:self.timeCount+self.previousResult.testTime
            extraInfo:self.previousResult.testExtra];
        [self onAnswer:currentResult];
    } readLabel:nil event:nil typeLabel:nil event:nil];
}
- (IBAction)onPlayBtn:(id)sender
{
    [self playItem:self.correctItem];
    NSLog(@"Played sound for %@",self.correctItem.itemDescription);
}
- (IBAction)onLeftImgBtnTap:(id)sender
{
    self.leftSelected=true;
    self.rightSelected=false;
    [self performSelector:@selector(highlightBtn:) withObject:self.leftImgBtn afterDelay:0];
    [self performSelector:@selector(unHighlightBtn:) withObject:self.rightImgBtn afterDelay:0];
}
- (IBAction)onRightImgBtnTap:(id)sender
{

    self.rightSelected=true;
    self.leftSelected=true;
    [self performSelector:@selector(highlightBtn:) withObject:self.rightImgBtn afterDelay:0];
    [self performSelector:@selector(unHighlightBtn:) withObject:self.leftImgBtn afterDelay:0];
}
- (void)highlightBtn:(UIButton*)btn
{
    [btn setHighlighted:YES];
}
- (void)unHighlightBtn:(UIButton*)btn
{
    [btn setHighlighted:NO];
}
- (IBAction)onAnswerBtn:(id)sender
{
    int corr;
    int wrong;
    MLItem* selected=self.leftSelected?self.itemLeft:self.itemRight;
    NSLog(@"User selected %@",selected.itemDescription);
    if(selected==self.correctItem)
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
