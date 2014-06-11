//
//  MLButtonGroup.h
//  MinPairs
//
//  Created by Brandon on 2014-04-25.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Groups buttons together guaranteeing that only one control 
 *  in the group can be selected at any instance in time.
 */
@interface MLButtonGroup : UIView

/**
 * @return Returns the index of the currently selected button within the group.
 *         -1 is returned if no button is selected.
 */
-(int) selectedIndex;


/**
 *  Sets the button at a specified index to the selected state.
 *  @param index Index of the button to be set active.
 */
-(void) setSelected:(unsigned int)index;


/**
 *  @return Returns the currently selected button within the group.
 *          nil is returned if no button is selected.
 */
-(UIButton*) selectedButton;

@end
