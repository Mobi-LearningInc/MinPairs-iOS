//
//  MLLineGraphView.m
//  MinPairs
//
//  Created by Brandon on 2014-04-25.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLLineGraphView.h"
#import "MLGraphAxis.h"
#import "MLSettingDatabase.h"
#import "MLPair.h"
#import "MLCategory.h"
#import "MLTestResultDatabase.h"
@implementation MLLineGraphView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    return self;
}

-(void) awakeFromNib
{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    MLSettingDatabase* settingsDb = [[MLSettingDatabase alloc]initSettingDatabase];
    MLSettingsData* setting = [settingsDb getSetting];
    MLPair* pair =setting.settingFilterCatPair;
    MLCategory* catLeft = pair.first;
    MLCategory* catRight=pair.second;
    MLTestResultDatabase* testResultDb=[[MLTestResultDatabase alloc]initTestResultDatabase];
    NSArray* testResults=[testResultDb getTestResults];
    NSMutableArray* filteredResults=[NSMutableArray array];
    NSString* filterStr=[NSString stringWithFormat:@"%@|%@",catLeft.categoryDescription,catRight.categoryDescription];
    for (int i =0; i<testResults.count; i++)
    {
        MLTestResult* test = [testResults objectAtIndex:i];
        if([test.testExtra isEqualToString:filterStr])
        {
            [filteredResults addObject:test];
        }
    }
    for (int i=0; i<filteredResults.count; i++)
    {
        MLTestResult* t = [filteredResults objectAtIndex:i];
        float percentScore = ((float)t.testQuestionsCorrect)/((float)(t.testQuestionsCorrect+t.testQuestionsWrong))*100.0f;
        NSLog(@"Statistics score %f%%, time: %i(s) type:%@",percentScore, t.testTime, t.testType);
    }
    MLGraphics* graphics = [[MLGraphics alloc] init];
    
    MLGraphAxis* axis = [[MLGraphAxis alloc] initWithGraphics: graphics];
    
    [axis setxMin: 0];
    [axis setyMin: 0];
    [axis setxMax: 100];
    [axis setyMax: 100];
    [axis setxScale: 20];
    [axis setyScale: 20];
    
    [axis setPadding:5 withBottom:5 withLeft:10 withRight:10];
    [axis setAxisColour: [graphics CreateColour:1 withGreen:1 withBlue:1 withAlpha:1]];
    [axis draw];
}

@end
