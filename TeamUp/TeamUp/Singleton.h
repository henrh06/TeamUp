//
//  Singleton.h
//  TeamUp
//
//  Created by Henrik Heggland on 15.10.13.
//  Copyright (c) 2013 Henrik Heggland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Matchup.h"

@interface Singleton : NSObject {
    
    Matchup *match;
}

@property(nonatomic, retain)Matchup *match;

+ (id)sharedManager;

@end
