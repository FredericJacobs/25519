//
//  Curve25519.h
//  BuildTests
//
//  Created by Frederic Jacobs on 22/07/14.
//  Copyright (c) 2014 Open Whisper Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ECCKeyLength 32
#define ECCSignatureLength 64

@interface ECKeyPair : NSObject<NSCoding> {
    uint8_t publicKey[ECCKeyLength];
    uint8_t privateKey[ECCKeyLength];
}

/**
 * Export the key pair's public key.
 *
 * @return The key pair's public key.
 */
-(NSData*) sign:(NSData*)data;
-(NSData*) publicKey;

@end

@interface Curve25519 : NSObject

+(NSData*) generateSharedSecretFromPublicKey:(NSData*)theirPublicKey andKeyPair:(ECKeyPair*)keyPair;

+(ECKeyPair*)generateKeyPair;

@end
