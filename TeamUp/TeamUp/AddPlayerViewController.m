//
//  AddPlayerViewController.m
//  TeamUp
//
//  Created by Henrik Heggland on 03.10.13.
//  Copyright (c) 2013 Henrik Heggland. All rights reserved.
//

#import "AddPlayerViewController.h"

@interface AddPlayerViewController ()

@end

@implementation AddPlayerViewController
@synthesize positions, rating;

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
    positions = [[NSArray alloc]initWithObjects:@"goalie",@"right back",@"left back",@"center",@"right winger",@"left winger", nil];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    
    if (fn.isFirstResponder) {
        
        [fn resignFirstResponder];
    }
    
    if (ln.isFirstResponder) {
        
        [ln resignFirstResponder];
    }
    
    if (mr.isFirstResponder) {
        
        [mr resignFirstResponder];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component {
    
    return 6;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    
    return [self.positions objectAtIndex:row];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component{
    
}


-(IBAction)savePlayer {
    
    NSString *firstName = fn.text;
    NSString *lastName = ln.text;
    int rat = [rating.text intValue];
    int mobile = [mr.text intValue];
    
    //Get picked position
    NSInteger row;
    NSArray *repeatPickerData;
    UIPickerView *repeatPickerView;
    row = [repeatPickerView selectedRowInComponent:0];
    NSString *selectedPosition = [repeatPickerData objectAtIndex:row];
    
    Worker *w = [[Worker alloc]init];
    
    [w openDB];
    
    [w savePlayerToDb:@"Skoyter" fn:firstName ln:lastName p:selectedPosition mr:mobile r:rat];
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end