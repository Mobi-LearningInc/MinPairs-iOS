//
//  MLPlatform.h
//  MinPairs
//
//  Created by Brandon on 2014-04-30.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  To abstract away all the platform specific stuff in the SDK ={
 **/
@interface MLPlatform : NSObject
+(bool) isIPad;
+(bool) isIPhone;
+(float) getMajorSystemVersion;
+(float) getMinorSystemVersion;
+(NSString*) getSystemVersion;
+(void) setButtonRound:(UIButton*)button withRadius:(float)radius;
+(void) setButtonsRound:(UIView*)view withRadius:(float)radius;
+(void) setButtonBorder:(UIButton*)button withBorderWidth:(float)borderWidth withColour:(UIColor*)colour;
+(void) setButtonsBorder:(UIView*)view withBorderWidth:(float)borderWidth withColour:(UIColor*)colour;
@end
