//
//  AddPlayerViewController.h
//  TeamUp
//
//  Created by Henrik Heggland on 03.10.13.
//  Copyright (c) 2013 Henrik Heggland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPlayerViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate> {
    
    IBOutlet UITextField *fn;
    IBOutlet UITextField *ln;
    IBOutlet UITextField *mr;
    IBOutlet UIPickerView *picker;
    IBOutlet UIStepper *stepper;
    
   
    

}

@property(nonatomic, retain) IBOutlet UILabel *rating;
@property(nonatomic, retain) NSArray *positions;

-(IBAction)savePlayer;


@end
