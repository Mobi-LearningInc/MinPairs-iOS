//
//  MLSettingDatabase.h
//  MinPairs
//
//  Created by Oleksiy Martynov on 4/26/14.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLDatabase.h"
#import "MLSettingsData.h"
/**
 *  MLSettingDatabase is a class for storing and retrieving application settings.
 */
@interface MLSettingDatabase : MLDatabase
#define ML_DB_SETTING_TABLE_NAME @"settings_table"
#define ML_DB_TEST_TABLE_COL_SETTING_ID @"setting_id"
#define ML_DB_TEST_TABLE_COL_SETTING_SELECT_TIME @"setting_select_time"
#define ML_DB_TEST_TABLE_COL_SETTING_READ_TIME @"setting_read_time"
#define ML_DB_TEST_TABLE_COL_SETTING_TYPE_TIME @"setting_type_time"

#define ML_DB_SETTING_DEFAULT_SELECT_TIME 5
#define ML_DB_SETTING_DEFAULT_READ_TIME 6
#define ML_DB_SETTING_DEFAULT_TYPE_TIME 7


/** Creates and istance of the SettingDatabase class
 * \return instancetype of MLSettingDatabase
 */
-(instancetype)initSettingDatabase;
/**saves MLSettingsData to database
 *\return status
 */
-(BOOL)saveSetting:(MLSettingsData*)data;
/**gets the only setting in the database
 *\return MLSettingsData object
 */
-(MLSettingsData*)getSetting;
/**saves default settings data to database
 *\return status
 */
-(BOOL)saveDefaultSetting;
@end
