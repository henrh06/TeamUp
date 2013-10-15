//
//  PlayersViewController.m
//  TeamUp
//
//  Created by Henrik Heggland on 03.10.13.
//  Copyright (c) 2013 Henrik Heggland. All rights reserved.
//

#import "PlayersViewController.h"

@interface PlayersViewController ()

@end

@implementation PlayersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    Worker *w = [[Worker alloc]init];
    
    [w openDB];
    
    int count = [w getNumberOfPlayers];
    
    int yy = (count * 100) - 600;
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44)];
    scroll.scrollEnabled = YES;
    scroll.userInteractionEnabled = YES;
    scroll.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + yy);
    
    [self.view addSubview:scroll];
    
    int y = 0;
    
    [w openDB];
    NSArray * a = [w getAllPlayersInList];
    
    for (Player * object in a) {
        
        NSString *f = object.firstName;
        NSString *dev = @" ";
        NSString *l = object.lastName;
        NSString *f1 = [f stringByAppendingString:dev];
        NSString *fullName = [f1 stringByAppendingString:l];
        
        
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, y, self.view.frame.size.width, 100)];
        v.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"playerbg2.png"]];
        [scroll addSubview:v];
        
        UILabel *fn = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, v.frame.size.width -10, 30)];
        [fn setFont:[UIFont fontWithName:@"Futura-Medium" size:24.0]];
        fn.text = fullName;
        fn.textColor = [UIColor whiteColor];
        [v addSubview:fn];
        
        UILabel *pos = [[UILabel alloc]initWithFrame:CGRectMake(5, 40, 100, 20)];
        pos.textColor = [UIColor whiteColor];
        pos.text = object.position;
        [v addSubview:pos];
        
        int len = 110;
        
        for (int x = 1; x <= object.rating; x++) {
            
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(len, 45, 15, 15)];
            imgView.image = [UIImage imageNamed:@"Star.png"];
            [v addSubview:imgView];
            
            len = len + 17;
        }
        
        
        y = y+100;
        
        
    }
     
}


-(IBAction)goToStart {
    
    NSString *storyboard  = [[NSBundle mainBundle].infoDictionary objectForKey:@"UIMainStoryboardFile"];

    UIStoryboard *st = [UIStoryboard storyboardWithName:storyboard bundle:[NSBundle mainBundle]];
    UIViewController *vc = [st instantiateInitialViewController];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:vc animated:YES completion:nil];
    
}

-(IBAction)goToAdd {
    
AddPlayerViewController *screen = [[AddPlayerViewController alloc]initWithNibName:Nil bundle:Nil];
    screen.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:screen animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
