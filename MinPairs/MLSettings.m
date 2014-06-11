//
//  MLFilter.m
//  MinPairs
//
//  Created by Brandon on 2014-04-26.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLSettings.h"

@interface MLSettings()
@property (nonatomic, strong) MLDatabase* database;
@end

@implementation MLSettings

static const int DB_COL_COUNT                           = 4;
static const int DB_DEFAULT_VALUES[]                    = {5, 5, 10};

static const char* DB_SETTINGS_ID                       = "ML_SETTINGS_ID";
static const char* DB_TABLE_NAME                        = "ML_SETTINGS_TABLE";
static const char* DB_TIME_LISTEN_AND_SELECT_COL_NAME   = "TIME_LISTEN_AND_SELECT";
static const char* DB_TIME_LISTEN_AND_READ_COL_NAME     = "TIME_LISTEN_AND_READ";
static const char* DB_LISTEN_AND_TYPE_QUESTION_COL_NAME = "LISTEN_AND_TYPE_QUESTION";

+(MLSettings*) sharedInstance
{
    static MLSettings* instance = nil;
    static dispatch_once_t onceToken = 0;
    
    if (!instance)
    {
        dispatch_once(&onceToken, ^{
            NSString* DB_CREATE_QUERY = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %s (%s INTEGER PRIMARY KEY AUTOINCREMENT, %s INTEGER, %s INTEGER, %s INTEGER);", DB_TABLE_NAME, DB_SETTINGS_ID, DB_TIME_LISTEN_AND_SELECT_COL_NAME, DB_TIME_LISTEN_AND_READ_COL_NAME, DB_LISTEN_AND_TYPE_QUESTION_COL_NAME];
            
            instance = [[super allocWithZone: nil] init];
            instance->_database = [[MLDatabase alloc] initDatabaseWithCreateQuery: DB_CREATE_QUERY];
            
            uint32_t timelistenAndSelect = 0;
            uint32_t timeListenAndRead = 0;
            uint32_t timeListenAndType = 0;
            
            bool res = [MLSettings getSettings: &timelistenAndSelect withTimeListenAndRead: &timeListenAndRead withListenAndTypeQuestion: &timeListenAndType];
            
            if (!res)
            {
                [MLSettings updateSettings: DB_DEFAULT_VALUES[0] withTimeListenAndRead: DB_DEFAULT_VALUES[1] withListenAndTypeQuestion: DB_DEFAULT_VALUES[2]];
            }
        });
    }
    
    return instance;
}

+(id) allocWithZone:(NSZone*)zone
{
    return [self sharedInstance];
}

-(id) copyWithZone:(NSZone*)zone
{
    return self;
}

+(void) getDefaultSettings:(uint32_t*)time_listen_and_select withTimeListenAndRead:(uint32_t*)time_listen_and_read withListenAndTypeQuestion:(uint32_t*)listen_and_type_question
{
    if (time_listen_and_select && time_listen_and_read && listen_and_type_question)
    {
        *time_listen_and_select = DB_DEFAULT_VALUES[0];
        *time_listen_and_read = DB_DEFAULT_VALUES[1];
        *listen_and_type_question = DB_DEFAULT_VALUES[2];
    }
}

+(bool) updateSettings:(uint32_t)time_listen_and_select withTimeListenAndRead:(uint32_t)time_listen_and_read withListenAndTypeQuestion:(uint32_t)listen_and_type_question
{
    NSString* query = [NSString stringWithFormat: @"UPDATE %s SET %s = %d, %s = %d, %s = %d WHERE %s = %d;", DB_TABLE_NAME, DB_TIME_LISTEN_AND_SELECT_COL_NAME, time_listen_and_select, DB_TIME_LISTEN_AND_READ_COL_NAME, time_listen_and_read, DB_LISTEN_AND_TYPE_QUESTION_COL_NAME, listen_and_type_question, DB_SETTINGS_ID, 1];
    
    NSString* err = nil;
    if (![[[MLSettings sharedInstance] database] runQuery: query errorString: &err])
    {
        query = [NSString stringWithFormat: @"INSERT INTO %s (%s, %s, %s) VALUES(%d, %d, %d);", DB_TABLE_NAME, DB_TIME_LISTEN_AND_SELECT_COL_NAME, DB_TIME_LISTEN_AND_READ_COL_NAME, DB_LISTEN_AND_TYPE_QUESTION_COL_NAME, time_listen_and_select, time_listen_and_read, listen_and_type_question];
        
        [[[MLSettings sharedInstance] database] runQuery: query errorString: &err];
        return false;
    }

    return true;
}

+(bool) getSettings:(uint32_t*)time_listen_and_select withTimeListenAndRead:(uint32_t*)time_listen_and_read withListenAndTypeQuestion:(uint32_t*)listen_and_type_question
{
    if (!time_listen_and_select || !time_listen_and_read || !listen_and_type_question)
    {
        return false;
    }
    
    NSString* query = [NSString stringWithFormat: @"SELECT %s, %s, %s, %s FROM %s WHERE %s = %d;", DB_SETTINGS_ID, DB_TIME_LISTEN_AND_SELECT_COL_NAME, DB_TIME_LISTEN_AND_READ_COL_NAME, DB_LISTEN_AND_TYPE_QUESTION_COL_NAME, DB_TABLE_NAME, DB_SETTINGS_ID, 1];
    
    NSString* err = nil;
    NSMutableArray* results = [NSMutableArray arrayWithCapacity: DB_COL_COUNT];
    
    if ([[[MLSettings sharedInstance] database] runQuery: query errorString: &err returnArray: &results] && ([results count] >= DB_COL_COUNT))
    {
        *time_listen_and_select = [[results objectAtIndex: 1] unsignedIntValue];
        *time_listen_and_read = [[results objectAtIndex: 2] unsignedIntValue];
        *listen_and_type_question = [[results objectAtIndex: 3] unsignedIntValue];
        return true;
    }
    
    *time_listen_and_select = -1;
    *time_listen_and_read = -1;
    *listen_and_type_question = -1;
    return false;
}

@end
