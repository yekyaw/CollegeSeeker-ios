//
//  FirstViewController.h
//  College Seeker
//
//  Created by Ye Kyaw on 8/18/13.
//  Copyright (c) 2013 Ye Kyaw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate, UITextFieldDelegate>

@property (atomic, weak) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UIButton *stateButton;
@property (weak, nonatomic) IBOutlet UIButton *sortButton;
@property (weak, nonatomic) IBOutlet UISwitch *smallEnrollment;
@property (weak, nonatomic) IBOutlet UISwitch *mediumEnrollment;
@property (weak, nonatomic) IBOutlet UISwitch *largeEnrollment;
@property (weak, nonatomic) IBOutlet UISwitch *city;
@property (weak, nonatomic) IBOutlet UISwitch *suburb;
@property (weak, nonatomic) IBOutlet UISwitch *town;
@property (weak, nonatomic) IBOutlet UISwitch *rural;
@property (weak, nonatomic) IBOutlet UISwitch *public_t;
@property (weak, nonatomic) IBOutlet UISwitch *private_fp;
@property (weak, nonatomic) IBOutlet UISwitch *private_nfp;
@property (weak, nonatomic) IBOutlet UISwitch *religious;
@property (weak, nonatomic) IBOutlet UITextField *ver;
@property (weak, nonatomic) IBOutlet UITextField *mat;
@property (weak, nonatomic) IBOutlet UITextField *wri;
@property (weak, nonatomic) IBOutlet UITextField *act;

- (IBAction)stateButtonPressed:(id)sender;
- (IBAction)sortButtonPressed:(id)sender;

@end
