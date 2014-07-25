//
//  Ed25519.m
//  BuildTests
//
//  Created by Frederic Jacobs on 22/07/14.
//  Copyright (c) 2014 Open Whisper Systems. All rights reserved.
//

#import "Ed25519.h"
#import "Curve25519.h"

@interface ECKeyPair ()
-(NSData*) sign:(NSData*)data;
@end

extern int curve25519_verify(const unsigned char* signature, /* 64 bytes */
                      const unsigned char* curve25519_pubkey, /* 32 bytes */
                      const unsigned char* msg, const unsigned long msg_len);

@implementation Ed25519

+(NSData*)sign:(NSData*)msg withKeyPair:(ECKeyPair*)keyPair{
    return [keyPair sign:msg];
}

+(BOOL)verifySignature:(NSData*)signature publicKey:(NSData*)pubKey msg:(NSData*)msg{
    
    if ([msg length]<1) {
        return FALSE;
    }
    
    if ([pubKey length] != ECCKeyLength) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Public Key isn't 32 bytes" userInfo:nil];
    }
    
    if ([signature length] != ECCSignatureLength) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Signature isn't 64 bytes" userInfo:nil];
    }
    
    BOOL success = (curve25519_verify([signature bytes], [pubKey bytes], [msg bytes], [msg length]) == 0);
    
    return success;
}

@end
