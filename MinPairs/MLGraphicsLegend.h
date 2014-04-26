//
//  MLGraphicsLegend.h
//  MinPairs
//
//  Created by Brandon on 2014-04-25.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLGraphics.h"

@interface MLGraphicsLegend : NSObject

-(MLGraphicsLegend*)init:(MLGraphics*)graphics;

-(void) setOutlineColour:(Colour)outlineColour;

-(void) setOutlineColour:(float)R withGreen:(float)G withBlue:(float)B withAlpha:(float)A;

-(void) setBackgroundColour:(Colour)colour;

-(void) setBackgroundColour:(float)R withGreen:(float)G withBlue:(float)B withAlpha:(float)A;

-(void) setTitle:(NSString*)title withColour:(Colour)colour;

-(void) addItem:(NSString*)text withColour:(Colour)colour;

-(void) addItem:(NSString*)text withRed:(float)R withGreen:(float)G withBlue:(float)B withAlpha:(float)A;

-(void) setDimensions:(CGRect)rect;

-(void) setDimensions:(float)X withY:(float)Y withWidth:(float)Width withHeight:(float)Height;

-(void) draw;
@end
