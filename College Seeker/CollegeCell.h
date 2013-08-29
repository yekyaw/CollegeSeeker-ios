//
//  CollegeCell.h
//  College Seeker
//
//  Created by Ye Kyaw on 8/19/13.
//  Copyright (c) 2013 Ye Kyaw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollegeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *collegeIcon;
@property (weak, nonatomic) IBOutlet UILabel *college;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *enrollment;
@property (weak, nonatomic) IBOutlet UILabel *acceptance;
@property (weak, nonatomic) IBOutlet UILabel *cost;

@end
