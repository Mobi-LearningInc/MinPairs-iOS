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
#import "MLItem.h"
#define ML_MLPQBASE_QUESTION_LIMIT 10
/** MLPQBaseViewController is the base class too all Practice/Quiz contollers
 */
@interface MLPQBaseViewController : UIViewController <UIAlertViewDelegate>
@property (nonatomic, assign) bool practiceMode;//set on segue
@property int questionCount;//set on segue
@property (strong,nonatomic) MLTestResult* previousResult;//set on segue
@property MLCategory* catFromFilterLeft;//set in viewDid load
@property MLCategory* catFromFilterRight;//set in viewDid load
@property NSMutableArray* controllerArray;//set in viewDid load
@property NSString* sequeName;//set in child
@property int timeCount;//set by NSTimer
/** called when quiz or practice controller is ready with the result
 *@param currentResult is a MLTestResult object filled with cumulative data from this test session
 */
-(void)onAnswer:(MLTestResult*)currentResult;
/** plays sound file associated with the MLItem object
 * @param MLItem object
 */
-(void)playItem:(MLItem*)item;
/** Helper method for getting the Array of items for specific category
 *@param MLCategory object
 */
-(NSMutableArray*)getItemsForCategory:(MLCategory*)selectedCategory;
/** helper method that picks a random MLItem object from an array
 *@param NSMuttable array of MLItem objects
 *@returns random Item
 */
-(MLItem*)pickRandomItem:(NSMutableArray*)items;
/** used to register timer labels and timer events. events will be triggered based on MLSettings data
 */
-(void)registerQuizTimeLabelsAndEventSelectLabel:(UILabel*)selectTimeLabel event:(void (^)(void))onSelectEnd readLabel: (UILabel*)readTimeLabel event:(void (^)(void))onReadEnd typeLabel: (UILabel*)typeTimeLabel event:(void (^)(void))onTypeEnd;
@end
