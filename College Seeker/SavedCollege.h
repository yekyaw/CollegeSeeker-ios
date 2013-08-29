//
//  SavedCollege.h
//  College Seeker
//
//  Created by Ye Kyaw on 8/21/13.
//  Copyright (c) 2013 Ye Kyaw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class College;

@interface SavedCollege : NSManagedObject

@property (nonatomic) int32_t collegeId;
@property (nonatomic, retain) College *collegeRelation;

@end
