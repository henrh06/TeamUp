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
@synthesize pwf,goalie,lb1,lb2,lb3,rb1,rb2,rb3,c1,c2,c3,rw1,rw2,rw3,availibleLines;

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
    availibleLines = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",nil];
    
    
}

-(IBAction)goBack {
    
    NSString *storyboard  = [[NSBundle mainBundle].infoDictionary objectForKey:@"UIMainStoryboardFile"];
    
    UIStoryboard *st = [UIStoryboard storyboardWithName:storyboard bundle:[NSBundle mainBundle]];
    UIViewController *vc = [st instantiateInitialViewController];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)selectPositionToSetPlayer:(UIButton *)sender {
    
    NSMutableString *bTitle = [NSMutableString stringWithString:sender.titleLabel.text];
    
    
    if ([bTitle  isEqual: @"G"]) {
        
        bTitle = [NSMutableString stringWithString:@"goalie"];
    }
    
    if ([bTitle  isEqual: @"RW"]) {
        
        bTitle = [NSMutableString stringWithString:@"right winger"];
    }
    
    if ([bTitle  isEqual: @"LW"]) {
        
        bTitle = [NSMutableString stringWithString:@"left winger"];
    }
    
    if ([bTitle  isEqual: @"C"]) {
        
        bTitle = [NSMutableString stringWithString:@"center"];
    }
    
    if ([bTitle  isEqual: @"LB"]) {
        
        bTitle = [NSMutableString stringWithString:@"left back"];
    }
    
    if ([bTitle  isEqual: @"RB"]) {
        
        bTitle = [NSMutableString stringWithString:@"right back"];
    }
    
    pwf = [[PlayerWorkflow alloc]init];
    pwf.position = bTitle;
    pwf.wfStep = 0;
    
    [self selectPlayerToSelectedPosition];

}

- (void)updateTeam {
    
    Player *p = pwf.selectedPlayer;
    
    Worker *w = [[Worker alloc]init];
    
    [w openDB];
    [w updatePlayerInTeamView:p l:pwf.line p:pwf.position];
    
}

-(void)createTable {
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height)];
    table.delegate = self;
    table.dataSource = self;
    
    [self.view addSubview:table];
}


-(void)selectPlayerToSelectedPosition {
    
    [self createTable];
    
}

-(void)SetSelectedPlayerToNewPosition:(Player *)selectedPlayer p:(NSString *)position {
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    int count = 0;
   
    if (pwf.wfStep == 0) {
        
        Worker *w = [[Worker alloc]init];
        
        [w openDB];
        
        count = [w getNumberOfPlayers];
        
    } else {
    
        count = 3;
        
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    if (pwf.wfStep == 0) {
        
        Worker *w = [[Worker alloc]init];
        
        [w openDB];
        
        NSArray *a = [w getAllPlayersInList];
        
        Player *p  = [a objectAtIndex:indexPath.row];
        
        cell.textLabel.text = p.firstName;
    
    } else {
        
         cell.textLabel.text = [availibleLines objectAtIndex:indexPath.row];
        
    }
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        if (pwf.wfStep == 0) {
    
    Worker *w = [[Worker alloc]init];
    
    [w openDB];
    
    NSArray *a = [w getAllPlayersInList];
    
    Player *p  = [a objectAtIndex:indexPath.row];
    
    pwf.selectedPlayer = p;
            
            pwf.wfStep = 1;
            
            [table removeFromSuperview];
            
            [self createTable];
            
        } else {
            
            pwf.line = [[availibleLines objectAtIndex:indexPath.row] intValue];
            
            [table removeFromSuperview];
            
            [self updateTeam];
        }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
