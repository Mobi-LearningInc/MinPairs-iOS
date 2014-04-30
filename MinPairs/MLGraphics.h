//
//  MLGraphics.h
//  MinPairs
//
//  Created by Brandon on 2014-04-25.
//  Copyright :(c) 2014 MobiLearning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

typedef CGContextRef Surface;
typedef UIColor* Colour;
typedef UIFont* Font;
typedef UIImage* Image;

typedef CGPathDrawingMode DrawingMode;
typedef CGTextDrawingMode TextDrawMode;
typedef CGBlendMode BlendMode;


/**
 *  Objective-C wrapper around the raw CoreGraphics API.
 *  Includes utility functions to make certain tasks easier.
 */
@interface MLGraphics : NSObject

-(Surface) getSurface;

-(void) setSurface:(Surface)surface;

-(Surface) GetCurrentSurface;

-(void) BeginDrawing;

-(void) EndDrawing;

-(void) EndDrawing:(DrawingMode) mode;

-(void) BeginPath;

-(void) EndPath;

-(void) FillPath;

-(void) StrokePath;

-(Colour) CreateColour:(float)R withGreen:(float)G withBlue:(float)B withAlpha:(float) A;

-(void) SetDrawingColour:(Colour)colour;

-(void) SetFillColour:(Colour)colour;

-(void) SetFillColour:(float)R withGreen:(float)G withBlue:(float)B withAlpha:(float)A;

-(void) SetStrokeColour:(Colour)colour;

-(void) SetStrokeColour:(float)R withGreen:(float)G withBlue:(float)B withAlpha:(float)A;

-(void) MoveTo:(float)X withY:(float)Y;

-(void) LineTo:(float)X withY:(float)Y;

-(void) SetLineEnds:(bool)round;

-(void) SetLineWidth:(float)width;

-(void) DrawLine:(float)X1 withY1:(float)Y1 withX2:(float)X2 withY2:(float)Y2;

-(void) DrawRect:(CGRect)rect withStyle:(bool)fill;

-(void) DrawRect:(float)X1 withY1:(float)Y1 withWidth:(float)Width withHeight:(float)Height withStyle:(bool)fill;

-(void) DrawRoundedRect:(float)radius withRect:(CGRect)rect withStyle:(bool)fill;

-(void) DrawRoundedRect:(float)radius withX1:(float)X1 withY1:(float)Y1 withWidth:(float)Width withHeight:(float)Height withStyle:(bool)fill;

-(void) DrawCircle:(float)X withY:(float)Y withRadius:(float)Radius withStyle:(bool)fill;

-(void) DrawEllipse:(CGRect)rect withStyle:(bool)fill;

-(void) DrawEllipse:(float)X1 withY1:(float)Y1 withWidth:(float)Width withHeight:(float)Height withStyle:(bool)fill;

-(void) ClearRect:(CGRect)rect;

-(void) ClearRect:(float)X1 withY1:(float)Y1 withWidth:(float)Width withHeight:(float)Height;

-(NSArray*) GetAllFonts;

-(Font) CreateFont:(NSString*)fontname withSize:(float)fontsize;

-(void) SetTextDrawingMode:(TextDrawMode) mode;

-(void) DrawText:(Font)font withColour:(Colour)colour withText:(NSString*)text withX:(float)X withY:(float)Y;

-(void) DrawAngledText:(Font)font withColour:(Colour)colour withText:(NSString*)text withAngle:(float)Degrees withX:(float)X withY:(float)Y;

-(Image) LoadImage:(NSString*)imagename;

-(Image) LoadImageFromFile:(NSString*)imagename;

-(void) DrawImage:(Image)image withX1:(float)X1 withY1:(float)Y1;

-(void) DrawImage:(Image)image withArea:(CGRect)rect;

-(void) DrawImage:(Image)image withX1:(float)X1 withY1:(float)Y1 withX2:(float)X2 withY2:(float)Y2;

-(void) RefreshView:(UIView*)view;

-(void) SetAntiAliasing:(bool)on;

-(void) SetFontSubPixelPositioning:(bool)on;

-(void) SetFontSmoothing:(bool)on;

-(CGSize) SizeFromString:(NSString*)text withFont:(Font)font;

-(void) RotateSurface:(float)degrees;

-(void) RotateSurfaceAroundPoint:(float)degrees withPoint:(CGPoint)point;

-(void) RotateSurfaceAroundPoint:(float)degrees withX:(float)X withY:(float)Y;

-(void) PushSurface;

-(void) PopSurface;

-(void) Flush;

@end
