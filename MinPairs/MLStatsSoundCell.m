//
//  MLStatsSoundCell.m
//  MinPairs
//
//  Created by Brandon on 2014-05-02.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLStatsSoundCell.h"

@interface MLStatsSoundCell()
@property (weak, nonatomic) IBOutlet UIButton* left;
@property (weak, nonatomic) IBOutlet UIButton* right;
@property (weak, nonatomic) NSString* leftSound;
@property (weak, nonatomic) NSString* rightSound;
@end

@implementation MLStatsSoundCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    return self;
}

-(void) setTitles:(NSString *)left withRight:(NSString *)right
{
    if (left)
    {
        [[self left] setTitle: left forState: UIControlStateNormal];
    }
    else
    {
        [[self left] removeFromSuperview];
    }
    
    if (right)
    {
        [[self right] setTitle: right forState: UIControlStateNormal];
    }
    else
    {
        [[self right] removeFromSuperview];
    }
}

- (IBAction)onButtonClicked:(UIButton *)sender
{
    bool left = sender == [self left];
    [_delegate onSoundSelected: left ? [self leftSound] : [self rightSound]];
}

-(void)setSounds:(NSString*)left withRight:(NSString*)right
{
    self.leftSound = left;
    self.rightSound = right;
}
@end
