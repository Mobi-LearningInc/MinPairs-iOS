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

+(void) setButtonRound:(UIButton*)button withRadius:(float)radius
{
    button.layer.cornerRadius = radius;
}

+(void) setButtonsRound:(UIView*)view withRadius:(float)radius
{
    for (UIView* v in [view subviews])
    {
        if ([v isKindOfClass:[UIButton class]])
        {
            ((UIButton*)v).layer.cornerRadius = radius;
        }
    }
}

+(void) setButtonBorder:(UIButton*)button withBorderWidth:(float)borderWidth withColour:(UIColor*)colour
{
    button.layer.borderWidth = borderWidth;
    button.layer.borderColor = [colour CGColor];
}

+(void) setButtonsBorder:(UIView*)view withBorderWidth:(float)borderWidth withColour:(UIColor*)colour
{
    for (UIView* v in [view subviews])
    {
        if ([v isKindOfClass:[UIButton class]])
        {
            ((UIButton*)v).layer.borderWidth = borderWidth;
            ((UIButton*)v).layer.borderColor = [colour CGColor];
        }
    }
}

+(UIImage*)imageWithColor:(UIImage*)img withColour:(UIColor*)colour
{
    UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, img.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGContextClipToMask(context, rect, img.CGImage);
    [colour setFill];
    CGContextFillRect(context, rect);
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
