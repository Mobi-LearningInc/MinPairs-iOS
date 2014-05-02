//
//  MLStatSoundDelegate.h
//  MinPairs
//
//  Created by Brandon on 2014-05-02.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MLStatSoundDelegate <NSObject>
-(void)onSoundSelected:(NSUInteger)soundIndex;
@end
