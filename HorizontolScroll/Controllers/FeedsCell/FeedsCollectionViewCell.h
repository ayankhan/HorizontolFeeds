//
//  FeedsCollectionViewCell.h
//  HorizontolScroll
//
//  Created by Ayan Khan on 05/09/16.
//  Copyright © 2016 Ayan Khan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedsCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mImageViewProperty;
@property (weak, nonatomic) IBOutlet UILabel *mPropertyName;
@property (weak, nonatomic) IBOutlet UILabel *mPropertyLocation;
@property (weak, nonatomic) IBOutlet UILabel *mPropertySaleDate;
@property (weak, nonatomic) IBOutlet UILabel *mPropertyDeveloperName;

@end
