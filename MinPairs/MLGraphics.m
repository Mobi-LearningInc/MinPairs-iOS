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
    float R = 0, G = 0, B = 0, A = 0;
    [colour getRed: &R green: &G blue: &B alpha: &A];
    CGContextSetRGBFillColor([self surface], R, G, B, A);
}

-(void) SetFillColour:(float)R withGreen:(float)G withBlue:(float)B withAlpha:(float)A
{
    CGContextSetRGBFillColor([self surface], R, G, B, A);
}

-(void) SetStrokeColour:(Colour)colour
{
    float R = 0, G = 0, B = 0, A = 0;
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

-(void) SetLineThickness:(float)Thickness
{
    CGContextSetLineWidth([self surface], Thickness);
}

-(void) DrawLine:(float)X1 withY1:(float)Y1 withX2:(float)X2 withY2:(float)Y2
{
    CGContextMoveToPoint([self surface], X1, Y1);
    CGContextAddLineToPoint([self surface], X2, Y2);
}

-(void) DrawBox:(CGRect) rect
{
    [self DrawBox: rect.origin.x withY1: rect.origin.y withWidth: rect.size.width withHeight: rect.size.height];
}

-(void) DrawBox:(float)X1 withY1:(float)Y1 withWidth:(float)Width withHeight:(float)Height;
{
    CGContextMoveToPoint([self surface], X1, Y1);
    CGContextAddLineToPoint([self surface], X1 + Width, Y1);
    CGContextAddLineToPoint([self surface], X1 + Width, Y1 + Height);
    CGContextAddLineToPoint([self surface], X1, Y1 + Height);
    CGContextAddLineToPoint([self surface], X1, Y1);
}

-(void) DrawRoundedRect:(float)radius withRect:(CGRect)rect
{
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect: rect cornerRadius: radius];
    [path fill];
    [path stroke];
}

-(void) DrawRoundedRect:(float)radius withX1:(float)X1 withY1:(float)Y1 withWidth:(float)Width withHeight:(float)Height
{
    [self DrawRoundedRect: radius withRect: CGRectMake(X1, Y1, Width, Height)];
}

-(void) DrawCircle:(float)X withY:(float)Y withRadius:(float)Radius
{
    float X1  = X - Radius;
    float Y1 = Y - Radius;
    float X2 = X + Radius;
    float Y2 = Y + Radius;
    
    CGRect bounds = CGRectMake(X1, Y1, X2 - X1, Y2 - Y1);
    //bounds = CGRectInset(bounds, Radius / 2, Radius / 2);
    CGContextAddEllipseInRect([self surface], bounds);
}

-(void) DrawEllipse:(CGRect)rect
{
    [self DrawEllipse: rect.origin.x withY1:rect.origin.y withWidth: rect.size.width withHeight: rect.size.height];
}

-(void) DrawEllipse:(float)X1 withY1:(float)Y1 withWidth:(float)Width withHeight:(float)Height
{
    CGContextAddEllipseInRect([self surface], CGRectMake(X1, Y1, Width, Height));
}

-(void) ClearBox:(CGRect)rect
{
    CGContextClearRect([self surface], rect);
}

-(void) ClearBox:(float)X1 withY1:(float)Y1 withWidth:(float)Width withHeight:(float)Height
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

-(void) DrawText:(Font) font withText:(NSString*)text withX:(float)X withY:(float)Y
{
    [text drawAtPoint: CGPointMake(X, Y) withFont: font];
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

-(CGRect) RectFromString:(NSString*)text
{
    return CGRectFromString(text);
}

@end
