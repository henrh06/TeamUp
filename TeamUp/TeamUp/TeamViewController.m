//
//  TeamViewController.m
//  TeamUp
//
//  Created by Henrik Heggland on 08.10.13.
//  Copyright (c) 2013 Henrik Heggland. All rights reserved.
//

#import "TeamViewController.h"

@interface TeamViewController ()

@end

@implementation TeamViewController

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
    
    
}

-(IBAction)goBack {
    
    NSString *storyboard  = [[NSBundle mainBundle].infoDictionary objectForKey:@"UIMainStoryboardFile"];
    
    UIStoryboard *st = [UIStoryboard storyboardWithName:storyboard bundle:[NSBundle mainBundle]];
    UIViewController *vc = [st instantiateInitialViewController];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)selectPlayer:(UIButton *)sender {
    
    NSString *bTitle = sender.titleLabel.text;
    
    NSLog(@"Button title:");
    
    NSLog(bTitle);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
