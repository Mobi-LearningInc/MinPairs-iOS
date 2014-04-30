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

+(UIColor*)blackColor;
+(UIColor*)darkGrayColor;
+(UIColor*)lightGrayColor;
+(UIColor*)whiteColor;
+(UIColor*)grayColor;
+(UIColor*)redColor;
+(UIColor*)greenColor;
+(UIColor*)blueColor;
+(UIColor*)cyanColor;
+(UIColor*)yellowColor;
+(UIColor*)magentaColor;
+(UIColor*)orangeColor;
+(UIColor*)purpleColor;
+(UIColor*)brownColor;
+(UIColor*)clearColor;
@end
