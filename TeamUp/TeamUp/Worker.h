//
//  Worker.h
//  TeamUp
//
//  Created by Henrik Heggland on 01.10.13.
//  Copyright (c) 2013 Henrik Heggland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Player.h"

@interface Worker : NSObject {
    
    sqlite3 *db;
}

- (NSString *)returnPlayerWithNameToPositionAndLine:(int)line p:(NSString *)position;

-(void)updatePlayerInTeamView:(Player *)player l:(int)line p:(NSString *)position;

- (NSArray *)getAllPlayersInList;

- (void)createTable;

- (void) openDB;

-(void) savePlayerToDb: (NSString *)forShow fn:(NSString *)FirstName ln:(NSString *)LastName p:(NSString *)position mr:(int)mobileNr r:(int)rating em:(NSString *)Email l:(int)line ;

-(int)getNumberOfPlayers;

-(int)returnTotalRating;

@end
