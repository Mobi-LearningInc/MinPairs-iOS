//
//  MLDatabase.h
//  MinPairs
//
//  Created by Oleksiy Martynov on 4/25/14.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *DataBase class uses Sqlite
 */
@interface MLDatabase : NSObject
/*! Constructs instance of MLDatabase class. If sql db file doesnt exist then one will be created
 * \param sql create query as string
 * \returns instance of MLDatabase class
 */
-(instancetype)initDatabaseWithCreateQuery:(NSString*)createQueryString;
/*! Executes query or multiple queries. Query should not return data. (NO SELECT)
 * \param query string sqlite query/queries (seperate multiple queries by ";")
 *\param errorStr reference to string that will be set if case of error
 * \returns bool on success
 */
-(BOOL)runQuery:(NSString*) query errorString: (NSString**)errorStr;
/*! Executes a query for result
 * \param query string sqlite query/queries (seperate multiple queries by ";")
 *\param errorStr reference to string that will be set if case of error
 *\param array reference to array that will be set to array or arrays. (for each row for each column). rows of columns. each column item is a sell of type NSString
 * \returns bool on success
 */
-(BOOL)runQuery:(NSString*) query errorString: (NSString**)errorStr returnArray:(NSMutableArray**)array;
@end
