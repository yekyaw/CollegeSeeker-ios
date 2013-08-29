//
//  CollegeDetailViewController.h
//  College Seeker
//
//  Created by Ye Kyaw on 8/21/13.
//  Copyright (c) 2013 Ye Kyaw. All rights reserved.
//

#import "CollegeDetailViewController.h"
#import "College.h"

@interface CollegeDetailViewController : UITableViewController

@property (strong, nonatomic) College *college;
@property (weak, nonatomic) IBOutlet UIImageView *collegeIcon;
@property (weak, nonatomic) IBOutlet UILabel *collegeLabel;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *classification;
@property (weak, nonatomic) IBOutlet UILabel *collegeUrl;
@property (weak, nonatomic) IBOutlet UILabel *admUrl;
@property (weak, nonatomic) IBOutlet UILabel *finAidUrl;
@property (weak, nonatomic) IBOutlet UILabel *appUrl;
@property (weak, nonatomic) IBOutlet UILabel *calcUrl;
@property (weak, nonatomic) IBOutlet UILabel *appFee;
@property (weak, nonatomic) IBOutlet UILabel *enrollment;
@property (weak, nonatomic) IBOutlet UILabel *acceptanceRate;
@property (weak, nonatomic) IBOutlet UILabel *facultyRatio;
@property (weak, nonatomic) IBOutlet UILabel *resourcesSpent;
@property (weak, nonatomic) IBOutlet UILabel *endowment;
@property (weak, nonatomic) IBOutlet UILabel *genderRatio;
@property (weak, nonatomic) IBOutlet UILabel *sat25;
@property (weak, nonatomic) IBOutlet UILabel *sat75;
@property (weak, nonatomic) IBOutlet UILabel *act25;
@property (weak, nonatomic) IBOutlet UILabel *act75;
@property (weak, nonatomic) IBOutlet UILabel *fourYrGradRate;
@property (weak, nonatomic) IBOutlet UILabel *sixYrGradRate;
@property (weak, nonatomic) IBOutlet UILabel *retentionRate;
@property (weak, nonatomic) IBOutlet UILabel *tuitionInState;
@property (weak, nonatomic) IBOutlet UILabel *tuitionOutState;
@property (weak, nonatomic) IBOutlet UILabel *roomAndBoard;
@property (weak, nonatomic) IBOutlet UILabel *totalCostInState;
@property (weak, nonatomic) IBOutlet UILabel *totalCostOutState;
@property (weak, nonatomic) IBOutlet UILabel *percentFinAid;
@property (weak, nonatomic) IBOutlet UILabel *percentGrantAid;
@property (weak, nonatomic) IBOutlet UILabel *netCost;
@property (weak, nonatomic) IBOutlet UILabel *netCost1;
@property (weak, nonatomic) IBOutlet UILabel *netCost2;
@property (weak, nonatomic) IBOutlet UILabel *netCost3;
@property (weak, nonatomic) IBOutlet UILabel *netCost4;
@property (weak, nonatomic) IBOutlet UILabel *netCost5;
@property (atomic, weak) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navButton;
- (IBAction)saveButtonPressed:(id)sender;

@end
