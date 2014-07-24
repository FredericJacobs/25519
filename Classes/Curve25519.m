//
//  Curve25519.m
//  BuildTests
//
//  Created by Frederic Jacobs on 22/07/14.
//  Copyright (c) 2014 Open Whisper Systems. All rights reserved.
//

#import "Curve25519.h"
#import "Randomness.h"

NSString * const TSECKeyPairPublicKey   = @"TSECKeyPairPublicKey";
NSString * const TSECKeyPairPrivateKey  = @"TSECKeyPairPrivateKey";
NSString * const TSECKeyPairPreKeyId    = @"TSECKeyPairPreKeyId";

extern void curve25519_donna(unsigned char *output, const unsigned char *a, const unsigned char *b);

extern void curve25519_sign(unsigned char* signature_out,
                            unsigned char* curve25519_privkey,
                            unsigned char* msg, unsigned long msg_len);

@implementation ECKeyPair

-(void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeBytes:self->publicKey length:ECCKeyLength forKey:TSECKeyPairPublicKey];
    [coder encodeBytes:self->privateKey length:ECCKeyLength forKey:TSECKeyPairPrivateKey];
}

-(id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        NSUInteger returnedLength = 0;
        const uint8_t *returnedBuffer = NULL;
        // De-serialize public key
        returnedBuffer = [coder decodeBytesForKey:TSECKeyPairPublicKey returnedLength:&returnedLength];
        if (returnedLength != ECCKeyLength) {
            return nil;
        }
        memcpy(self->publicKey, returnedBuffer, ECCKeyLength);
        
        // De-serialize private key
        returnedBuffer = [coder decodeBytesForKey:TSECKeyPairPrivateKey returnedLength:&returnedLength];
        if (returnedLength != ECCKeyLength) {
            return nil;
        }
        memcpy(self->privateKey, returnedBuffer, ECCKeyLength);
    }
    return self;
}


+(ECKeyPair*)generateKeyPair{
    ECKeyPair* keyPair =[[ECKeyPair alloc] init];
    
    // Generate key pair as described in https://code.google.com/p/curve25519-donna/
    memcpy(keyPair->privateKey, [[Randomness  generateRandomBytes:32] bytes], 32);
    keyPair->privateKey[0] &= 248;
    keyPair->privateKey[31] &= 127;
    keyPair->privateKey[31] |= 64;
    
    static const uint8_t basepoint[ECCKeyLength] = {9};
    curve25519_donna(keyPair->publicKey, keyPair->privateKey, basepoint);
    
    return keyPair;
}

-(NSData*) publicKey {
    return [NSData dataWithBytes:self->publicKey length:32];
}

-(NSData*) sign:(NSData*)data{
    NSUInteger msg_len = [data length];
    uint8_t signatureBuffer[ECCSignatureLength];
    
    uint8_t message[msg_len];
    [data getBytes:signatureBuffer length:msg_len];
    
    curve25519_sign(signatureBuffer, self->privateKey, message, msg_len);
    
    return [NSData dataWithBytes:signatureBuffer length:ECCSignatureLength];
}

-(NSData*) generateSharedSecretFromPublicKey:(NSData*)theirPublicKey {
    unsigned char *sharedSecret = NULL;
    
    if ([theirPublicKey length] != 32) {
        NSLog(@"Key does not contain 32 bytes");
        @throw [NSException exceptionWithName:@"Invalid argument" reason:@" The supplied public key does not contain 32 bytes" userInfo:nil];
    }
    
    sharedSecret = malloc(32);
    if (sharedSecret == NULL) {
        return nil;
    }
    
    curve25519_donna(sharedSecret,self->privateKey, [theirPublicKey bytes]);
    
    return [NSData dataWithBytes:sharedSecret length:32];
}

@end

@implementation Curve25519

+(ECKeyPair*)generateKeyPair{
    return [ECKeyPair generateKeyPair];
}

+(NSData*)generateSharedSecretFromPublicKey:(NSData *)theirPublicKey andKeyPair:(ECKeyPair *)keyPair{
    return [keyPair generateSharedSecretFromPublicKey:theirPublicKey];
}

@end
