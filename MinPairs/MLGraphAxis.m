//
//  MLGraphAxis.m
//  MinPairs
//
//  Created by Brandon on 2014-04-27.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLGraphAxis.h"


@interface MLGraphAxis ()
@property (nonatomic, weak) MLGraphics* graphics;
@property (nonatomic, assign) float xMin;
@property (nonatomic, assign) float yMin;
@property (nonatomic, assign) float xMax;
@property (nonatomic, assign) float yMax;
@property (nonatomic, assign) float xScale;
@property (nonatomic, assign) float yScale;
@property (nonatomic, strong) Colour axisColour;
@property (nonatomic, assign) float leftPad;
@property (nonatomic, assign) float rightPad;
@property (nonatomic, assign) float topPad;
@property (nonatomic, assign) float bottomPad;
@end

@implementation MLGraphAxis

-(MLGraphAxis*) initWithGraphics:(MLGraphics*)graphics
{
    if (self = [super init])
    {
        _graphics = graphics;
    }
    
    return self;
}

-(void) setxMin:(float)xMin
{
    _xMin = xMin;
}

-(void) setyMin:(float)yMin
{
    _yMin = yMin;
}

-(void) setxMax:(float)xMax
{
    _xMax = xMax;
}

-(void) setyMax:(float)yMax
{
    _yMax = yMax;
}

-(void) setxScale:(float)xScale
{
    _xScale = xScale;
}

-(void) setyScale:(float)yScale
{
    _yScale = yScale;
}

-(void) setAxisColour:(Colour)axisColour
{
    _axisColour = axisColour;
}

-(void) setPadding:(float)top withBottom:(float)bottom withLeft:(float)left withRight:(float)right
{
    self.leftPad = left;
    self.rightPad = right;
    self.topPad = top;
    self.bottomPad = bottom;
}

-(void) swap:(void*)a withB:(void*)b withSize:(size_t)size_of_type
{
    unsigned char T = 0;
    unsigned char* A = a;
    unsigned char* B = b;
    
    for (int I = 0; I < size_of_type; ++I)
    {
        T = A[I];
        A[I] = B[I];
        B[I] = T;
    }
}

-(void) draw
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    float width = screenRect.size.width;
    float height = screenRect.size.height;
    
    float x1 = [self leftPad] + 30;
    float y1 = [self topPad] + 30;
    float x2 = width - [self rightPad];
    float y2 = height - [self bottomPad] - 75;
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        x2 = height - [self rightPad];
        y2 = width - [self bottomPad] - 75;
    }
    
    /** Graph Title **/
    
    [[self graphics] PushSurface];
    [[self graphics] SetFontSmoothing: true];
    [[self graphics] SetFontSubPixelPositioning: true];
    Font titleFont = [[self graphics] CreateFont: @"Helvetica" withSize: 18.0f];
    [[self graphics] DrawText: titleFont withColour: [UIColor whiteColor] withText: @"Statistics" withX: ((x1 + x2) / 2.0f) - 40.0f withY: [self topPad]];
    [[self graphics] PopSurface];
    
    
    /** Draw Y-Axis Lines **/
    
    [[self graphics] SetLineWidth: 0.5f];
    [[self graphics] SetStrokeColour: [UIColor blackColor]];
    [[self graphics] SetFillColour: [UIColor blackColor]];
    [[self graphics] SetAntiAliasing: false];
    
    for (float yOffset = y2; yOffset > y1; yOffset -= [self yScale])
    {
        [[self graphics] BeginDrawing];
        [[self graphics] DrawLine: x1 + 5 withY1: yOffset withX2: x2 withY2: yOffset];
        [[self graphics] EndDrawing];
    }
    
    
    [[self graphics] SetLineWidth: 2.0f];
    [[self graphics] SetStrokeColour: [self axisColour]];
    [[self graphics] SetFillColour: [self axisColour]];
    Font axisFont = [[self graphics] CreateFont: @"Courier" withSize: 13.0f];
    
    /** Draw Y-Axis **/
    
    [[self graphics] BeginDrawing];
    [[self graphics] DrawLine: x1 withY1: y1 withX2: x1 withY2: y2 + 10];
    [[self graphics] EndDrawing];
    
    [[self graphics] PushSurface];
    [[self graphics] SetFontSmoothing: true];
    [[self graphics] SetFontSubPixelPositioning: true];
    [[self graphics] DrawAngledText: axisFont withColour: [self axisColour] withText: @"yAxis" withAngle: -90.0f withX: [self leftPad] withY: ((y1 + y2) / 2.0f) + 20.0f];
    [[self graphics] PopSurface];
    
    
    /** Draw Y-Axis Ticks **/
    
    for (float yOffset = y2; yOffset > y1; yOffset -= [self yScale])
    {
        [[self graphics] BeginDrawing];
        [[self graphics] DrawLine: x1 withY1: yOffset withX2: x1 + 5 withY2: yOffset];
        [[self graphics] EndDrawing];
    }
    
    
    /** Draw X-Axis **/
    
    [[self graphics] BeginDrawing];
    [[self graphics] DrawLine: x1 - 10 withY1: y2 withX2: x2 withY2: y2];
    [[self graphics] EndDrawing];
    
    [[self graphics] PushSurface];
    [[self graphics] SetFontSmoothing: true];
    [[self graphics] SetFontSubPixelPositioning: true];
    [[self graphics] DrawText: axisFont withColour: [self axisColour] withText: @"xAxis" withX: ((x1 + x2) / 2.0f) - 20 withY: y2 + [self bottomPad] + 10];
    [[self graphics] PopSurface];
    
    
    /** Draw X-Axis Ticks **/
    
    for (float xOffset = x1; xOffset < x2; xOffset += [self xScale])
    {
        [[self graphics] BeginDrawing];
        [[self graphics] DrawLine: xOffset withY1: y2 + 5 withX2: xOffset withY2: y2];
        [[self graphics] EndDrawing];
    }
}

@end
