//
//  ViewController.m
//  TeamUp
//
//  Created by Henrik Heggland on 01.10.13.
//  Copyright (c) 2013 Henrik Heggland. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize rating, nrPlayers;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    Worker *w = [Worker alloc];
    
    [w openDB];
    
    [w createTable:@"Players" f1:@"FirstName" f2:@"SecondName" f3:@"Position" f4:@"Number" f5:@"Rating"];
    
    nrPlayers.text = [NSString stringWithFormat:@"%d",[w getNumberOfPlayers]];
    [w openDB];
    rating.text = [NSString stringWithFormat:@"%d",[w returnTotalRating]];
}

-(IBAction)goToPlayer {
    
    PlayersViewController *screen = [[PlayersViewController alloc]initWithNibName:Nil bundle:Nil];
    screen.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:screen animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
