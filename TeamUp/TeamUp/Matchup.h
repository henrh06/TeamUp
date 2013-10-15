//
//  Matchup.h
//  TeamUp
//
//  Created by Henrik Heggland on 15.10.13.
//  Copyright (c) 2013 Henrik Heggland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"

@interface Matchup : NSObject {
    
    NSString *oponant;
    NSString *note;
    NSDate *date;
    int home;
    int away;
    
    NSMutableArray *events;
}

- (void)addEvent:(Event *)event;

@property(nonatomic, retain)NSString *oponant;
@property(nonatomic, retain)NSString *note;
@property(nonatomic, retain)NSDate *date;
@property int home;
@property int away;

@end
