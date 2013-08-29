//
//  SavedCollegesViewController.m
//  College Seeker
//
//  Created by Ye Kyaw on 8/21/13.
//  Copyright (c) 2013 Ye Kyaw. All rights reserved.
//

#import "SavedCollegesViewController.h"
#import <CoreData/CoreData.h>
#import "Constants.h"
#import "SavedCollege.h"

@interface SavedCollegesViewController ()

@end

@implementation SavedCollegesViewController

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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc] initWithEntityName:SAVED_COLLEGE_ENTITY];
    NSArray *temp = [self.managedObjectContext executeFetchRequest:fetch error:nil];
    NSMutableArray *savedColleges = [[NSMutableArray alloc] initWithCapacity:temp.count];
    for (SavedCollege *saved in temp) {
        [savedColleges addObject:saved.collegeRelation];
    }
    self.colleges = savedColleges;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editButtonPressed:(id)sender {
}
@end
