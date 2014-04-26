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
@property (nonatomic, strong) NSArray* categories;
@property (nonatomic, strong) NSMutableArray* mappedSounds;
@property (nonatomic, strong) MLMainDataProvider* provider;
@end

@implementation MLSynchronousFilter

+(MLSynchronousFilter*) sharedInstance
{
    static dispatch_once_t onceToken = 0;
    static MLSynchronousFilter* instance = nil;
    
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone: nil] init];
        
        instance->_mappedSounds = nil;
        instance->_provider = [[MLMainDataProvider alloc] initMainProvider];
        instance->_categories = [instance->_provider getCategories];
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

+(NSArray*)getLeft
{
    return [[MLSynchronousFilter sharedInstance] categories];
}

+(NSMutableArray*)getCategoriesRight:(MLCategory*) category
{
    bool found = false;
    MLSynchronousFilter* filter = [MLSynchronousFilter sharedInstance];
    
    NSArray* pairs = [[filter provider] getCategoryPairs];
    filter.mappedSounds = [[NSMutableArray alloc] init];
    
    for (MLPair* pair in pairs)
    {
        MLCategory* cat = [pair first];
        
        if ([cat categoryId] == [category categoryId])
        {
            [[filter mappedSounds] addObject: [pair second]];
            found = true;
        }
    }
    return found ? [filter mappedSounds] : nil;
}

@end
