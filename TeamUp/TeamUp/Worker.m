//
//  Worker.m
//  TeamUp
//
//  Created by Henrik Heggland on 01.10.13.
//  Copyright (c) 2013 Henrik Heggland. All rights reserved.
//

#import "Worker.h"

@implementation Worker

- (void)createTable: (NSString *)TableName f1:(NSString *) field1 f2:(NSString *)field2 f3:(NSString *)field3 f4:(NSString *)field4 f5:(NSString *)field5 {
    
    //Creates the tables
    //Creates check to prevent table being created when table exists
    
    char *err;
    
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' "
                                                "TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT, '%@' TEXT);", TableName,field1,field2,field3,field4,field5];
    
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err)
        != SQLITE_OK) {
        
        NSLog(@"Could not create table");
        
    } else {
            
            NSLog(@"Table created");
            
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
