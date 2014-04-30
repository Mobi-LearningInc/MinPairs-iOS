//
//  MLPlatform.m
//  MinPairs
//
//  Created by Brandon on 2014-04-30.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLPlatform.h"

@implementation MLPlatform

+(bool) isIPad
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

+(bool) isIPhone
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
}

+(float) getMajorSystemVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+(float) getMinorSystemVersion
{
    NSArray* res = [[[UIDevice currentDevice] systemVersion] componentsSeparatedByString: @"."];
    return [res count] > 1 ? [[res objectAtIndex: 1] floatValue] : 0.0f;
}

+(NSString*) getSystemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+(UIColor*)blackColor
{
    return [UIColor colorWithRed: 0.0f green: 0.0f blue: 0.0f alpha: 1.0f];
}

+(UIColor*)darkGrayColor
{
    return [UIColor colorWithRed: 0.333f green: 0.333f blue: 0.333f alpha: 1.0f];
}

+(UIColor*)lightGrayColor
{
    return [UIColor colorWithRed: 0.667f green: 0.667f blue: 0.667f alpha: 1.0f];
}

+(UIColor*)whiteColor
{
    return [UIColor colorWithRed: 1.0f green:1.0f blue:1.0f alpha:1.0f];
}

+(UIColor*)grayColor
{
    return [UIColor colorWithRed: 0.5f green: 0.5f blue: 0.5f alpha: 1.0f];
}

+(UIColor*)redColor
{
    return [UIColor colorWithRed: 1.0f green: 0.0f blue: 0.0f alpha: 1.0f];
}

+(UIColor*)greenColor
{
    return [UIColor colorWithRed: 0.0f green: 1.0f blue: 0.0f alpha: 1.0f];
}

+(UIColor*)blueColor
{
    return [UIColor colorWithRed: 0.0f green: 0.0f blue: 1.0f alpha: 1.0f];
}

+(UIColor*)cyanColor
{
    return [UIColor colorWithRed: 0.0f green: 1.0f blue: 1.0f alpha: 1.0f];
}

+(UIColor*)yellowColor
{
    return [UIColor colorWithRed: 1.0f green: 1.0f blue: 0.0f alpha: 1.0f];
}

+(UIColor*)magentaColor
{
    return [UIColor colorWithRed: 1.0f green: 0.0f blue: 1.0f alpha: 1.0f];
}

+(UIColor*)orangeColor
{
    return [UIColor colorWithRed: 1.0f green: 0.5f blue: 0.0f alpha: 1.0f];
}

+(UIColor*)purpleColor
{
    return [UIColor colorWithRed: 0.5f green: 0.0f blue: 0.5f alpha: 1.0f];
}

+(UIColor*)brownColor
{
    return [UIColor colorWithRed: 0.6f green: 0.4f blue: 0.2f alpha: 1.0f];
}

+(UIColor *)clearColor
{
    return [UIColor colorWithRed: 0.0f green: 0.0f blue: 0.0f alpha: 0.0f];
}
@end
