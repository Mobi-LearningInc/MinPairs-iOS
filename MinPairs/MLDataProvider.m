//
//  MLDataProvider.m
//  MinPairs
//
//  Created by Oleksiy Martynov on 4/24/14.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLDataProvider.h"
#import "MLPair.h"
@implementation MLDataProvider

+(NSArray*)getCategories
{
    NSString* dataStr =[[NSString alloc]initWithContentsOfFile:[self getFilePath:MP_CATEGORIES_FILENAME type: MP_CATEGORIES_FILETYPE ] encoding:NSUTF8StringEncoding error:nil];
    NSArray* dataLinesStrArr =[dataStr componentsSeparatedByString:MP_LINE_SEPERATOR];
    NSMutableArray* resultArr=[NSMutableArray array];
    for (int i=0; i<[dataLinesStrArr count]; i++)
    {
        NSArray* dataItemsStrArr = [[dataLinesStrArr objectAtIndex:i]componentsSeparatedByString:MP_DATA_SEPERATOR];
        [resultArr addObject:[[MLCategory alloc]initCategoryWithId:[[dataItemsStrArr objectAtIndex:0] intValue] description:[dataItemsStrArr objectAtIndex:1] audioPath:[dataItemsStrArr objectAtIndex:2] imagePath:[dataItemsStrArr objectAtIndex:3] seperator:MP_DATA_SEPERATOR]];
    }
    return resultArr;
}
+(NSArray*)getItems
{
    NSString* dataStr =[[NSString alloc]initWithContentsOfFile:[self getFilePath:MP_ITEMS_FILENAME type: MP_ITEMS_FILETYPE ] encoding:NSUTF8StringEncoding error:nil];
    NSArray* dataLinesStrArr =[dataStr componentsSeparatedByString:MP_LINE_SEPERATOR];
    NSMutableArray* resultArr=[NSMutableArray array];
    for (int i=0; i<[dataLinesStrArr count]; i++)
    {
        NSArray* dataItemsStrArr = [[dataLinesStrArr objectAtIndex:i]componentsSeparatedByString:MP_DATA_SEPERATOR];
        [resultArr addObject:[[MLItem alloc]initItemWithId:[[dataItemsStrArr objectAtIndex:0]intValue] description:[dataItemsStrArr objectAtIndex:1] audioPath:[dataItemsStrArr objectAtIndex:2] imagePath:[dataItemsStrArr objectAtIndex:3]  seperator:MP_DATA_SEPERATOR]];
    }
    return resultArr;
}
+(NSArray*)getCategoryPairs
{
    NSString* dataStr =[[NSString alloc]initWithContentsOfFile:[self getFilePath:MP_CAT_PAIRS_FILENAME type: MP_CAT_PAIRS_FILETYPE ] encoding:NSUTF8StringEncoding error:nil];
    NSArray* dataLinesStrArr =[dataStr componentsSeparatedByString:MP_LINE_SEPERATOR];
    NSMutableArray* resultArr=[NSMutableArray array];
    for (int i=0; i<[dataLinesStrArr count]; i++)
    {
        NSArray* dataItemsStrArr = [[dataLinesStrArr objectAtIndex:i]componentsSeparatedByString:MP_DATA_SEPERATOR];
        MLCategory* one=[self getCategoryWithId:[[dataItemsStrArr objectAtIndex:0]intValue]];
        MLCategory* two=[self getCategoryWithId:[[dataItemsStrArr objectAtIndex:1]intValue]];
        MLPair* pair =[[MLPair alloc]initPairWithFirstObject:one secondObject:two];
        [resultArr addObject:pair];
    }
    return resultArr;
}
+(NSArray*)getCategoryItemPairs
{
    NSString* dataStr =[[NSString alloc]initWithContentsOfFile:[self getFilePath:MP_ITEMS_CATEGORIES_FILENAME type: MP_ITEMS_CATEGORIES_FILETYPE ] encoding:NSUTF8StringEncoding error:nil];
    NSArray* dataLinesStrArr =[dataStr componentsSeparatedByString:MP_LINE_SEPERATOR];
    NSMutableArray* resultArr=[NSMutableArray array];
    for (int i=0; i<[dataLinesStrArr count]; i++)
    {
        NSArray* dataItemsStrArr = [[dataLinesStrArr objectAtIndex:i]componentsSeparatedByString:MP_DATA_SEPERATOR];
        MLCategory* one=[self getCategoryWithId:[[dataItemsStrArr objectAtIndex:0]intValue]];
        MLItem* two=[self getItemWithId:[[dataItemsStrArr objectAtIndex:1]intValue]];
        MLPair* pair =[[MLPair alloc]initPairWithFirstObject:one secondObject:two];
        [resultArr addObject:pair];
    }
    return resultArr;
}
+(NSArray*)getPairs
{
    NSString* dataStr =[[NSString alloc]initWithContentsOfFile:[self getFilePath:MP_PAIRS_FILENAME type: MP_PAIRS_FILETYPE ] encoding:NSUTF8StringEncoding error:nil];
    NSArray* dataLinesStrArr =[dataStr componentsSeparatedByString:MP_LINE_SEPERATOR];
    NSMutableArray* resultArr=[NSMutableArray array];
    
    for (int i=0; i<[dataLinesStrArr count]; i++)
    {
        NSArray* dataItemsStrArr = [[dataLinesStrArr objectAtIndex:i]componentsSeparatedByString:MP_DATA_SEPERATOR];
        if ([dataItemsStrArr count]==4)
        {
        
            MLCategory* one=[self getCategoryWithId:[[dataItemsStrArr objectAtIndex:1]intValue]];
            MLItem* two=[self getItemWithId:[[dataItemsStrArr objectAtIndex:0]intValue]];
            MLCategory* three=[self getCategoryWithId:[[dataItemsStrArr objectAtIndex:3]intValue]];
            MLItem* four=[self getItemWithId:[[dataItemsStrArr objectAtIndex:2]intValue]];
            MLPair* pairL =[[MLPair alloc]initPairWithFirstObject:one secondObject:two];
            MLPair* pairR =[[MLPair alloc]initPairWithFirstObject:three secondObject:four];
            MLPair* pair =[[MLPair alloc]initPairWithFirstObject:pairL secondObject:pairR];
            [resultArr addObject:pair];
        }
    }
    return resultArr;
}
+(MLCategory*)getCategoryWithId:(int)categoryId //performance? 
{
    NSArray* arrCat=[MLDataProvider getCategories];
    for (int i=0; i<[arrCat count]; i++)
    {
        MLCategory* cat = [arrCat objectAtIndex:i];
        if(cat.categoryId==categoryId)
        {
            return cat;
        }
    }
    return nil;
}
+(MLItem*)getItemWithId:(int)itemId //performance?
{
    NSArray* arrItem=[MLDataProvider getItems];
    for (int i=0; i<[arrItem count]; i++)
    {
        MLItem* item = [arrItem objectAtIndex:i];
        if(item.itemId==itemId)
        {
            return item;
        }
    }
    return nil;
}
+(NSString*)getFilePath:(NSString*)fileName type:(NSString*)fileType
{
    return [[NSBundle mainBundle]pathForResource:fileName ofType:fileType];
}
@end
