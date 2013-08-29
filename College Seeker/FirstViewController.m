//
//  FirstViewController.m
//  College Seeker
//
//  Created by Ye Kyaw on 8/18/13.
//  Copyright (c) 2013 Ye Kyaw. All rights reserved.
//

#import "FirstViewController.h"
#import "Constants.h"
#import "AbstractTableViewController.h"
#import <CoreData/CoreData.h>
#import "College.h"
#import "CollegeUtils.h"

@interface FirstViewController () {
    @protected
    NSArray *states;
    NSArray *sortOptions;
    NSArray *sortValues;
    NSArray *isAsc;
    
    @private
    BOOL isStatePicker;
    NSString *state;
    NSString *sort;
    BOOL asc;
    NSString *oldVer;
    NSString *oldMat;
    NSString *oldWri;
    NSString *oldAct;
}

@end

@implementation FirstViewController
const int pickerTag = 100;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    states = [CollegeUtils getAllStates];
    state = ALL_STATES;
    
    
    sortOptions = [[NSArray alloc] initWithObjects:@"Name", @"4-year Grad Rate", @"6-year Grad Rate", @"Retention Rate",
                   @"Total Cost (in-state)", @"Total Cost (out-of-state)", @"Average Net Cost", @"SAT 25th percentile",
                   @"SAT 75th percentile", @"ACT 25th percentile", @"ACT 75th percentile", @"Student-Faculty Ratio",
                   @"Financial Resources/Student", @"Endowment", nil];
    sortValues = [[NSArray alloc] initWithObjects:@"name", @"fourYrGradRate", @"sixYrGradRate", @"retentionRate",
                  @"totalCostInState", @"totalCostOutState", @"netCost", @"sat25", @"sat75", @"act25", @"act75",
                  @"facultyRatio", @"resourcesSpent", @"endowment", nil];
    isAsc = [[NSArray alloc] initWithObjects:[NSNumber numberWithBool: YES], [NSNumber numberWithBool: NO], [NSNumber numberWithBool: NO],
             [NSNumber numberWithBool: NO], [NSNumber numberWithBool: YES], [NSNumber numberWithBool: YES], [NSNumber numberWithBool: YES],
             [NSNumber numberWithBool: NO], [NSNumber numberWithBool: NO], [NSNumber numberWithBool: NO], [NSNumber numberWithBool: NO],
             [NSNumber numberWithBool: YES], [NSNumber numberWithBool: NO], [NSNumber numberWithBool: NO], nil];
    sort = @"name";
    asc = YES;
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"OK" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    self.ver.inputAccessoryView = numberToolbar;
    self.mat.inputAccessoryView = numberToolbar;
    self.wri.inputAccessoryView = numberToolbar;
    self.act.inputAccessoryView = numberToolbar;

}

-(void)cancelNumberPad{
    if (self.ver.isFirstResponder) {
        [self.ver resignFirstResponder];
        self.ver.text = oldVer;
    }
    else if (self.mat.isFirstResponder) {
        [self.mat resignFirstResponder];
        self.mat.text = oldMat;
    }
    else if (self.wri.isFirstResponder) {
        [self.wri resignFirstResponder];
        self.wri.text = oldWri;
    }
    else if (self.act.isFirstResponder) {
        [self.act resignFirstResponder];
        self.act.text = oldAct;
    }
}

-(void)doneWithNumberPad{
    if (self.ver.isFirstResponder) {
        [self.ver resignFirstResponder];
        oldVer = self.ver.text;
    }
    else if (self.mat.isFirstResponder) {
        [self.mat resignFirstResponder];
        oldMat = self.mat.text;
    }
    else if (self.wri.isFirstResponder) {
        [self.wri resignFirstResponder];
        oldWri = self.wri.text;
    }
    else if (self.act.isFirstResponder) {
        [self.act resignFirstResponder];
        oldAct = self.act.text;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (isStatePicker)
        return [states count];
    else
        return [sortOptions count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (isStatePicker)
        return [states objectAtIndex:row];
    else
        return [sortOptions objectAtIndex:row];
}

- (IBAction)stateButtonPressed:(id)sender {
    UIActionSheet *selectMenu = [[UIActionSheet alloc] initWithTitle:@"States" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"OK", nil];
    [self addPickerView:selectMenu];
    isStatePicker = YES;
}

- (IBAction)sortButtonPressed:(id)sender {
    UIActionSheet *selectMenu = [[UIActionSheet alloc] initWithTitle:@"Sort By" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"OK", nil];
    [self addPickerView:selectMenu];
    isStatePicker = NO;
}

- (void)addPickerView:(UIActionSheet *)selectMenu {
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.tag = pickerTag;
    [selectMenu addSubview:pickerView];
    [selectMenu showFromTabBar:self.tabBarController.tabBar];
    
    CGRect menuRect = selectMenu.frame;
    CGFloat orgHeight = menuRect.size.height;
    menuRect.origin.y -= 180; //height of picker
    menuRect.size.height = orgHeight+180;
    selectMenu.frame = menuRect;
    
    CGRect pickerRect = pickerView.frame;
    pickerRect.origin.y = orgHeight;
    pickerView.frame = pickerRect;
    pickerView.showsSelectionIndicator = YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:SEARCH_BUTTON_PRESSED]) {
        AbstractTableViewController *destViewController = segue.destinationViewController;
        destViewController.managedObjectContext = self.managedObjectContext;
        NSArray *array = [self getAllColleges];
        destViewController.colleges = [self getMatchColleges:array];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 3) ? NO : YES;
    
    return YES;
}

- (NSArray *) getMatchColleges:(NSArray *)colleges {
    int ver = [CollegeUtils parseInt: self.ver.text];
    int mat = [CollegeUtils parseInt: self.mat.text];
    int wri = [CollegeUtils parseInt: self.wri.text];
    int act = [CollegeUtils parseInt: self.act.text];
    
    NSMutableArray *matchColleges = [[NSMutableArray alloc] init];
    for (College *college in colleges) {
        if ([CollegeUtils isGoodMatch:college isSmall:[self.smallEnrollment isOn] isMedium:[self.mediumEnrollment isOn] isLarge:[self.largeEnrollment isOn] inCity:[self.city isOn] inSuburb:[self.suburb isOn] inTown:[self.town isOn] inRural:[self.rural isOn]
                             isPublic:[self.public_t isOn] isPrivateFP:[self.private_fp isOn] isPrivateNFP:[self.private_nfp isOn]
                          isReligious:[self.religious isOn] satVer:ver satMat:mat satWri:wri act:act]) {
            [matchColleges addObject:college];
        }
    }
    
    return matchColleges;
}

- (NSArray *) getAllColleges {
    NSFetchRequest *fetch = [[NSFetchRequest alloc] initWithEntityName:COLLEGE_ENTITY];
    NSPredicate *resultPredicate = nil;
    if (![state isEqualToString:ALL_STATES])
        resultPredicate = [NSPredicate predicateWithFormat:@"state == %@", state];
    [fetch setPredicate:resultPredicate];
    NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:sort ascending:asc];
    NSArray* sortDescriptors = [[NSArray alloc] initWithObjects: sortDescriptor, nil];
    [fetch setSortDescriptors:sortDescriptors];
    return [self.managedObjectContext executeFetchRequest:fetch error:nil];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) return;
    
    UIPickerView *pickerView = (UIPickerView *)[actionSheet viewWithTag:pickerTag];
    int row = [pickerView selectedRowInComponent:0];
    if (isStatePicker) {
        state = [states objectAtIndex:row];
        self.stateButton.titleLabel.text = state;
    }
    else {
        self.sortButton.titleLabel.text = [sortOptions objectAtIndex:row];
        sort = [sortValues objectAtIndex:row];
        asc = [[isAsc objectAtIndex:row] boolValue];
    }
}
@end
