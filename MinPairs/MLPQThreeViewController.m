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
@interface MLPQThreeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *leftPlayBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightPlayBtn;
@property (weak, nonatomic) IBOutlet MLButtonGroup *btnGroup;
@property (weak, nonatomic) IBOutlet UIButton *radioBtnLeft;
@property (weak, nonatomic) IBOutlet UIButton *radioBtnRight;
@property (strong,nonatomic) MLItem* itemLeft;
@property (strong,nonatomic) MLItem* itemRight;
@property (weak, nonatomic) IBOutlet UILabel *itemMainLable;
@property (strong,nonatomic) NSTimer * timer;
@property int timeCount;
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
    self.itemLeft=[self pickRandomItem:[self getItemsForCategory:self.catFromFilterLeft]];
    self.itemRight=[self pickRandomItem:[self getItemsForCategory:self.catFromFilterRight]];
    [self.radioBtnLeft setTitle:self.itemLeft.itemDescription forState:UIControlStateNormal];
    [self.radioBtnRight setTitle:self.itemRight.itemDescription forState:UIControlStateNormal];
    int rand = arc4random_uniform(2);
    self.itemMainLable.text = rand==0?self.itemLeft.itemDescription:self.itemRight.itemDescription;
    self.timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTick) userInfo:nil repeats:YES];
}
-(void)onTick
{
    self.timeCount++;
}
- (IBAction)onLeftPlayBtnTap:(id)sender
{
    [self playItem:self.itemLeft];
}
- (IBAction)onRightPlayBtnTap:(id)sender
{
    [self playItem:self.itemRight];
}
-(void)playItem:(MLItem*)item
{
    MLBasicAudioPlayer* audioPlayer = [[MLBasicAudioPlayer alloc]init];
    [audioPlayer loadFileFromResource:item.itemAudioFile withExtension: @"mp3"];
    [audioPlayer prepareToPlay];
    [audioPlayer play];
}
-(NSMutableArray*)getItemsForCategory:(MLCategory*)selectedCategory
{
    MLMainDataProvider* provider=[[MLMainDataProvider alloc]initMainProvider];
    NSArray* catItemPairs =[provider getCategoryItemPairs];
    NSMutableArray* wordArr = [NSMutableArray array];
    for(int i=0; i<catItemPairs.count; i++)
    {
        MLPair* pair = [catItemPairs objectAtIndex:i];
        MLCategory* cat = pair.first;
        if(cat.categoryId==selectedCategory.categoryId)
        {
            MLItem* word=pair.second;
            [wordArr addObject: word];
            
        }
    }
    return  wordArr;
}
-(MLItem*)pickRandomItem:(NSMutableArray*)items
{
    int rand = arc4random_uniform(items.count);
    return [items objectAtIndex:rand];
}
- (IBAction)onAnswerButton:(id)sender
{
    [self.timer invalidate];
    self.timer = nil;
    NSString* selectedString = self.btnGroup.selectedButton.currentTitle;
    int corr;
    int wrong;
    if([self.itemMainLable.text isEqualToString:selectedString])
    {
        corr=1;
        wrong=0;
    }
    else
    {
        corr=0;
        wrong=1;
    }
    NSLog(@"status : correct:%i, wrong:%i, time: %i",corr,wrong,self.timeCount);
    self.currentResult =[[MLTestResult alloc]initTestResultWithCorrect:corr+self.previousResult.testQuestionsCorrect wrong:wrong+self.previousResult.testQuestionsWrong type:self.previousResult.testType date:self.previousResult.testDate timeInSec:self.timeCount+self.previousResult.testTime extraInfo:self.previousResult.testExtra];
    [self onAnswer];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
