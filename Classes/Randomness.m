//
//  Randomness.m
//  AxolotlKit
//
//  Created by Frederic Jacobs on 21/07/14.
//  Copyright (c) 2014 Frederic Jacobs. All rights reserved.
//

#import "Randomness.h"

@implementation Randomness

+(NSMutableData*) generateRandomBytes:(int)numberBytes {
    /* used to generate db master key, and to generate signaling key, both at install */
    NSMutableData* randomBytes = [NSMutableData dataWithLength:numberBytes];
    int err = 0;
    err = SecRandomCopyBytes(kSecRandomDefault,numberBytes,[randomBytes mutableBytes]);
    if(err != noErr) {
        @throw [NSException exceptionWithName:@"random problem" reason:@"problem generating the random " userInfo:nil];
    }
    return randomBytes;
}

@end
