//
//  MLSynchronousFilter.m
//  MinPairs
//
//  Created by Brandon on 2014-04-26.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLSynchronousFilter.h"
#import "MLPair.h"

@interface MLSynchronousFilter()
@property (nonatomic, strong) NSMutableArray* leftSide;
@property (nonatomic, strong) NSMutableArray* rightSide;
@property (nonatomic, strong) MLMainDataProvider* provider;
@end

@implementation MLSynchronousFilter

+(MLSynchronousFilter*) sharedInstance
{
    static dispatch_once_t onceToken = 0;
    static MLSynchronousFilter* instance = nil;
    
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone: nil] init];
        
        instance->_provider = [[MLMainDataProvider alloc] initMainProvider];
        instance->_leftSide = [[NSMutableArray alloc] init];
        instance->_rightSide = [[NSMutableArray alloc] init];
        
        
        NSArray* pairs = [[instance provider] getCategoryPairs];
        NSArray* categories = [[instance provider] getCategories];
        NSMutableArray* temp = [[NSMutableArray alloc] init];
        
        for (MLCategory* category in categories)
        {
            for (MLPair* pair in pairs)
            {
                if ([category categoryId] == [[pair first] categoryId])
                {
                    [temp addObject: [pair second]];
                }
            }
            
            [[instance leftSide] addObject: category];
            [[instance rightSide] addObject: temp];
            temp = [[NSMutableArray alloc] init];
        }
    });
    
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

+(NSMutableArray*)getCategoriesLeft
{
    return [[MLSynchronousFilter sharedInstance] leftSide];
}

+(NSMutableArray*)getCorrespondingCategories:(MLCategory*) category
{
    NSMutableArray* arr = [[MLSynchronousFilter sharedInstance] leftSide];
    
    for (int i = 0; i < [arr count]; ++i)
    {
        if ([arr objectAtIndex: i] == category)
        {
            return [[[MLSynchronousFilter sharedInstance] rightSide] objectAtIndex: i];
        }
    }
    return nil;
}

@end
