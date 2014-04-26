//
//  MLPickerView.m
//  MinPairs
//
//  Created by Brandon on 2014-04-26.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLPickerView.h"
#define FIXED_PICKER_HEIGHT 216.0f

@implementation MLPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setFrame:(CGRect)frame
{
    CGFloat targetHeight = frame.size.height;
    CGFloat scaleFactor = targetHeight / FIXED_PICKER_HEIGHT;
    frame.size.height = FIXED_PICKER_HEIGHT;
    self.transform = CGAffineTransformIdentity;
    [super setFrame:frame];
    frame.size.height = targetHeight;
    CGFloat dX=self.bounds.size.width/2, dY=self.bounds.size.height/2;
    self.transform = CGAffineTransformTranslate(CGAffineTransformScale(CGAffineTransformMakeTranslation(-dX, -dY), 1, scaleFactor), dX, dY);
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    CGFloat inverseScaleFactor = FIXED_PICKER_HEIGHT/self.frame.size.height;
    CGAffineTransform scale = CGAffineTransformMakeScale(1, inverseScaleFactor);
    view.transform = scale;
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
