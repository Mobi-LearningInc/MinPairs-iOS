//
//  MLStatsSoundCell.h
//  MinPairs
//
//  Created by Brandon on 2014-05-02.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLStatSoundDelegate.h"

@interface MLStatsSoundCell : UITableViewCell
@property (nonatomic, strong) id<MLStatSoundDelegate> delegate;

-(void)setTitles:(NSString*)left withRight:(NSString*)right;
-(void)setSounds:(NSString*)left withRight:(NSString*)right;
@end
