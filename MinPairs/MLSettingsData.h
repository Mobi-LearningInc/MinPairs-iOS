//
//  MLSettingsData.h
//  MinPairs
//
//  Created by Oleksiy Martynov on 4/26/14.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * MLSettingsData object used to contain setting data
 */
@interface MLSettingsData : NSObject
@property int settingId;
@property int settingTimeSelect;
@property int settingTimeRead;
@property int settingTimeType;
/**Creates an istance of SettingData object with given parameters
 * \param settingId unique id from database
 * \param settingTimeSelect time given to the user to select the right answer
 * \param settingTimeRead time given to the user to read the question
 * \param settingTimeType time given to the user to type the answer
 * \return instance of MLSettingsData object
 */
-(instancetype)initSettingWithId:(int)settingId timeSelect:(int)settingTimeSelect timeRead:(int)settingTimeRead timeType:(int)settingTimeType;
/**Creates an istance of SettingData object with given parameters
 * \param settingTimeSelect time given to the user to select the right answer
 * \param settingTimeRead time given to the user to read the question
 * \param settingTimeType time given to the user to type the answer
 * \return instance of MLSettingsData object
 */
-(instancetype)initSettingWithTimeSelect:(int)settingTimeSelect timeRead:(int)settingTimeRead timeType:(int)settingTimeType;
@end
