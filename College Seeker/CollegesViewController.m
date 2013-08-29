//
//  SecondViewController.m
//  College Seeker
//
//  Created by Ye Kyaw on 8/18/13.
//  Copyright (c) 2013 Ye Kyaw. All rights reserved.
//

#import "CollegesViewController.h"
#import <CoreData/CoreData.h>
#import "Constants.h"

@interface CollegesViewController ()

@end

@implementation CollegesViewController

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
	// Do any additional setup after loading the view, typically from a nib.
    NSFetchRequest *fetch = [[NSFetchRequest alloc] initWithEntityName:COLLEGE_ENTITY];
    NSPredicate *resultPredicate;
    if (![self.state isEqualToString:ALL_STATES])
        resultPredicate = [NSPredicate predicateWithFormat:@"state == %@", self.state];
    [fetch setPredicate:resultPredicate];
    NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"name" ascending:YES];
    NSArray* sortDescriptors = [[NSArray alloc] initWithObjects: sortDescriptor, nil];
    [fetch setSortDescriptors:sortDescriptors];
    self.colleges = [self.managedObjectContext executeFetchRequest:fetch error:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
