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

-(void) SetLineThickness:(float)Thickness;

-(void) DrawLine:(float)X1 withY1:(float)Y1 withX2:(float)X2 withY2:(float)Y2;

-(void) DrawBox:(CGRect)rect;

-(void) DrawBox:(float)X1 withY1:(float)Y1 withWidth:(float)Width withHeight:(float)Height;

-(void) DrawRoundedRect:(float)radius withRect:(CGRect)rect;

-(void) DrawRoundedRect:(float)radius withX1:(float)X1 withY1:(float)Y1 withWidth:(float)Width withHeight:(float)Height;

-(void) DrawCircle:(float)X withY:(float)Y withRadius:(float)Radius;

-(void) DrawEllipse:(CGRect)rect;

-(void) DrawEllipse:(float)X1 withY1:(float)Y1 withWidth:(float)Width withHeight:(float)Height;

-(void) ClearBox:(CGRect)rect;

-(void) ClearBox:(float)X1 withY1:(float)Y1 withWidth:(float)Width withHeight:(float)Height;

-(NSArray*) GetAllFonts;

-(Font) CreateFont:(NSString*)fontname withSize:(float)fontsize;

-(void) SetTextDrawingMode:(TextDrawMode) mode;

-(void) DrawText:(Font) font withText:(NSString*)text withX:(float)X withY:(float)Y;

-(Image) LoadImage:(NSString*)imagename;

-(Image) LoadImageFromFile:(NSString*)imagename;

-(void) DrawImage:(Image)image withX1:(float)X1 withY1:(float)Y1;

-(void) DrawImage:(Image)image withArea:(CGRect)rect;

-(void) DrawImage:(Image)image withX1:(float)X1 withY1:(float)Y1 withX2:(float)X2 withY2:(float)Y2;

-(void) RefreshView:(UIView*)view;

-(CGRect) RectFromString:(NSString*)text;

@end
