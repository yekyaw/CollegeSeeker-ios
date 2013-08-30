//
//  SecondViewController.m
//  College Seeker
//
//  Created by Ye Kyaw on 8/18/13.
//  Copyright (c) 2013 Ye Kyaw. All rights reserved.
//

#import "AbstractTableViewController.h"
#import "CollegeCell.h"
#import <CoreData/CoreData.h>
#import "College.h"
#import "Constants.h"
#import "CollegeDetailViewController.h"

@interface AbstractTableViewController () {
    @private
    BOOL isSearchResults;
}
@end

@implementation AbstractTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.searchBar setShowsScopeBar:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView != self.tableView)
        return [self.searchResults count];
    else
        return [self.colleges count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CollegeCell *cell = [self.tableView dequeueReusableCellWithIdentifier: COLLEGE_CELL_IDENTIFIER];
    if (cell == nil) {
        cell = [[CollegeCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: COLLEGE_CELL_IDENTIFIER];
    }
    
    College *college;
    if (tableView != self.tableView)
        college = [self.searchResults objectAtIndex:indexPath.row];
    else
        college = [self.colleges objectAtIndex:indexPath.row];
    cell.college.text = college.name;
    cell.type.text = college.type;
    cell.enrollment.text = [NSString stringWithFormat:@"%d", college.totalEnrolled];
    if (college.applicants != 0)
        cell.acceptance.text = [NSString stringWithFormat:@"%.1f%%", (double)college.admits / college.applicants * 100];
    else
        cell.acceptance.text = @"N/A";
    cell.cost.text = [NSString stringWithFormat:@"$%d/$%d", college.tuitionInState, college.tuitionOutState];
    if ([college.icon length] > 0) {
        NSString* filePath = [[NSBundle mainBundle] pathForResource:college.icon
                                                             ofType:@"png" inDirectory:@"res"];
        cell.collegeIcon.image = [UIImage imageWithContentsOfFile: filePath];
    }
    else cell.collegeIcon.image = nil;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:SHOW_COLLEGE_DETAIL]) {
        CollegeDetailViewController *destViewController = segue.destinationViewController;
        destViewController.managedObjectContext = self.managedObjectContext;
        if (isSearchResults) {
            NSIndexPath *indexPath = [self.searchController.searchResultsTableView indexPathForSelectedRow];
            destViewController.college = [self.searchResults objectAtIndex:indexPath.row];
        }
        else {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            destViewController.college = [self.colleges objectAtIndex:indexPath.row];
        }
    }
}

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
    isSearchResults = YES;
    [self.searchBar setShowsScopeBar:YES];
    [self.searchBar sizeToFit];
}

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller {
    isSearchResults = NO;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF.name contains[cd] %@",
                                    searchText];
    id array = [self.colleges filteredArrayUsingPredicate: resultPredicate];
    if ((scope != nil) && (![scope isEqualToString:@"All"])) {
        resultPredicate = [NSPredicate
                           predicateWithFormat:@"SELF.type contains[cd] %@",
                           scope];
        array = [array filteredArrayUsingPredicate:resultPredicate];
    }
    self.searchResults = array;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchBar
                                                     selectedScopeButtonIndex]]];
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
//    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchBar.text scope:
     [[self.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    [self hideOrShowTabSearch: toInterfaceOrientation];
//}
//
//- (void)hideOrShowTabSearch:(UIInterfaceOrientation)orientation {
//    if (UIDeviceOrientationIsLandscape(orientation))
//    {
//        self.searchDisplayController.searchBar.hidden = YES;
//    }
//    else {
//        self.searchDisplayController.searchBar.hidden = NO;
//    }
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 117.0;
}

@end