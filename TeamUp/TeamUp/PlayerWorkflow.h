//
//  PlayerWorkflow.h
//  TeamUp
//
//  Created by Henrik Heggland on 10.10.13.
//  Copyright (c) 2013 Henrik Heggland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface PlayerWorkflow : NSObject {
    
    int line;
    NSString *position;
    Player *selectedPlayer;
    int wfStep;
}

@property int wfStep;
@property int line;
@property(nonatomic, retain)NSString *position;
@property(nonatomic, retain)Player *selectedPlayer;


@end
