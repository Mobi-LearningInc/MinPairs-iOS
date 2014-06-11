//
//  MLGraphics.m
//  MinPairs
//
//  Created by Brandon on 2014-04-25.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLGraphics.h"

@interface MLGraphics ()
@property (nonatomic, assign) Surface surface;
@end

@implementation MLGraphics


-(MLGraphics*) init	
{
    self = [super init];
    if (self)
    {
        _surface = [self GetCurrentSurface];
    }
    return self;
}

-(void) dealloc
{
    _surface = nil;
}

-(Surface) getSurface
{
    return _surface;
}

-(void) setSurface:(Surface)surface
{
    _surface = surface;
    if (_surface == nil)
    {
        _surface = [self GetCurrentSurface];
    }
}

-(Surface) GetCurrentSurface
{
    return UIGraphicsGetCurrentContext();
}

-(void) BeginDrawing
{
    CGContextBeginPath([self surface]);
}

-(void) EndDrawing
{
    CGContextClosePath([self surface]);
    CGContextDrawPath([self surface], kCGPathFillStroke);
}

-(void) EndDrawing:(DrawingMode) mode
{
    CGContextClosePath([self surface]);
    CGContextDrawPath([self surface], mode);
}

-(void) BeginPath
{
    CGContextBeginPath([self surface]);
}

-(void) EndPath
{
    CGContextClosePath([self surface]);
}

-(void) FillPath
{
    CGContextFillPath([self surface]);
}

-(void) StrokePath
{
    CGContextStrokePath([self surface]);
}

-(Colour) CreateColour:(float)R withGreen:(float)G withBlue:(float)B withAlpha:(float) A
{
    return [[UIColor alloc] initWithRed:R green: G blue: B alpha: A];
}

-(void) SetDrawingColour:(Colour)colour
{
    [colour set];
}

-(void) SetFillColour:(Colour)colour
{
    CGFloat R = 0, G = 0, B = 0, A = 0;
    [colour getRed: &R green: &G blue: &B alpha: &A];
    CGContextSetRGBFillColor([self surface], R, G, B, A);
}

-(void) SetFillColour:(float)R withGreen:(float)G withBlue:(float)B withAlpha:(float)A
{
    CGContextSetRGBFillColor([self surface], R, G, B, A);
}

-(void) SetStrokeColour:(Colour)colour
{
    CGFloat R = 0, G = 0, B = 0, A = 0;
    [colour getRed: &R green: &G blue: &B alpha: &A];
    CGContextSetRGBStrokeColor([self surface], R, G, B, A);
}

-(void) SetStrokeColour:(float)R withGreen:(float)G withBlue:(float)B withAlpha:(float)A
{
    CGContextSetRGBStrokeColor([self surface], R, G, B, A);
}

-(void) MoveTo:(float)X withY:(float)Y
{
    CGContextMoveToPoint([self surface], X, Y);
}

-(void) LineTo:(float)X withY:(float)Y
{
    CGContextAddLineToPoint([self surface], X, Y);
}

-(void) SetLineEnds:(bool)round
{
    CGContextSetLineCap([self surface], round ? kCGLineCapRound : kCGLineCapSquare);
}

-(void) SetLineWidth:(float)width
{
    CGContextSetLineWidth([self surface], width);
}

-(void) DrawLine:(float)X1 withY1:(float)Y1 withX2:(float)X2 withY2:(float)Y2
{
    CGContextMoveToPoint([self surface], X1, Y1);
    CGContextAddLineToPoint([self surface], X2, Y2);
}

-(void) DrawRect:(CGRect)rect withStyle:(bool)fill
{
    if (fill)
    {
        CGContextFillRect([self surface], rect);
    }
    else
    {
        CGContextStrokeRect([self surface], rect);
    }
}

-(void) DrawRect:(float)X1 withY1:(float)Y1 withWidth:(float)Width withHeight:(float)Height withStyle:(bool)fill;
{
    [self DrawRect: CGRectMake(X1, Y1, Width, Height) withStyle: fill];
}

-(void) DrawRoundedRect:(float)radius withRect:(CGRect)rect withStyle:(bool)fill
{
    if (fill)
    {
        [[UIBezierPath bezierPathWithRoundedRect: rect cornerRadius: radius] fill];
    }
    else
    {
        [[UIBezierPath bezierPathWithRoundedRect: rect cornerRadius: radius] stroke];
    }
}

-(void) DrawRoundedRect:(float)radius withX1:(float)X1 withY1:(float)Y1 withWidth:(float)Width withHeight:(float)Height withStyle:(bool)fill
{
    [self DrawRoundedRect: radius withRect: CGRectMake(X1, Y1, Width, Height) withStyle: fill];
}

-(void) DrawCircle:(float)X withY:(float)Y withRadius:(float)Radius withStyle:(bool)fill
{
    float X1  = X - Radius;
    float Y1 = Y - Radius;
    float X2 = X + Radius;
    float Y2 = Y + Radius;
    [self DrawEllipse:CGRectMake(X1, Y1, X2 - X1, Y2 - Y1) withStyle: fill];
}

-(void) DrawEllipse:(CGRect)rect withStyle:(bool)fill
{
    [self DrawEllipse: rect.origin.x withY1:rect.origin.y withWidth: rect.size.width withHeight: rect.size.height withStyle: fill];
}

-(void) DrawEllipse:(float)X1 withY1:(float)Y1 withWidth:(float)Width withHeight:(float)Height withStyle:(bool)fill
{
    if (fill)
    {
        CGContextFillEllipseInRect([self surface], CGRectMake(X1, Y1, Width, Height));
    }
    else
    {
        CGContextStrokeEllipseInRect([self surface], CGRectMake(X1, Y1, Width, Height));
    }
}

-(void) ClearRect:(CGRect)rect
{
    CGContextClearRect([self surface], rect);
}

-(void) ClearRect:(float)X1 withY1:(float)Y1 withWidth:(float)Width withHeight:(float)Height
{
    CGContextClearRect([self surface], CGRectMake(X1, Y1, Width, Height));
}

-(NSArray*) GetAllFonts
{
    return [UIFont familyNames];
}

-(Font) CreateFont:(NSString*)fontname withSize:(float)fontsize
{
    return [UIFont fontWithName:fontname size:fontsize];
}

-(void) SetTextDrawingMode:(TextDrawMode) mode
{
    CGContextSetTextDrawingMode([self surface], mode);
}

-(void) DrawText:(Font)font withColour:(Colour)colour withText:(NSString*)text withX:(float)X withY:(float)Y
{
    float system_version = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (system_version >= 7.0)
    {
        [text drawAtPoint: CGPointMake(X, Y) withAttributes: @{NSFontAttributeName: font, NSForegroundColorAttributeName: colour}];
    }
    else
    {
        [self SetStrokeColour: colour];
        [self SetFillColour: colour];
        [text drawAtPoint: CGPointMake(X, Y) withFont: font];
    }
}

-(void) DrawAngledText:(Font)font withColour:(Colour)colour withText:(NSString*)text withAngle:(float)Degrees withX:(float)X withY:(float)Y
{
    [self RotateSurfaceAroundPoint:Degrees withX: X withY: Y];
    [self DrawText: font withColour: colour withText: text withX: X withY: Y];
}

-(Image) LoadImage:(NSString*)imagename
{
    return [[UIImage alloc] initWithContentsOfFile: imagename];
}

-(Image) LoadImageFromFile:(NSString*)imagename
{
    return [UIImage imageNamed: imagename];
}

-(void) DrawImage:(Image)image withX1:(float)X1 withY1:(float)Y1
{
    [image drawAtPoint: CGPointMake(X1, Y1)];
}

-(void) DrawImage:(Image)image withArea:(CGRect)rect
{
    [image drawInRect: rect];
}

-(void) DrawImage:(Image)image withX1:(float)X1 withY1:(float)Y1 withX2:(float)X2 withY2:(float)Y2
{
    [image drawInRect: CGRectMake(X1, Y1, X2, Y2)];
}

-(void) RefreshView:(UIView*)view
{
    [view setNeedsDisplay];
}

-(void) SetAntiAliasing:(bool)on
{
    CGContextSetShouldAntialias([self surface], on);
}

-(void) SetFontSubPixelPositioning:(bool)on
{
    CGContextSetShouldSubpixelPositionFonts([self surface], on);
}

-(void) SetFontSmoothing:(bool)on
{
    CGContextSetShouldSmoothFonts([self surface], on);
}

-(CGSize) SizeFromString:(NSString*)text withFont:(Font)font
{
    return [text sizeWithAttributes: @{NSFontAttributeName: font}];
}

-(void) RotateSurface:(float)degrees
{
    CGContextRotateCTM([self surface], degrees * M_PI / 180.0f);
}

-(void) RotateSurfaceAroundPoint:(float)degrees withPoint:(CGPoint)point
{
    CGContextTranslateCTM([self surface], point.x, point.y);
    CGAffineTransform transform = CGAffineTransformMakeRotation(degrees * M_PI / 180.0f);
    CGContextConcatCTM([self surface], transform);
    CGContextTranslateCTM([self surface], -point.x, -point.y);
}

-(void) RotateSurfaceAroundPoint:(float)degrees withX:(float)X withY:(float)Y
{
    [self RotateSurfaceAroundPoint: degrees withPoint: CGPointMake(X, Y)];
}

-(void) PushSurface
{
    CGContextSaveGState([self surface]);
}

-(void) PopSurface
{
    CGContextRestoreGState([self surface]);
}

-(void) Flush
{
    CGContextFlush([self surface]);
}

@end
