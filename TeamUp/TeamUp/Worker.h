//
//  Worker.h
//  TeamUp
//
//  Created by Henrik Heggland on 01.10.13.
//  Copyright (c) 2013 Henrik Heggland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Worker : NSObject {
    
    sqlite3 *db;
}

- (void)createTable: (NSString *)TableName f1:(NSString *) field1 f2:(NSString *)field2 f3:(NSString *)field3 f4:(NSString *)field4 f5:(NSString *)field5;

- (void) openDB;

-(void) savePlayerToDb: (NSString *)forShow fn:(NSString *)FirstName ln:(NSString *)LastName p:(NSString *)position mr:(int)mobileNr r:(int)rating;

-(int)getNumberOfPlayers;

-(int)returnTotalRating;

@end
