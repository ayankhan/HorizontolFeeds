//
//  FeedsCollectionViewController.m
//  HorizontolScroll
//
//  Created by Ayan Khan on 05/09/16.
//  Copyright © 2016 Ayan Khan. All rights reserved.
//

#import "FeedsCollectionViewController.h"
#import "FeedsCollectionViewCell.h"
#import "SharedParsing.h"
#import "FeedsModel.h"
#import "AppDelegate.h"
#import "UIViewController+Alert.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

#define kSharedParsing [SharedParsing sharedSharedParsing]
# define kAppdelegate  (AppDelegate*) [[UIApplication sharedApplication] delegate]
#define kWINDOW_SIZE [[UIScreen mainScreen]bounds].size


@interface FeedsCollectionViewController ()

@property(strong,nonatomic) NSArray *arrayFeeds;

@end

@implementation FeedsCollectionViewController

static NSString * const reuseIdentifier = @"FeedsCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    
    //Call Webservice to Get Feeds
    [self wsCallForFeeds];

    
}

#pragma mark - WEBSERVICE CALL -

-(void)wsCallForFeeds{
    
if([kAppdelegate Is_InternetAvailable]){
    
    [kAppdelegate showLoadingAnimation];
    
    [kSharedParsing assignSender:self];
    
    [kSharedParsing WSCallForFeeds:[self parameters] successBlock:^(BOOL succeeded, NSArray *resultArray) {
        
        if ([[resultArray valueForKey:@"success"] boolValue]) {
            
            /*....Add Objects Through Model....*/
            self.arrayFeeds=[FeedsModel getFeedsData:[resultArray valueForKey:@"feeds"]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.collectionView reloadData];
                [kAppdelegate hideLoadingAnimation];
                
                
            });
            
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.collectionView reloadData];
                [kAppdelegate hideLoadingAnimation];
            });
            
        }
    }
                  failureBlock:^(BOOL succeeded, NSArray *failureArray) {
                      dispatch_async(dispatch_get_main_queue(), ^{
                          [kAppdelegate hideLoadingAnimation];
                          [self showAlertViewWithTitle:@"Error" message:@"Something went wrong."];
                      });
                      
                  }];
}
else{
    
    [self showAlertViewWithTitle:@"No Internet!" message:@"Please check your Internet Connection."];
}
    
}

#pragma mark - Parameters
-(NSDictionary *)parameters{

    return @{@"lang":@"0"};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.arrayFeeds count];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FeedsCollectionViewCell *cell = (FeedsCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    /*....Get Model from Array....*/
    FeedsModel *property = (FeedsModel*)[self.arrayFeeds objectAtIndex:indexPath.row];
    
    // Configure the cell

    [cell.mImageViewProperty setImageWithURL:[NSURL URLWithString:property.propertyImage] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [cell.mPropertyName setText:property.propertyName];
    [cell.mPropertyLocation setText:property.propertyLocation];
    [cell.mPropertySaleDate setText:property.propertyDate];
    [cell.mPropertyDeveloperName setText:[NSString stringWithFormat:@"Developer: %@",property.propertyDeveloper]];

    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kWINDOW_SIZE.width, kWINDOW_SIZE.height);
}

@end
