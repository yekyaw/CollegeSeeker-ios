//
//  CollegeDetailViewController.m
//  College Seeker
//
//  Created by Ye Kyaw on 8/21/13.
//  Copyright (c) 2013 Ye Kyaw. All rights reserved.
//

#import "CollegeDetailViewController.h"
#import "AppDelegate.h"
#import "SavedCollege.h"
#import "Constants.h"
#import "WebViewController.h"

@interface CollegeDetailViewController () {
    BOOL isSaved;
}

@end

@implementation CollegeDetailViewController

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
	// Do any additional setup after loading the view.
    self.collegeLabel.text = self.college.name;
    if ([self.college.icon length] > 0) {
        NSString* filePath = [[NSBundle mainBundle] pathForResource:self.college.icon
                                                        ofType:@"png" inDirectory:@"res"];
        self.collegeIcon.image = [UIImage imageWithContentsOfFile: filePath];
    }
    self.type.text = self.college.type;
    self.classification.text = self.college.classification;
    self.collegeUrl.text = self.college.webUrl;
    self.admUrl.text = self.college.admUrl;
    self.finAidUrl.text = self.college.finUrl;
    self.appUrl.text = self.college.appUrl;
    self.calcUrl.text = self.college.calcUrl;
    self.appFee.text = [NSString stringWithFormat:@"$%d",self.college.applicationFee];
    self.enrollment.text = [NSString stringWithFormat:@"%d", self.college.totalEnrolled];
    if (self.college.applicants != 0)
        self.acceptanceRate.text = [NSString stringWithFormat:@"%.1f%%", (double)self.college.admits / self.college.applicants * 100];
    else
        self.acceptanceRate.text = @"N/A";
    self.facultyRatio.text = [NSString stringWithFormat:@"%d", self.college.facultyRatio];
    self.resourcesSpent.text = [NSString stringWithFormat:@"$%.0f", self.college.resourcesSpent];
    self.endowment.text = [NSString stringWithFormat:@"$%.0f", self.college.endowment];
    self.genderRatio.text = [NSString stringWithFormat:@"%d%%/%d%%", self.college.maleRatio, self.college.femaleRatio];
    self.sat25.text = [NSString stringWithFormat:@"%d/%d/%d", self.college.ver25, self.college.mat25, self.college.wri25];
    self.sat75.text = [NSString stringWithFormat:@"%d/%d/%d", self.college.ver75, self.college.mat75, self.college.wri75];
    self.act25.text = [NSString stringWithFormat:@"%d", self.college.act25];
    self.act75.text = [NSString stringWithFormat:@"%d", self.college.act75];
    self.fourYrGradRate.text = [NSString stringWithFormat:@"%d%%", self.college.fourYrGradRate];
    self.sixYrGradRate.text = [NSString stringWithFormat:@"%d%%", self.college.sixYrGradRate];
    self.retentionRate.text = [NSString stringWithFormat:@"%d%%", self.college.retentionRate];
    self.tuitionInState.text = [NSString stringWithFormat:@"$%d", self.college.tuitionInState];
    self.tuitionOutState.text = [NSString stringWithFormat:@"$%d", self.college.tuitionOutState];
    self.roomAndBoard.text = [NSString stringWithFormat:@"$%d", self.college.roomAndBoard];
    self.totalCostInState.text = [NSString stringWithFormat:@"$%d", self.college.totalCostInState];
    self.totalCostOutState.text = [NSString stringWithFormat:@"$%d", self.college.totalCostOutState];
    self.percentFinAid.text = [NSString stringWithFormat:@"%d%%", self.college.percentFinAid];
    self.percentGrantAid.text = [NSString stringWithFormat:@"%d%%", self.college.percentGrantAid];
    self.netCost.text = [NSString stringWithFormat:@"$%d", self.college.netCost];
    self.netCost1.text = [NSString stringWithFormat:@"$%d", self.college.netCost1];
    self.netCost2.text = [NSString stringWithFormat:@"$%d", self.college.netCost2];
    self.netCost3.text = [NSString stringWithFormat:@"$%d", self.college.netCost3];
    self.netCost4.text = [NSString stringWithFormat:@"$%d", self.college.netCost4];
    self.netCost5.text = [NSString stringWithFormat:@"$%d", self.college.netCost5];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.college.savedRelation != nil) {
        isSaved = YES;
        self.navButton.title = REMOVE_TITLE;
    }
    else {
        isSaved = NO;
        self.navButton.title = SAVE_TITLE;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonPressed:(id)sender {
    if (!isSaved) {
        SavedCollege *savedCollege = [NSEntityDescription insertNewObjectForEntityForName:SAVED_COLLEGE_ENTITY
                                                                   inManagedObjectContext:self.managedObjectContext];
        savedCollege.collegeId = self.college.id;
        savedCollege.collegeRelation = self.college;
        isSaved = YES;
        self.navButton.title = REMOVE_TITLE;
    }
    else {
        [self.managedObjectContext deleteObject:self.college.savedRelation];
        isSaved = NO;
        self.navButton.title = SAVE_TITLE;
    }
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] saveContext];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WebViewController *webView = segue.destinationViewController;
    NSString *url = nil;
    if ([segue.identifier isEqualToString:@"collegeUrlClicked"])
        url = self.college.webUrl;
    else if ([segue.identifier isEqualToString:@"admUrlClicked"])
        url = self.college.admUrl;
    else if ([segue.identifier isEqualToString:@"finUrlClicked"])
        url = self.college.finUrl;
    else if ([segue.identifier isEqualToString:@"appUrlClicked"])
        url = self.college.appUrl;
    else if ([segue.identifier isEqualToString:@"calcUrlClicked"])
        url = self.college.calcUrl;
    webView.urlString = url;
}
@end
