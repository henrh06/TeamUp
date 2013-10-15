//
//  TeamViewController.h
//  TeamUp
//
//  Created by Henrik Heggland on 08.10.13.
//  Copyright (c) 2013 Henrik Heggland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "Worker.h"
#import "PlayerWorkflow.h"
#import "Singleton.h"
#import "Matchup.h"
#import <QuartzCore/QuartzCore.h>
#import "MatchupViewController.h"

@interface TeamViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
    UITableView *table;
    UITextField *oponant;
    UIView *mView;
    
    
}

@property(nonatomic, retain)NSArray *availibleLines;
@property(nonatomic, retain)PlayerWorkflow *pwf;
@property(nonatomic, retain) IBOutlet UILabel *rw1;
@property(nonatomic, retain)IBOutlet UILabel *rw2;
@property(nonatomic, retain)IBOutlet UILabel *rw3;

@property(nonatomic, retain)IBOutlet UILabel *lw1;
@property(nonatomic, retain)IBOutlet UILabel *lw2;
@property(nonatomic, retain)IBOutlet UILabel *lw3;

@property(nonatomic, retain)IBOutlet UILabel *c1;
@property(nonatomic, retain)IBOutlet UILabel *c2;
@property(nonatomic, retain)IBOutlet UILabel *c3;

@property(nonatomic, retain)IBOutlet UILabel *rb1;
@property(nonatomic, retain)IBOutlet UILabel *rb2;
@property(nonatomic, retain)IBOutlet UILabel *rb3;

@property(nonatomic, retain)IBOutlet UILabel *lb1;
@property(nonatomic, retain)IBOutlet UILabel *lb2;
@property(nonatomic, retain)IBOutlet UILabel *lb3;

@property(nonatomic, retain)IBOutlet UILabel *goalie;

-(IBAction)goBack;

- (IBAction)selectPositionToSetPlayer:(UIButton *)sender;

- (IBAction)goToMatchup;


@end
