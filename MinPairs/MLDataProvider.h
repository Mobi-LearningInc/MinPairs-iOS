//
//  MLDataProvider.h
//  MinPairs
//
//  Created by Oleksiy Martynov on 4/24/14.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLCategory.h"
#import "MLItem.h"
/**
 * @class MLDataProvider
 * @discussion MLDataProvider reads the resources and return appropriate data structures
 */
@interface MLDataProvider : NSObject
#define MP_CATEGORIES_FILENAME @"MP_Categories"
#define MP_CATEGORIES_FILETYPE @"dat"

#define MP_CAT_PAIRS_FILENAME @"MP_CatPairs"
#define MP_CAT_PAIRS_FILETYPE @"dat"

#define MP_ITEMS_FILENAME @"MP_Items"
#define MP_ITEMS_FILETYPE @"dat"

#define MP_ITEMS_CATEGORIES_FILENAME @"MP_Items_Categories"
#define MP_ITEMS_CATEGORIES_FILETYPE @"dat"

#define MP_PAIRS_FILENAME @"MP_Pairs"
#define MP_PAIRS_FILETYPE @"dat"

#define MP_LINE_SEPERATOR @"\n"
#define MP_DATA_SEPERATOR @"|"
/*! Reads the resource and returns array of MLCategory objects
 * \returns array of MLCategory objects
 */
+(NSArray*)getCategories;
/*! Reads the resource and returns array of MLPair objects
 * \returns array of MLPair objects
 */
+(NSArray*)getCategoryPairs;
/*! Reads the resource and returns array of MLItem objects
 * \returns array of MLItem objects
 */
+(NSArray*)getItems;
/*! Reads the resource and returns array of MLPair objects
 * \returns array of MLPair objects
 */
+(NSArray*)getCategoryItemPairs;
/*! Reads the resource and returns array of MLPair objects
 * \returns array of MLPair objects
 */
+(NSArray*)getPairs;
/*! Reads the resource and return single MLCategory object with given id, or nil if id doesnt exist
 * \param id
 * \returns instance of MLCategory
 */
+(MLCategory*)getCategoryWithId:(int)categoryId;
/*! Reads the resource and return single MLItem object with given id, or nil if id doesnt exist
 * \param id
 * \returns instance of MLItem
 */
+(MLItem*)getItemWithId:(int)itemId;
@end

/*
 ****USAGE EXAMPLES****
 
 
 NSArray* arrCat=[MLDataProvider getCategories];
 for (int i=0; i<[arrCat count]; i++)
 {
 MLCategory* cat = [arrCat objectAtIndex:i];
 NSLog(@"Category data %i , %@ , %@ , %@ , %@  ",cat.categoryId,cat.categoryDescription,cat.categoryAudioFile,cat.categoryImageFile,cat.categorySeparator);
 }
 
 NSArray* arrItem=[MLDataProvider getItems];
 for (int i=0; i<[arrItem count]; i++)
 {
 MLItem* item = [arrItem objectAtIndex:i];
 NSLog(@"Item data %i , %@ , %@ , %@ , %@  ",item.itemId,item.itemDescription,item.itemAudioFile,item.itemImageFile,item.itemSeparator);
 }
 
 NSArray* pairsArr=[MLDataProvider getCategoryItemPairs];
 for (int i=0; i<[pairsArr count]; i++)
 {
 MLPair* pair=[pairsArr objectAtIndex:i];
 NSLog(@"Pair cat: %@ item: %@",[pair.first categoryDescription],[pair.second itemDescription]);
 }
 
 NSArray* pairsArr=[MLDataProvider getCategoryPairs];
 for (int i=0; i<[pairsArr count]; i++)
 {
 MLPair* pair=[pairsArr objectAtIndex:i];
 NSLog(@"Pair cat: %@ cat: %@",[pair.first categoryDescription],[pair.second categoryDescription]);
 }
 
 NSArray* pairsPairArr=[MLDataProvider getPairs];
 for (int i=0; i<[pairsPairArr count]; i++)
 {
 MLPair* pair=[pairsPairArr objectAtIndex:i];
 MLPair* pairL=pair.first;
 MLPair* pairR=pair.second;
 NSLog(@"Pair cat: %@ item: %@ cat: %@ item: %@",[pairL.first categoryDescription],[pairL.second itemDescription],[pairR.first categoryDescription],[pairR.second itemDescription]);
 }
 */
