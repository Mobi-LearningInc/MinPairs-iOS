//
//  MLLineGraphView.m
//  MinPairs
//
//  Created by Brandon on 2014-04-25.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLLineGraphView.h"
#import "MLGraphAxis.h"
#import "MLTestResult.h"

@interface MLLineGraphView()
@end

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
    self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    
    MLGraphics* graphics = [[MLGraphics alloc] init];
    MLGraphAxis* axis = [[MLGraphAxis alloc] initWithGraphics: graphics];
    
    [axis setxMin: 0];
    [axis setyMin: 0];
    [axis setxMax: 10];
    [axis setyMax: 10];
    [axis setxScale: 10];
    [axis setyScale: 10];
    [axis setxAxisTitle: @"Day"];
    [axis setyAxisTitle: @"Score"];
    
    [axis setPadding:5 withBottom:5 withLeft:10 withRight:10];
    [axis setAxisColour: [graphics CreateColour:1 withGreen:1 withBlue:1 withAlpha:1]];
    [axis draw: rect];
    
    @synchronized([self testData])
    {
        if ([self testData])
        {
            [axis drawPoints: rect withData: [self testData]];
        }
    }
}

@end
