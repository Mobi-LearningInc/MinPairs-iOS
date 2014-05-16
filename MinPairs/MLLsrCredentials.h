//
//  MLLsrCredentials.h
//  MinPairs
//
//  Created by MLinc on 2014-05-08.
//  Copyright (c) 2014 MobiLearning. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @class MLLsrCredentials
 * @discussion MLLsrCredentials class stores credentials required by the LSR and xAPI.
 */
@interface MLLsrCredentials : NSObject

-(instancetype)initCredentialsWithId:(int) credId appName:(NSString*)appName key:(NSString*)key secret:(NSString*)secret address:(NSString*) address;

-(instancetype)initCredentialsWithId:(int) credId appName:(NSString*)appName userName:(NSString*)userName password:(NSString*)password address:(NSString *)address;

///string name of the application
@property int credentialId;

///string name of the application
@property (strong, nonatomic) NSString *appName;

///string a key provided by the LRS
@property (strong, nonatomic) NSString *key;

///string secret provided by the LRS
@property (strong, nonatomic) NSString *secret;

///string address of the LRS
@property (strong, nonatomic) NSString *address;

//user for basicHTTP autherntication
@property  (strong, nonatomic) NSString *userName;

//pass for basicHTTP autenticarion
@property   (strong, nonatomic)NSString *password;

//Base64 encoded userName:password
-(NSString *)encodedCredentials;

@end
