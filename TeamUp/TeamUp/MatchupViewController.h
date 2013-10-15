//
//  MatchupViewController.h
//  TeamUp
//
//  Created by Henrik Heggland on 15.10.13.
//  Copyright (c) 2013 Henrik Heggland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"
#import "Matchup.h"


@interface MatchupViewController : UIViewController {
    
    IBOutlet UILabel *against;
    
}

@property(nonatomic, retain)IBOutlet UILabel *against;
@property(nonatomic, retain)IBOutlet UILabel *score;

@end
