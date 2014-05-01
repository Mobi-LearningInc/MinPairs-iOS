//
//  MLPQBaseViewController.h
//  MinPairs
//
//  Created by Oleksiy Martynov on 4/30/14.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLTestResult.h"
#import "MLCategory.h"
#define ML_MLPQBASE_QUESTION_LIMIT 10
@interface MLPQBaseViewController : UIViewController <UIAlertViewDelegate>
@property (nonatomic, assign) bool practiceMode;//set on segue
@property int questionCount;//set on segue
@property (strong,nonatomic) MLTestResult* previousResult;//set on segue
@property MLTestResult* currentResult;//set in child
@property MLCategory* catFromFilterLeft;//set in viewDid load
@property MLCategory* catFromFilterRight;//set in viewDid load
@property NSMutableArray* controllerArray;//set in viewDid load
@property NSString* sequeName;//ser in child
-(void)onAnswer;

@end
