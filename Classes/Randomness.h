//
//  Randomness.h
//  AxolotlKit
//
//  Created by Frederic Jacobs on 21/07/14.
//  Copyright (c) 2014 Frederic Jacobs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Randomness : NSObject

+(NSMutableData*) generateRandomBytes:(int)numberBytes;

@end
