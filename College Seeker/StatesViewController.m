//
//  StatesViewController.m
//  College Seeker
//
//  Created by Ye Kyaw on 8/22/13.
//  Copyright (c) 2013 Ye Kyaw. All rights reserved.
//

#import "StatesViewController.h"
#import "CollegeUtils.h"
#import "Constants.h"
#import "CollegesViewController.h"

@interface StatesViewController () {
    NSArray *states;
}

@end

@implementation StatesViewController

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
    states = [CollegeUtils getAllStates];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [states count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: STATE_CELL_IDENTIFIER];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: STATE_CELL_IDENTIFIER];
    }
    cell.textLabel.text = [states objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:STATE_SELECTED]) {
        CollegesViewController *destViewController = segue.destinationViewController;
        destViewController.managedObjectContext = self.managedObjectContext;
        destViewController.managedObjectContext = self.managedObjectContext;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        destViewController.state = [states objectAtIndex:indexPath.row];
    }
}
@end
