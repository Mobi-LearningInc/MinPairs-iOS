//
//  MLButtonGroup.h
//  MinPairs
//
//  Created by Brandon on 2014-04-25.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLButtonGroup : UIView
-(int) selectedIndex;
-(void) setSelected:(unsigned int)index;
-(UIButton*) selectedButton;
@end