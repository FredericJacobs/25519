//
//  BuildTestsTests.m
//  BuildTestsTests
//
//  Created by Frederic Jacobs on 22/07/14.
//  Copyright (c) 2014 Frederic Jacobs. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Curve25519.h"
#import "Randomness.h"
#import "Ed25519.h"

@interface SigningTests : XCTestCase

@end

@implementation SigningTests

- (void)setUp
{
    [super setUp];
    
}

- (void)tearDown
{
    [super tearDown];
}

- (void)randomizedTest
{
    for (int i = 0; i < 10000; i++) {
        
        NSLog(@"Passed test");
        
        ECKeyPair *key = [Curve25519 generateKeyPair];
        
        int rand = random()%10000;
        
        NSLog(@"%d",rand);
        
        NSData *data = [Randomness generateRandomBytes:16];
        
        NSData *signature = [Ed25519 sign:data withKeyPair:key];
        
        XCTAssert([Ed25519 verifySignature:signature publicKey:[key publicKey] msg:data], @"Error in key verification");
        
    }
    
}

- (void)testingSmallDataSizes{
    
    for (int i = 1; i < 100; i++) {
        
        ECKeyPair *key = [Curve25519 generateKeyPair];
        
        int randomNumber = random()%i;
        
        NSData *data = [Randomness generateRandomBytes:randomNumber];
        
        NSData *signature = [Ed25519 sign:data withKeyPair:key];
        
        XCTAssert([Ed25519 verifySignature:signature publicKey:[key publicKey] msg:data], @"Error in key verification");
        
    }
}

- (void)testingLargeDataSizes{
   
    for (int i = 1; i < 100; i++) {
        
        ECKeyPair *key = [Curve25519 generateKeyPair];
                                                       
        NSData *data = [Randomness generateRandomBytes:500000000]; // 500mb
        
        NSData *signature = [Ed25519 sign:data withKeyPair:key];
        
        XCTAssert([Ed25519 verifySignature:signature publicKey:[key publicKey] msg:data], @"Error in key verification");
        
    }
    
}

@end
