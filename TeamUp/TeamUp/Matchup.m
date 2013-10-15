//
//  Matchup.m
//  TeamUp
//
//  Created by Henrik Heggland on 15.10.13.
//  Copyright (c) 2013 Henrik Heggland. All rights reserved.
//

#import "Matchup.h"

@implementation Matchup
@synthesize oponant, note, date, home, away;

- (void)addEvent:(Event *)event {
    
    [events addObject:event];
    
    NSLog(@"%lu",(unsigned long)[events count]);
}

@end
