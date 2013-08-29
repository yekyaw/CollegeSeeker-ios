//
//  CollegeUtils.h
//  College Seeker
//
//  Created by Ye Kyaw on 8/20/13.
//  Copyright (c) 2013 Ye Kyaw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "College.h"

@interface CollegeUtils : NSObject
+ (NSArray *) getAllStates;
+ (void) createAndSaveColleges:(NSString *)filePath managedObjectContext:(NSManagedObjectContext *)context;
+ (BOOL) isGoodMatch:(College *)college isSmall:(BOOL)small isMedium:(BOOL)medium isLarge:(BOOL)large
              inCity:(BOOL)city inSuburb:(BOOL)suburb inTown:(BOOL)town inRural:(BOOL)rural isPublic:(BOOL)public_t
         isPrivateFP:(BOOL)private_fp isPrivateNFP:(BOOL)private_nfp isReligious:(BOOL)religious satVer:(int)ver
              satMat:(int)mat satWri:(int)wri act:(int)act;
+ (int) parseInt:(NSString *)string;
+ (double) parseDouble:(NSString *)string;
@end
