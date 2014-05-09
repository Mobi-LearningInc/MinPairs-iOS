//
//  MLModalAnimator.h
//  MinPairs
//
//  Created by Brandon on 2014-05-09.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLModalAnimator : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) bool present;
@property (nonatomic, assign) float padding;
@end
