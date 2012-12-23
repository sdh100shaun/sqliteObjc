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
    
}

-(void) findSession
{
    
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
