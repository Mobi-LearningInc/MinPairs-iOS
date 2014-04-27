//
//  MLSettingDatabase.m
//  MinPairs
//
//  Created by Oleksiy Martynov on 4/26/14.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLSettingDatabase.h"

@implementation MLSettingDatabase
-(instancetype)initSettingDatabase
{
    NSString* query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ INTEGER PRIMARY KEY AUTOINCREMENT,%@ INTEGER, %@ INTEGER, %@ INTEGER);",ML_DB_SETTING_TABLE_NAME,ML_DB_TEST_TABLE_COL_SETTING_ID,ML_DB_TEST_TABLE_COL_SETTING_SELECT_TIME,ML_DB_TEST_TABLE_COL_SETTING_READ_TIME,ML_DB_TEST_TABLE_COL_SETTING_TYPE_TIME];
    self=[super initDatabaseWithCreateQuery:query];
    return self;
}

-(BOOL)saveSetting:(MLSettingsData*)data
{
    NSString* query;
    if ([self countSettings]==0)
    {
        query = [NSString stringWithFormat:@"INSERT INTO %@ (%@,%@,%@) VALUES(%i,%i,%i);",ML_DB_SETTING_TABLE_NAME,ML_DB_TEST_TABLE_COL_SETTING_SELECT_TIME,ML_DB_TEST_TABLE_COL_SETTING_READ_TIME,ML_DB_TEST_TABLE_COL_SETTING_TYPE_TIME,data.settingTimeSelect,data.settingTimeRead,data.settingTimeType];
    }
    else
    {
        query = [NSString stringWithFormat:@"UPDATE %@ SET %@=%i,%@=%i,%@=%i WHERE %@=%i;" ,ML_DB_SETTING_TABLE_NAME,ML_DB_TEST_TABLE_COL_SETTING_SELECT_TIME,data.settingTimeSelect,ML_DB_TEST_TABLE_COL_SETTING_READ_TIME,data.settingTimeRead,ML_DB_TEST_TABLE_COL_SETTING_TYPE_TIME,data.settingTimeType,ML_DB_TEST_TABLE_COL_SETTING_ID,1];
    }
    NSString* errorStr;
    if(![self runQuery:query errorString:&errorStr])
    {
        NSLog(@"%@",errorStr);
        return NO;
    }
    return YES;
}

-(MLSettingsData*)getSetting
{
    NSString* query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = 1 ;",ML_DB_SETTING_TABLE_NAME ,ML_DB_TEST_TABLE_COL_SETTING_ID];
    NSString* errorStr =@"";
    NSMutableArray* dataArr = [NSMutableArray array];
 
    if ([self runQuery:query errorString:&errorStr returnArray:&dataArr])
    {
        MLSettingsData* dataItem;
        if ([dataArr count]!=0)
        {

            for(int i =0; i<[dataArr count];i++)
            {
                NSMutableArray* rowDataArr = [dataArr objectAtIndex:i];
                dataItem=[[MLSettingsData alloc]initSettingWithId:[[rowDataArr objectAtIndex:0]intValue]    timeSelect:[[rowDataArr objectAtIndex:1]intValue] timeRead:[[rowDataArr objectAtIndex:2]intValue] timeType:[[rowDataArr objectAtIndex:3]intValue]];
            }
        }
        else
        {
            [self saveDefaultSetting];
            return [self getSetting];
        }
        return dataItem;
    }

    return nil;
}

-(BOOL)saveDefaultSetting
{
    MLSettingsData* deffaultSetting =[[MLSettingsData alloc]initSettingWithTimeSelect:ML_DB_SETTING_DEFAULT_SELECT_TIME timeRead:ML_DB_SETTING_DEFAULT_READ_TIME timeType:ML_DB_SETTING_DEFAULT_TYPE_TIME];
    return [self saveSetting:deffaultSetting ];
}
-(int)countSettings
{
    NSString* query = [NSString stringWithFormat:@"SELECT COUNT(%@) FROM %@ ;",ML_DB_TEST_TABLE_COL_SETTING_ID,ML_DB_SETTING_TABLE_NAME ];
    NSString* errorStr =@"";
    NSMutableArray* dataArr = [NSMutableArray array];

    if ([self runQuery:query errorString:&errorStr returnArray:&dataArr])
    {
        for(int i =0; i<[dataArr count];i++)
        {
            NSMutableArray* rowDataArr = [dataArr objectAtIndex:i];
            return [[rowDataArr objectAtIndex:0]intValue];
        }
    }


    return 0;
}
@end
