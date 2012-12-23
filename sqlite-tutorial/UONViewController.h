//
//  UONViewController.h
//  sqlite-tutorial
//
//  Created by Shaun Hare on 21/12/2012.
//  Copyright (c) 2012 Shaun Hare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "/usr/include/sqlite3.h"

@interface UONViewController : UIViewController{

    sqlite3 *database;
    UITextField *sessionTutor;
    UITextField *sessionDate;
    UILabel *sessionStatus;
    
    NSString *databasePath;
}

@property (strong,nonatomic) IBOutlet UITextField *sessionTutor;
@property (strong,nonatomic) IBOutlet UITextField *sessionDate;
@property (strong,nonatomic) IBOutlet UILabel *sessionStatus;

-(IBAction) saveData;
-(IBAction) findSession;

@end
