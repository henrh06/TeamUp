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
@synthesize pwf,goalie,lb1,lb2,lb3,rb1,rb2,rb3,c1,c2,c3,rw1,rw2,rw3,availibleLines,lw1,lw2,lw3;

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
    
    Worker *w = [[Worker alloc]init];
    [w openDB];
    
    goalie.text = [w returnPlayerWithNameToPositionAndLine:1 p:@"goalie"];
    lb1.text = [w returnPlayerWithNameToPositionAndLine:1 p:@"left back"];
    lb2.text = [w returnPlayerWithNameToPositionAndLine:2 p:@"left back"];
    lb3.text = [w returnPlayerWithNameToPositionAndLine:3 p:@"left back"];
    rb1.text = [w returnPlayerWithNameToPositionAndLine:1 p:@"right back"];
    rb2.text = [w returnPlayerWithNameToPositionAndLine:2 p:@"right back"];
    rb3.text = [w returnPlayerWithNameToPositionAndLine:3 p:@"right back"];
    c1.text = [w returnPlayerWithNameToPositionAndLine:1 p:@"center"];
    c2.text = [w returnPlayerWithNameToPositionAndLine:2 p:@"center"];
    c3.text = [w returnPlayerWithNameToPositionAndLine:3 p:@"center"];
    rw1.text = [w returnPlayerWithNameToPositionAndLine:1 p:@"right winger"];
    rw2.text = [w returnPlayerWithNameToPositionAndLine:2 p:@"right winger"];
    rw3.text = [w returnPlayerWithNameToPositionAndLine:3 p:@"right winger"];
    lw1.text = [w returnPlayerWithNameToPositionAndLine:1 p:@"left winger"];
    lw2.text = [w returnPlayerWithNameToPositionAndLine:2 p:@"left winger"];
    lw3.text = [w returnPlayerWithNameToPositionAndLine:3 p:@"left winger"];
    
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
    
    TeamViewController *screen = [[TeamViewController alloc]initWithNibName:Nil bundle:Nil];
    screen.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:screen animated:YES completion:nil];
    
}

-(void)createTable {
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 44)];
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
        
        NSString *fn = p.firstName;
        NSString *fullName = [fn stringByAppendingString:[NSString stringWithFormat:@" %@",p.lastName]];
        
        cell.textLabel.text = fullName;
    
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
