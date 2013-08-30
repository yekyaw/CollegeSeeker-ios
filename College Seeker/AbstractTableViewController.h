//
//  AbstractTableViewController.h
//  College Seeker
//
//  Created by Ye Kyaw on 8/21/13.
//  Copyright (c) 2013 Ye Kyaw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbstractTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate,
    UISearchDisplayDelegate>

@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchController;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *colleges;
@property (nonatomic, strong) NSArray *searchResults;
@property (atomic, weak) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
