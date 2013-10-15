//
//  Singleton.m
//  TeamUp
//
//  Created by Henrik Heggland on 15.10.13.
//  Copyright (c) 2013 Henrik Heggland. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton
@synthesize match;

+ (id)sharedManager {
    static Singleton *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        
        match = [[Matchup alloc]init];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
