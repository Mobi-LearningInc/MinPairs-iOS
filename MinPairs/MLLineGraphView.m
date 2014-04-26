//
//  MLLineGraphView.m
//  MinPairs
//
//  Created by Brandon on 2014-04-25.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLLineGraphView.h"
#import "MLGraphicsLegend.h"

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

-(void) drawLegendTest:(MLGraphics*)graphics
{
    MLGraphicsLegend* legend = [[MLGraphicsLegend alloc] init: graphics];
    
    [legend setOutlineColour:0 withGreen:0 withBlue:0 withAlpha:0];
    [legend setBackgroundColour:224.0f/0xFF withGreen:224.0f/0xFF withBlue:224.0f/0xFF withAlpha: 0.5];
    //[legend setDimensions:225 withY:75 withWidth:75 withHeight:80];
    [legend setDimensions:20 withY:75 withWidth:75 withHeight:80];
    
    Colour titleColour = [graphics CreateColour:0 withGreen:0 withBlue:0 withAlpha:1];
    [legend setTitle:@"Legend" withColour: titleColour];
    [legend addItem:@"Item1" withRed:1 withGreen:0 withBlue:0 withAlpha:1];
    [legend addItem:@"Item2" withRed:0 withGreen:1 withBlue:0 withAlpha:1];
    [legend addItem:@"Item3" withRed:0 withGreen:0 withBlue:1 withAlpha:1];
    [legend draw];
}

-(void) drawTestGraph:(MLGraphics*)graphics withColour:(Colour)colour
{
    [graphics SetStrokeColour: colour];
    [graphics SetFillColour: colour];
    
    int height = self.frame.size.height;
    
    CGPoint testPoints[50];
    
    testPoints[0].x = 0;
    testPoints[0].y = height - (arc4random_uniform(20) + (arc4random_uniform(5) + 1) * (arc4random_uniform(4) + 3));
    
    for (int i = 1; i < sizeof(testPoints) / sizeof(CGPoint); ++i)
    {
        testPoints[i].x = testPoints[i - 1].x + (arc4random_uniform(5) + 1) * (arc4random_uniform(4) + 3);
        testPoints[i].y = height;
        
        int r = arc4random_uniform(10) * arc4random_uniform(10);
        
        if (r > 4)
            height -= r - arc4random_uniform(10);
        else
            height += r + arc4random_uniform(10);
    }
    
    for (int i = 0; i < sizeof(testPoints) / sizeof(CGPoint) - 1; ++i)
    {
        [graphics BeginDrawing];
        [graphics DrawLine:testPoints[i].x withY1:testPoints[i].y withX2:testPoints[i + 1].x withY2:testPoints[i + 1].y];
        [graphics EndDrawing];
        
        [graphics BeginDrawing];
        [graphics DrawCircle:testPoints[i].x withY:testPoints[i].y withRadius:2];
        [graphics EndDrawing];
    }
}

- (void)drawRect:(CGRect)rect
{
    MLGraphics* graphics = [[MLGraphics alloc] init];
    
    [self drawTestGraph:graphics withColour: [graphics CreateColour:1 withGreen:0 withBlue:0 withAlpha:1]];
    [self drawTestGraph:graphics withColour: [graphics CreateColour:0 withGreen:1 withBlue:0 withAlpha:1]];
    [self drawTestGraph:graphics withColour: [graphics CreateColour:0 withGreen:0 withBlue:1 withAlpha:1]];
    [self drawLegendTest: graphics];
}

@end
