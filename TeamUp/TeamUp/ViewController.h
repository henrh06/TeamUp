//
//  ViewController.h
//  TeamUp
//Checkout test 01.10.2013
//  Created by Henrik Heggland on 01.10.13.
//  Copyright (c) 2013 Henrik Heggland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Worker.h"
#import "PlayersViewController.h"
#import "TeamViewController.h"

@interface ViewController : UIViewController {
    
    
}

@property(nonatomic, retain)IBOutlet UILabel *nrPlayers;
@property(nonatomic, retain)IBOutlet UILabel *rating;

-(IBAction)goToPlayer;
-(IBAction)goToTeam;

@end
