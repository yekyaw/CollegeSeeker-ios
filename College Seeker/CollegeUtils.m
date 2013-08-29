//
//  CollegeUtils.m
//  College Seeker
//
//  Created by Ye Kyaw on 8/20/13.
//  Copyright (c) 2013 Ye Kyaw. All rights reserved.
//

#import "CollegeUtils.h"
#import "CSVParser.h"
#import "Constants.h"
#import "Appdelegate.h"

@interface CollegeUtils () {
    
}

@end

@implementation CollegeUtils

+ (NSArray *) getAllStates {
    static dispatch_once_t once;
    static NSArray *states;
    dispatch_once(&once, ^{
        states = [[NSArray alloc] initWithObjects:ALL_STATES, @"Alaska", @"Alabama", @"Arizona", @"Arkansas", @"California",
                   @"Colorado", @"Connecticut", @"Delaware", @"District of Columbia", @"Florida", @"Georgia", @"Hawaii",
                   @"Idaho", @"Illinois", @"Indiana", @"Iowa", @"Kansas", @"Kentucky", @"Louisiana", @"Maine", @"Maryland",
                   @"Massachusetts", @"Michigan", @"Minnesota", @"Mississippi", @"Missouri", @"Montana", @"Nebraska",
                   @"Nevada", @"New Hampshire", @"New Jersey", @"New Mexico", @"New York", @"North Carolina",
                   @"North Dakota", @"Ohio", @"Oklahoma", @"Oregon", @"Pennsylvania", @"Rhode Island", @"South Carolina",
                   @"South Dakota", @"Tennessee", @"Texas", @"Utah", @"Vermont", @"Virginia", @"Washington",
                   @"West Virginia", @"Wisconsin", @"Wyoming", nil];
    });
    return states;
}

+ (void) createAndSaveColleges:(NSString *)filePath managedObjectContext:(NSManagedObjectContext *)context {
    NSArray *csv = [CSVParser parseCSVIntoArrayOfArraysFromFile:filePath withSeparatedCharacterString:@"," quoteCharacterString:@"\""];
    for (NSArray *line in csv) {
        if ([line count] <= 1) break;
        College *college = [NSEntityDescription insertNewObjectForEntityForName:COLLEGE_ENTITY
                                                         inManagedObjectContext:context];
        college.id = [CollegeUtils parseInt: line[0]];
        college.name = line[1];
        college.icon = line[2];
        college.firstYearEnrollment = [CollegeUtils parseInt:line[3]];
        college.applicants = [CollegeUtils parseInt:line[4]];
        college.admits = [CollegeUtils parseInt:line[5]];
        college.applicationFee = [CollegeUtils parseInt:line[6]];
        college.roomAndBoard = [CollegeUtils parseInt:line[7]];
        college.ver25 = [CollegeUtils parseInt:line[8]];
        college.ver75 = [CollegeUtils parseInt:line[9]];
        college.mat25 = [CollegeUtils parseInt:line[10]];
        college.mat75 = [CollegeUtils parseInt:line[11]];
        college.wri25 = [CollegeUtils parseInt:line[12]];
        college.wri75 = [CollegeUtils parseInt:line[13]];
        college.act25 = [CollegeUtils parseInt:line[14]];
        college.act75 = [CollegeUtils parseInt:line[15]];
        college.type = line[16];
        college.classification = line[17];
        college.state = line[18];
        college.locale = line[19];
        college.gradCohort = [CollegeUtils parseInt:line[20]];
        college.fourYrGrad = [CollegeUtils parseInt:line[21]];
        college.sixYrGrad = [CollegeUtils parseInt:line[22]];
        college.facultyRatio = [CollegeUtils parseInt:line[23]];
        college.retentionRate = [CollegeUtils parseInt:line[24]];
        college.totalEnrolled = [CollegeUtils parseInt:line[25]];
        college.percentFinAid = [CollegeUtils parseInt:line[26]];
        college.percentGrantAid = [CollegeUtils parseInt:line[27]];
        college.netCost = [CollegeUtils parseInt:line[28]];
        college.netCost1 = [CollegeUtils parseInt:line[29]];
        college.netCost2 = [CollegeUtils parseInt:line[30]];
        college.netCost3 = [CollegeUtils parseInt:line[31]];
        college.netCost4 = [CollegeUtils parseInt:line[32]];
        college.netCost5 = [CollegeUtils parseInt:line[33]];
        college.tuitionInState = [CollegeUtils parseInt:line[34]];
        college.tuitionOutState = [CollegeUtils parseInt:line[35]];
        college.totalCostInState = [CollegeUtils parseInt:line[36]];
        college.totalCostOutState = [CollegeUtils parseInt:line[37]];
        college.maleRatio = [CollegeUtils parseInt:line[38]];
        college.femaleRatio = [CollegeUtils parseInt:line[39]];
        college.city = line[40];
        college.webUrl = line[41];
        college.admUrl = line[42];
        college.finUrl = line[43];
        college.appUrl = line[44];
        college.resourcesSpent = [CollegeUtils parseDouble:line[45]];
        college.endowment = [CollegeUtils parseDouble:line[46]];
        college.stateAbbr = line[47];
        college.calcUrl = line[48];
        college.fourYrGradRate = [CollegeUtils parseInt:line[49]];
        college.sixYrGradRate = [CollegeUtils parseInt:line[50]];
        college.sat25 = [CollegeUtils parseInt:line[51]];
        college.sat75 = [CollegeUtils parseInt:line[52]];
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] saveContext];
    }
}

+ (int) parseInt:(NSString *)string {
    @try {
        return [string intValue];
    } @catch (NSException *e) {
        return 0;
    }
}

+ (double) parseDouble:(NSString *)string {
    @try {
     return [string doubleValue];
    } @catch (NSException *e) {
        return 0.0;
    }
}

+ (BOOL) isGoodMatch:(College *)college isSmall:(BOOL)small isMedium:(BOOL)medium isLarge:(BOOL)large
              inCity:(BOOL)city inSuburb:(BOOL)suburb inTown:(BOOL)town inRural:(BOOL)rural isPublic:(BOOL)public_t
         isPrivateFP:(BOOL)private_fp isPrivateNFP:(BOOL)private_nfp isReligious:(BOOL)religious satVer:(int)ver
              satMat:(int)mat satWri:(int)wri act:(int)act {
    int enrolled = [college totalEnrolled];
    if (!small && (enrolled < 5000)) return NO;
    if (!medium && (enrolled >= 5000) && (enrolled <= 10000)) return NO;
    if (!large && (enrolled > 10000)) return NO;
    
    NSString *locale = college.locale;
    if ([locale isEqualToString:@"City"]) {
        if (!city) return NO;
    }
    else if ([locale isEqualToString:@"Suburb"]) {
        if (!suburb) return NO;
    }
    else if ([locale isEqualToString:@"Town"]) {
        if (!town) return NO;
    }
    else if ([locale isEqualToString:@"Rural"]) {
        if (!rural) return NO;
    }
    
    NSString *type = college.type;
    if ([type isEqualToString:@"Public"]) {
        if (!public_t) return NO;
    }
    else if ([type isEqualToString:@"Private for-profit"]) {
        if (!private_fp) return NO;
    }
    else if ([type isEqualToString:@"Private not-for-profit"]) {
        if (!private_nfp) return NO;
    }
    else if ([type isEqualToString:@"Private religious"]) {
        if (!religious) return NO;
    }
    
    if ((ver == 0) && (mat == 0) && (wri == 0) && (act == 0)) return YES;
    if ((ver == 0) || (mat == 0) || (wri == 0)) {
        if (act != 0) return [self isACTMatch:college act:act];
        return NO;
    }
    if (act == 0) return [self isSATMatch:college ver:ver mat:mat wri:wri];
    return [self isSATACTMatch:college ver:ver mat:mat wri:wri act:act];
}

+ (BOOL) isSATMatch:(College *)college ver:(int)ver mat:(int)mat wri:(int)wri {
    int avg, cAvg25, cAvg75;
    if (college.wri75 == 0) {
        cAvg25 = (college.ver25 + college.mat25) / 2;
        cAvg75 = (college.ver75 + college.mat75) / 2;
        avg = (ver + mat) / 2;
    }
    else {
        cAvg25 = (college.ver25 + college.mat25 + college.wri25) / 3;
        cAvg75 = (college.ver75 + college.mat75 + college.wri75) / 3;
        avg = (ver + mat + wri) / 3;
    }
    if ((avg >= cAvg25 - 30) && (avg <= cAvg75 + 30)) return YES;
    return NO;
}

+ (BOOL) isACTMatch:(College *)college act:(int)act {
    if ((act >= college.act25 -1) && (act <= college.act75 + 1)) return YES;
    return NO;
}

+ (BOOL) isSATACTMatch:(College *)college ver:(int)ver mat:(int)mat wri:(int)wri act:(int)act {
    int avg, cAvg25, cAvg75;
    if (college.wri75 == 0) {
        cAvg25 = (college.ver25 + college.mat25) / 2;
        cAvg75 = (college.ver75 + college.mat75) / 2;
        avg = (ver + mat) / 2;
    }
    else {
        cAvg25 = (college.ver25 + college.mat25 + college.wri25) / 3;
        cAvg75 = (college.ver75 + college.mat75 + college.wri75) / 3;
        avg = (ver + mat + wri) / 3;
    }
    if ((avg > cAvg75 + 30) || (act > college.act75 + 1)) return NO;
    if ((avg < cAvg25 - 30) && (act < college.act25 - 1)) return NO;
    return YES;
}

@end
