//
//  MLStatisticsViewController.h
//  MinPairs
//
//  Created by Brandon on 2014-04-26.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLStatisticsViewController : UIViewController
@property (nonatomic, weak) NSArray* categories;
@property (nonatomic, assign) NSUInteger dropDownSelectedOption;
@property (nonatomic, assign) NSUInteger categoryIndex;
@property (nonatomic, strong) NSArray* testResults;
@property (nonatomic, strong) NSDate* minDate;
@property (nonatomic, strong) NSDate* maxDate;
@end
