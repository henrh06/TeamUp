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
            p.firstName = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 0)];
            p.LastName = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 1)];
            p.position = [NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 2)];
            p.number = [[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 3)]intValue];
            p.rating = [[NSString stringWithFormat:@"%s",sqlite3_column_text(statement, 4)]intValue];
            
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
    int devider = 0;
    
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
    devider = [self getNumberOfPlayers];
    
    if (devider < 0) {
        return rating / devider;
    }
    
    else {
        return 0;
    }

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

-(void) savePlayerToDb: (NSString *)forShow fn:(NSString *)FirstName ln:(NSString *)LastName p:(NSString *)position mr:(int)mobileNr r:(int)rating {
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO Players ('FirstName','SecondName','Position','Number','Rating') VALUES ('%@','%@','%@','%d','%d')",FirstName,LastName,position,mobileNr,rating];
    char *err;
    
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK ) {
        
        sqlite3_close(db);
        
        NSLog(@"Could not create player");
    } else {
        
        NSLog(@"Player created");
    }
}

- (void)createTable: (NSString *)TableName f1:(NSString *) field1 f2:(NSString *)field2 f3:(NSString *)field3 f4:(NSString *)field4 f5:(NSString *)field5 {
    
    //Creates the tables
    //Creates check to prevent table being created when table exists
    
    char *err;
    
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' "
                                                "TEXT, '%@' TEXT, '%@' TEXT, '%@' INTEGER, '%@' INTEGER);", TableName,field1,field2,field3,field4,field5];
    
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)
        != SQLITE_OK) {
        
        NSLog(@"Could not create table");
        NSAssert(0, @"...");
        
    } else {
            
            NSLog(@"Table createation method run successfully. Doesnt mean a new table was created.");
            
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
