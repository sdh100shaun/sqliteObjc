//
//  UONViewController.m
//  sqlite-tutorial
//
//  Created by Shaun Hare on 21/12/2012.
//  Copyright (c) 2012 Shaun Hare. All rights reserved.
//

#import "UONViewController.h"

@interface UONViewController ()

@end

@implementation UONViewController

@synthesize sessionDate;
@synthesize sessionTutor;
@synthesize sessionStatus;

-(void) saveData
{
    sqlite3_stmt *statement;
    
    const char *dbpath =  [databasePath UTF8String];
    
    if(sqlite3_open(dbpath,&database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO SESSIONS (SESSIONTUTOR,SESSIONDATE) VALUES (\"%@\",\"%@\")",sessionTutor.text,sessionDate.text];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare(database,insert_stmt,-1, &statement, NULL);
        if(sqlite3_step(statement) == SQLITE_DONE)
        {
            [sessionTutor setText:@" "]; 
            [sessionDate setText:@""];
            [sessionStatus setText: @"session added"];
        }
        else{
            sessionStatus.text = @"failed to add session";
            
        }
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    
}

-(void) findSession
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT SESSIONTUTOR,SESSIONDATE FROM SESSIONS WHERE SESSIONDATE=\"%@\"", sessionDate.text];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *session_Date = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                sessionDate.text = session_Date;
                
                NSString *session_Tutor = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                sessionTutor.text = session_Tutor;
                
                sessionStatus.text = @"Match found";
                
                            } else {
                sessionStatus.text = @"Match not found";
                sessionTutor.text = @"";
                sessionDate.text = @"";
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(database);
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString* docsDir;
    NSArray* dirPaths;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,
                                                   YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    NSLog(@"%@",docsDir); 
    
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"sessions.db"]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if([fileManager fileExistsAtPath:databasePath] == NO)
    {
        const char *dbPath = [databasePath UTF8String];
        
         if( sqlite3_open(dbPath, &database) == SQLITE_OK)
         {
             char * errMsgs;
             
             const char *sql_stmt = "CREATE TABLE IF NOT EXISTS SESSIONS(ID INTEGER PRIMARY KEY AUTOINCREMENT, SESSIONTUTOR TEXT, SESSIONDATE TEXT)";
             
             if(sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsgs) != SQLITE_OK)
             {
                 sessionStatus.text = @"Failed to create table ";
             }
             sqlite3_close(database);
             
             
         }
         else
         {
             
          sessionStatus.text = @"failed to open / create database";
         }
    }
    
    
    
    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
