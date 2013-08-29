//
//  College.h
//  College Seeker
//
//  Created by Ye Kyaw on 8/21/13.
//  Copyright (c) 2013 Ye Kyaw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SavedCollege;

@interface College : NSManagedObject

@property (nonatomic) int16_t act25;
@property (nonatomic) int16_t act75;
@property (nonatomic) int32_t admits;
@property (nonatomic, retain) NSString * admUrl;
@property (nonatomic) int32_t applicants;
@property (nonatomic) int16_t applicationFee;
@property (nonatomic, retain) NSString * appUrl;
@property (nonatomic, retain) NSString * calcUrl;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * classification;
@property (nonatomic) double endowment;
@property (nonatomic) int16_t facultyRatio;
@property (nonatomic) int16_t femaleRatio;
@property (nonatomic, retain) NSString * finUrl;
@property (nonatomic) int16_t firstYearEnrollment;
@property (nonatomic) int32_t fourYrGrad;
@property (nonatomic) int16_t fourYrGradRate;
@property (nonatomic) int32_t gradCohort;
@property (nonatomic, retain) NSString * icon;
@property (nonatomic) int32_t id;
@property (nonatomic, retain) NSString * locale;
@property (nonatomic) int16_t maleRatio;
@property (nonatomic) int16_t mat25;
@property (nonatomic) int16_t mat75;
@property (nonatomic, retain) NSString * name;
@property (nonatomic) int32_t netCost;
@property (nonatomic) int32_t netCost1;
@property (nonatomic) int32_t netCost2;
@property (nonatomic) int32_t netCost3;
@property (nonatomic) int32_t netCost4;
@property (nonatomic) int32_t netCost5;
@property (nonatomic) int16_t percentFinAid;
@property (nonatomic) int16_t percentGrantAid;
@property (nonatomic) double resourcesSpent;
@property (nonatomic) int16_t retentionRate;
@property (nonatomic) int32_t roomAndBoard;
@property (nonatomic) int16_t sat25;
@property (nonatomic) int16_t sat75;
@property (nonatomic) int32_t sixYrGrad;
@property (nonatomic) int16_t sixYrGradRate;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * stateAbbr;
@property (nonatomic) int32_t totalCostInState;
@property (nonatomic) int32_t totalCostOutState;
@property (nonatomic) int32_t totalEnrolled;
@property (nonatomic) int32_t tuitionInState;
@property (nonatomic) int32_t tuitionOutState;
@property (nonatomic, retain) NSString * type;
@property (nonatomic) int16_t ver25;
@property (nonatomic) int16_t ver75;
@property (nonatomic, retain) NSString * webUrl;
@property (nonatomic) int16_t wri25;
@property (nonatomic) int16_t wri75;
@property (nonatomic, retain) SavedCollege *savedRelation;

@end
