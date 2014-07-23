//
//  Ed25519.h
//  BuildTests
//
//  Created by Frederic Jacobs on 22/07/14.
//  Copyright (c) 2014 Open Whisper Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ECKeyPair;

@interface Ed25519 : NSObject

+(NSData*)sign:(NSData*)msg withKeyPair:(ECKeyPair*)keyPair;
+(BOOL)verifySignature:(NSData*)signature publicKey:(NSData*)pubKey msg:(NSData*)msg;

@end
