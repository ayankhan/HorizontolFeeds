//
//  FeedsModel.m
//  HorizontolScroll
//
//  Created by Ayan Khan on 05/09/16.
//  Copyright © 2016 Ayan Khan. All rights reserved.
//

#import "FeedsModel.h"

@implementation FeedsModel

#define kPropertyImagepath @"image"
#define kPropertyName @"property_name"
#define kPropertyLocation @"district_name"
#define kPropertyDate @"sale_date"
#define kPropertyDeveloper @"nick_name"

#pragma mark - Get Feeds Data in Model

+(NSMutableArray*)getFeedsData:(NSArray*)properties
{
    NSMutableArray* tempArray=[[NSMutableArray alloc]init];
    for (NSDictionary* dict in properties) {
        FeedsModel* mFeed=[[FeedsModel alloc]init];
        
        mFeed.propertyName=[dict valueForKey:kPropertyName];
        mFeed.propertyImage=[dict valueForKey:kPropertyImagepath];
        mFeed.propertyLocation=[dict valueForKey:kPropertyLocation];
        mFeed.propertyDate=[dict valueForKey:kPropertyDate];
        mFeed.propertyDeveloper=[dict valueForKey:kPropertyDeveloper];

        [tempArray addObject:mFeed];
    }
    return tempArray;
}

@end
