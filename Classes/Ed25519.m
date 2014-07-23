//
//  Ed25519.m
//  BuildTests
//
//  Created by Frederic Jacobs on 22/07/14.
//  Copyright (c) 2014 Open Whisper Systems. All rights reserved.
//

#import "Ed25519.h"
#import "Curve25519.h"

extern int curve25519_verify(unsigned char* signature,
                      unsigned char* curve25519_pubkey,
                      unsigned char* msg, unsigned long msg_len);


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
    
    NSUInteger msg_len = [msg length];
    
    uint8_t publicKeyBuffer[ECCKeyLength];
    [pubKey getBytes:publicKeyBuffer length:ECCKeyLength];
    
    uint8_t messageBuffer[[msg length]];
    [msg getBytes:messageBuffer length:[msg length]];
    
    uint8_t signatureBuffer[ECCSignatureLength];
    [signature getBytes:signatureBuffer length:[signature length]];
    
    BOOL success = (curve25519_verify(signatureBuffer, publicKeyBuffer, messageBuffer, msg_len) == 0);
    
    return success;
}



@end
