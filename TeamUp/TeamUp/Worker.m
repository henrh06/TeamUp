//
//  Worker.m
//  TeamUp
//
//  Created by Henrik Heggland on 01.10.13.
//  Copyright (c) 2013 Henrik Heggland. All rights reserved.
//

#import "Worker.h"

@implementation Worker

- (NSArray *)getAllPlayersInList {
    
    NSMutableArray *a = [[NSMutableArray alloc]init];
    
    const char* sqlStatement = "SELECT * FROM Players";
    sqlite3_stmt *statement;
    
    
    if( sqlite3_prepare_v2(db, sqlStatement, -1, &statement, NULL) == SQLITE_OK )
    {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            Player *p = [[Player alloc]init];
            // Firstname, lastname and position as UTF8 string for unicode characters
            p.firstName = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 0)];
            p.lastName = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 1)];
            p.position = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 2)];
            p.number = [[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 3)]intValue];
            p.rating = [[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 4)]intValue];
            p.email = [NSString stringWithUTF8String:(char *) sqlite3_column_text(statement, 5)];
            
            [a addObject:p];
    
        }
    }else {
        
        NSLog(@"Couldnt read players into array from sql db");
    }
    
    return a;    
}

-(int)returnTotalRating {
    
    const char* sqlStatement = "SELECT SUM(Rating) AS TOTAL FROM Players";
    sqlite3_stmt *statement;
    
    int rating = 0;
    int divider = 0;
    
    if( sqlite3_prepare_v2(db, sqlStatement, -1, &statement, NULL) == SQLITE_OK )
    {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            rating =  sqlite3_column_int(statement, 0);
            
        }
    }else {
        
        NSLog(@"Couldnt summarize rating");
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(db);
    
    [self openDB];
    divider = [self getNumberOfPlayers];
    
    if (divider > 0) {
        
        rating = rating / divider; 
    }
    
        return rating;
}

-(int)getNumberOfPlayers {
    
    int count = 0;

        const char* sqlStatement = "SELECT COUNT(*) FROM Players";
        sqlite3_stmt *statement;
        
        if( sqlite3_prepare_v2(db, sqlStatement, -1, &statement, NULL) == SQLITE_OK )
        {
            //Loop through all the returned rows (should be just one)
            while( sqlite3_step(statement) == SQLITE_ROW )
            {
                count = sqlite3_column_int(statement, 0);
            }
        
        // Finalize and close database.
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    
    return count;
}

-(void)updatePlayerInTeamView:(Player *)player l:(int)line p:(NSString *)position {
    
/*
 Method will take a player (based on first and lastname) and update it by first deleting it and then using the savePlayerToDb method. Method will be used inTeamViewController to assign a player a postion and line on the team.
 */
    
    NSString *sqlDelete1 = [NSString stringWithFormat:@"DELETE FROM Players WHERE FirstName = '%@'",player.firstName];
    NSString *sqlDeleteFinal = [sqlDelete1 stringByAppendingString:[NSString stringWithFormat:@" AND SecondName = '%@'",player.lastName]];
    
    NSLog(sqlDeleteFinal);
    
    char *err;
    
    if (sqlite3_exec(db, [sqlDeleteFinal UTF8String], NULL, NULL, &err) != SQLITE_OK ) {
        
        NSLog(@"To be able to update the player it first has to be deleted. Since it could not be deleted it will not be updated");
        
    } else {
        
        NSLog(@"Player deleted successfully before update. Continuing to update selected player by creating it again");
        
        [self savePlayerToDb:@"null" fn:player.firstName ln:player.lastName p:position mr:player.number r:player.rating em:player.email l:line];
    }
    
    sqlite3_close(db);
    
}

-(void) savePlayerToDb: (NSString *)forShow fn:(NSString *)FirstName ln:(NSString *)LastName p:(NSString *)position mr:(int)mobileNr r:(int)rating em:(NSString *)Email l:(int)line {
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO Players ('FirstName','SecondName','Position','Number','Rating','Email','line') VALUES ('%@','%@','%@','%d','%d','%@','%d')",FirstName,LastName,position,mobileNr,rating,Email,line];
    char *err;
    
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK ) {
        
        sqlite3_close(db);
        
        NSLog(@"Could not create player");
    } else {
        
        NSLog(@"Player created");
    }
}

- (void)createTable {
    
    //Creates the tables
    //Creates check to prevent table being created when table exists

        NSArray *col = [[NSArray alloc]initWithObjects:@"Players",@"FirstName",@"SecondName",@"Position",@"Number",@"Rating",@"Email",@"Goals",@"Assists",@"Penalty",@"Attribute",@"Line", nil];
    
    char *err;
    
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' "
                                                "TEXT, '%@' TEXT, '%@' TEXT, '%@' INTEGER, '%@' INTEGER, '%@' TEXT, '%@' INTEGER, '%@' INTEGER, '%@' INTEGER, '%@' TEXT, '%@' INTEGER);", [col objectAtIndex:0],[col objectAtIndex:1],[col objectAtIndex:2],[col objectAtIndex:3],[col objectAtIndex:4],[col objectAtIndex:5],[col objectAtIndex:6],[col objectAtIndex:7],[col objectAtIndex:8],[col objectAtIndex:9],[col objectAtIndex:10],[col objectAtIndex:11]];

    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)
        != SQLITE_OK) {
        
        NSLog(@"Could not create table");
        NSAssert(0, @"...");
        
    } else {
            
            NSLog(@"Table creation method run successfully. Doesnt mean a new table was created.");
            
    }
}

- (NSString *) dbPath {
    
 //path to sql db
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:@"bp.sql"];
    
}

- (void) openDB {
    
    //Open db connection
    if (sqlite3_open([[self dbPath] UTF8String], &db) != SQLITE_OK) {
        
        sqlite3_close(db);
        
    }
}

@end
