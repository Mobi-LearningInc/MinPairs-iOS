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
    static dispatch_once_t onceToken = 0;
    static MLSettings* instance = nil;
    //NSLog(@"one");
    dispatch_once(&onceToken, ^{
        NSString* DB_CREATE_QUERY = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %s (%s INTEGER PRIMARY KEY AUTOINCREMENT, %s INTEGER, %s INTEGER, %s INTEGER);", DB_TABLE_NAME, DB_SETTINGS_ID, DB_TIME_LISTEN_AND_SELECT_COL_NAME, DB_TIME_LISTEN_AND_READ_COL_NAME, DB_LISTEN_AND_TYPE_QUESTION_COL_NAME];
        //NSLog(@"two");
        instance = [[super allocWithZone: nil] init];
        instance->_database = [[MLDatabase alloc] initDatabaseWithCreateQuery: DB_CREATE_QUERY];
        //NSLog(@"three");
        uint32_t timelistenAndSelect = 0;
        uint32_t timeListenAndRead = 0;
        uint32_t timeListenAndType = 0;
        
        bool res = [MLSettings getSettings: &timelistenAndSelect withTimeListenAndRead: &timeListenAndRead withListenAndTypeQuestion: &timeListenAndType];
        //NSLog(@"four");
        if (!res)
        {
            [MLSettings updateSettings: DB_DEFAULT_VALUES[0] withTimeListenAndRead: DB_DEFAULT_VALUES[1] withListenAndTypeQuestion: DB_DEFAULT_VALUES[2]];
        }
    });
    //NSLog(@"five");
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
    //NSLog(@"here 4");
    NSString* err = nil;
    BOOL success =[[[MLSettings sharedInstance] database] runQuery: query errorString: &err];
    //NSLog(@"err msg %@",err);
    if (!success)
    {
        
        query = [NSString stringWithFormat: @"INSERT INTO %s (%s, %s, %s) VALUES(%d, %d, %d);", DB_TABLE_NAME, DB_TIME_LISTEN_AND_SELECT_COL_NAME, DB_TIME_LISTEN_AND_READ_COL_NAME, DB_LISTEN_AND_TYPE_QUESTION_COL_NAME, time_listen_and_select, time_listen_and_read, listen_and_type_question];
        //NSLog(@"here 5");
        
        return [[[MLSettings sharedInstance] database] runQuery: query errorString: &err];
    }
    //NSLog(@"here 6");
    return true;
}

+(bool) getSettings:(uint32_t*)time_listen_and_select withTimeListenAndRead:(uint32_t*)time_listen_and_read withListenAndTypeQuestion:(uint32_t*)listen_and_type_question
{
    if (!time_listen_and_select || !time_listen_and_read || !listen_and_type_question)
    {
        return false;
    }
    //NSLog(@"blah");
    NSString* query = [NSString stringWithFormat: @"SELECT %s, %s, %s FROM %s;", DB_TIME_LISTEN_AND_SELECT_COL_NAME, DB_TIME_LISTEN_AND_READ_COL_NAME, DB_LISTEN_AND_TYPE_QUESTION_COL_NAME, DB_TABLE_NAME];
    
    NSString* err = nil;
    NSMutableArray* results = [NSMutableArray arrayWithCapacity: DB_COL_COUNT];
    //NSLog(@"blah2");
    if ([[[MLSettings sharedInstance] database] runQuery: query errorString: &err returnArray: &results])
    {
        //NSLog(@"blah3");
        *time_listen_and_select = [[results objectAtIndex: 0] unsignedIntValue];
        *time_listen_and_read = [[results objectAtIndex: 1] unsignedIntValue];
        *listen_and_type_question = [[results objectAtIndex: 2] unsignedIntValue];
        return true;
    }
    //NSLog(@"blah4");
    *time_listen_and_select = -1;
    *time_listen_and_read = -1;
    *listen_and_type_question = -1;
    return false;
}

@end
