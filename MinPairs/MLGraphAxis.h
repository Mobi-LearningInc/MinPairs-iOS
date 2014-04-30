//
//  MLGraphAxis.h
//  MinPairs
//
//  Created by Brandon on 2014-04-27.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLGraphics.h"
#import "MLPlatform.h"

@interface MLGraphAxis : NSObject

-(MLGraphAxis*) initWithGraphics:(MLGraphics*)graphics;

-(void) setxMin:(float)xMin;

-(void) setyMin:(float)yMin;

-(void) setxMax:(float)xMax;

-(void) setyMax:(float)yMax;

-(void) setxScale:(float)xScale;

-(void) setyScale:(float)yScale;

-(void) setAxisColour:(Colour)axisColour;

-(void) setPadding:(float)top withBottom:(float)bottom withLeft:(float)left withRight:(float)right;

-(void) draw;

@end
