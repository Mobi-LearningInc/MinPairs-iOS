//
//  MLButtonGroup.m
//  MinPairs
//
//  Created by Brandon on 2014-04-25.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLButtonGroup.h"

@interface MLButtonGroup()
@property (nonatomic, strong) NSMutableArray* buttons;
@end

@implementation MLButtonGroup

-(NSMutableArray*) buttons
{
    if (!_buttons)
    {
        _buttons = [[NSMutableArray alloc] init];
    }
    return _buttons;
}

-(void) updateGroupButtons
{
    [[self buttons] removeAllObjects];
    
    for (UIView* view in [self subviews])
    {
        if ([view isKindOfClass: [UIButton class]])
        {
            [(UIButton*)view removeTarget: self action: @selector(onTouch:) forControlEvents: UIControlEventTouchDown];
            [(UIButton*)view addTarget: self action: @selector(onTouch:) forControlEvents: UIControlEventTouchDown];
            
            [[self buttons] addObject: view];
        }
        else
        {
            [view removeFromSuperview];
        }
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self updateGroupButtons];
    }
    return self;
}

-(void) awakeFromNib
{
    [self updateGroupButtons];
}

- (void) onTouch:(UIButton*)sender;
{
    [sender setSelected: true];
    
    for (UIButton* button in [self buttons])
    {
        if (button != sender)
        {
            [button setSelected: false];
        }
    }
}

-(int) selectedIndex
{
    for (int i = 0; i < [[self buttons] count]; ++i)
    {
        if ([[[self buttons] objectAtIndex: i] isSelected])
        {
            return i;
        }
    }
    return -1;
}

-(void) setSelected:(unsigned int)index
{
    if (index < [[self buttons] count])
    {
        [self onTouch: [[self buttons] objectAtIndex: index]];
    }
}

-(UIButton*) selectedButton
{
    for (UIButton* button in [self buttons])
    {
        if ([button isSelected])
        {
            return button;
        }
    }
    return nil;
}
@end
