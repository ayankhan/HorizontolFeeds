//
//  FeedsModel.h
//  HorizontolScroll
//
//  Created by Ayan Khan on 05/09/16.
//  Copyright © 2016 Ayan Khan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedsModel : NSObject

/*....Feeds Properties....*/

@property(nonatomic,retain)NSString* propertyImage;

@property(nonatomic,retain)NSString* propertyName;
@property(nonatomic,retain)NSString* propertyLocation;
@property(nonatomic,retain)NSString* propertyDate;

@property(nonatomic,retain)NSString* propertyDeveloper;

/*....Modelize....*/
+(NSMutableArray*)getFeedsData:(NSArray*)properties;
@end
