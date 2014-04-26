//
//  MLFilter.h
//  MinPairs
//
//  Created by Brandon on 2014-04-26.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLDatabase.h"

/**
 *  Class for storing and retrieving application settings.
 */
@interface MLSettings : NSObject


/**
 *  Retrieves default settings.
 *  @param time_listen_and_select pointer to an unsigned integer representing the amount of seconds for the listen and select setting. Upon failure, this parameter is set to -1.
 *
 *  @param time_listen_and_read pointer to an unsigned integer representing the amount of seconds for the listen and read setting. Upon failure, this parameter is set to -1.
 *
 *  @param listen_and_type_question unsigned integer representing the amount of seconds for the listen and type setting. Upon failure, this parameter is set to -1.
 *
 *  @note NONE of the parameters should be nil/null.
 */
+(void) getDefaultSettings:(uint32_t*)time_listen_and_select withTimeListenAndRead:(uint32_t*)time_listen_and_read withListenAndTypeQuestion:(uint32_t*)listen_and_type_question;


/**
 *  Updates settings in the database. If no settings exist, the new settings are inserted instead.
 *  @param time_listen_and_select unsigned integer representing the amount of seconds for the listen and select setting.
 *
 *  @param time_listen_and_read unsigned integer representing the amount of seconds for the listen and read setting.
 *
 *  @param listen_and_type_question unsigned integer representing the amount of seconds for the listen and type setting.
 *
 *  @return True if the update was successful; false otherwise.
 */
+(bool) updateSettings:(uint32_t)time_listen_and_select withTimeListenAndRead:(uint32_t)time_listen_and_read withListenAndTypeQuestion:(uint32_t)listen_and_type_question;


/**
 *  Retrieves settings from the database.
 *  @param time_listen_and_select pointer to an unsigned integer representing the amount of seconds for the listen and select setting. Upon failure, this parameter is set to -1.
 *
 *  @param time_listen_and_read pointer to an unsigned integer representing the amount of seconds for the listen and read setting. Upon failure, this parameter is set to -1.
 *
 *  @param listen_and_type_question unsigned integer representing the amount of seconds for the listen and type setting. Upon failure, this parameter is set to -1.
 *
 *  @return True if the retrieval was successful; false otherwise.
 *
 *  @note NONE of the parameters should be nil/null.
 */
+(bool) getSettings:(uint32_t*)time_listen_and_select withTimeListenAndRead:(uint32_t*)time_listen_and_read withListenAndTypeQuestion:(uint32_t*)listen_and_type_question;

@end
