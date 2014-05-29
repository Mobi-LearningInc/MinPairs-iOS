//
//  MLStatsTabBarViewController.h
//  MinPairs
//
//  Created by Brandon on 2014-05-25.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLStatsTabBarViewController : UITabBarController
@property (nonatomic, strong) NSMutableDictionary* barGraphResults;
@property (nonatomic, strong) NSMutableDictionary* lineGraphResults;
@end
