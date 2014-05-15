//
//  MLLrsCredentialsDatabase.h
//  MinPairs
//
//  Created by MLinc on 2014-05-08.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLDatabase.h"
#import "MLLsrCredentials.h"

@interface MLLrsCredentialsDatabase : MLDatabase
#define ML_DB_CREDENTIALS_TABLE_NAME @"lrs_credentials_table"
#define ML_DB_CREDENTIALS_TABLE_COL_CREDENTIAL_ID @"lrs_credential_id"
#define ML_DB_CREDENTIALS_TABLE_COL_APP_NAME @"lrs_app_name"
#define ML_DB_CREDENTIALS_TABLE_COL_KEY @"lrs_key"
#define ML_DB_CREDENTIALS_TABLE_COL_SECRET @"lrs_secret"
#define ML_DB_CREDENTIALS_TABLE_COL_ADDRESS @"lrs_address"

#define ML_DB_CREDENTIALS_DEFAULT_KEY @"d9b838c4-d6c8-11e3-80c7-bc764e05584e"
#define ML_DB_CREDENTIALS_DEFAULT_SECRET @"U6Kak3h3YH"
#define ML_DB_CREDENTIALS_DEFAULT_APPNAME @"MinPairs"
#define ML_DB_CREDENTIALS_DEFAULT_ADDRESS @"http://166.78.152.121:8000/xAPI"


/** Creates and istance of the SettingDatabase class
 * \return instancetype of MLLrsCredentials
 */
-(instancetype)initLmsCredentialsDatabase;
/**saves credentials to database
 *\return status
 */
-(BOOL)saveLmsCredentials:(MLLsrCredentials*)data;
/**gets the only credentials in the database
 *\return MLSettingsData object
 */
-(MLLsrCredentials*)getLmsCredentials;
/**saves default credentials data to database (for testing only)
 *\return status
 */
-(BOOL)saveDefaultCredentials;
@end
