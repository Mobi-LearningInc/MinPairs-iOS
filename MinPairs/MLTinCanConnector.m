//
//  MLTinCanConnector.m
//  MinPairs
//
//  Created by MLinc on 2014-05-08.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import "MLTinCanConnector.h"


@interface MLTinCanConnector()
    @property (strong, nonatomic) RSTinCanConnector *tincan;
    @property (strong, nonatomic) MLLsrCredentials *credentials;
@end

@implementation MLTinCanConnector

-(instancetype)initWithCredentials:(MLLsrCredentials *)credentials{

    self=[super init];
    if(self)
    {
        self.credentials = credentials;
        _tincan = [self setUp:credentials];
    }
    return self;
}

-(RSTinCanConnector*)tincan{
    if(_tincan==nil){
        _tincan = [self setUp:self.credentials];
    }
    return _tincan;
}

- (RSTinCanConnector *)setUp:(MLLsrCredentials*)credentials
{
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *lrs = [[NSMutableDictionary alloc] init];
    
    //dummy LRS - supply your own credentials here to run tests
    //@"https://cloud.scorm.com/tc/I40JG12M9U/"
    //@"Basic UHJ6ZW1lazptb2plbXlzemtp"
    
    
    [lrs setValue:credentials.address forKey:@"endpoint"];
    [lrs setValue:credentials.encodedCredentials forKey:@"auth"];
    [lrs setValue:@"1.0.0"forKey:@"version"];
    // just add one LRS for now
    [options setValue:[NSArray arrayWithObject:lrs] forKey:@"recordStore"];
    [options setValue:@"1.0.0" forKey:@"version"];
    RSTinCanConnector *tincan = [[RSTinCanConnector alloc]initWithOptions:options];
    return tincan;
}


-(void)saveSampleActivity{

    NSMutableDictionary *statementOptions = [[NSMutableDictionary alloc] init];
    [statementOptions setValue:@"http://tincanapi.com/test" forKey:@"activityId"];
    [statementOptions setValue:[[TCVerb alloc] initWithId:@"http://adlnet.gov/expapi/verbs/experienced" withVerbDisplay:[[TCLocalizedValues alloc] initWithLanguageCode:@"en-US" withValue:@"experienced"]] forKey:@"verb"];
    [statementOptions setValue:@"http://adlnet.gov/expapi/activities/course/" forKey:@"activityType"];
    
    TCStatement *statementToSend = [self createTestStatementWithOptions:statementOptions];
    NSLog(@"%@\n", statementToSend.JSONString);
    [self.tincan sendStatement:statementToSend withCompletionBlock:^(){
       // [[TestSemaphor sharedInstance] lift:@"saveStatement"];
    }withErrorBlock:^(TCError *error){
        
        NSLog(@"ERROR: %@", error.localizedDescription);
        //STAssertNil(error, @"There was no error with the request");
       // [[TestSemaphor sharedInstance] lift:@"saveStatement"];
    }];
}

- (TCStatement *)createTestStatementWithOptions:(NSDictionary *)options
{
    TCAgent *actor = [[TCAgent alloc] initWithName:@"Przemek" withMbox:@"mailto:pawluk@gmail.com" withAccount:nil];
    
    TCActivityDefinition *actDef = [[TCActivityDefinition alloc] initWithName:[[TCLocalizedValues alloc] initWithLanguageCode:@"en-US" withValue:@"http://tincanapi.com/test"]
                                                              withDescription:[[TCLocalizedValues alloc] initWithLanguageCode:@"en-US" withValue:@"Description for test statement"]
                                                                     withType:[options valueForKey:@"activityType"]
                                                               withExtensions:nil
                                                          withInteractionType:nil
                                                  withCorrectResponsesPattern:nil
                                                                  withChoices:nil
                                                                    withScale:nil
                                                                   withTarget:nil
                                                                    withSteps:nil];
    
    TCActivity *activity = [[TCActivity alloc] initWithId:[options valueForKey:@"activityId"] withActivityDefinition:actDef];
    
    TCVerb *verb = [options valueForKey:@"verb"];
    
    TCStatement *statementToSend = [[TCStatement alloc] initWithId:[TCUtil GetUUID] withActor:actor withTarget:activity withVerb:verb withResult:nil withContext:nil];
    
    return statementToSend;
}



@end
