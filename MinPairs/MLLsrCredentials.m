//
//  MLLsrCredentials.m
//  MinPairs
//
//  Created by MLinc on 2014-05-08.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLLsrCredentials.h"

@implementation MLLsrCredentials
-(instancetype)initCredentialsWithId:(int) credId appName:(NSString*)appName key:(NSString*)key secret:(NSString*)secret address:(NSString *)address
{
    self=[super init];
    if(self)
    {
        self.credentialId = credId;
        self.appName=appName;
        self.key=key;
        self.secret=secret;
        self.address = address;
    }
    return self;
}
@end
