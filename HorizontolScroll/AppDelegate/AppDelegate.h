//
//  AppDelegate.h
//  HorizontolScroll
//
//  Created by Ayan Khan on 05/09/16.
//  Copyright © 2016 Ayan Khan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//Check Network
- (BOOL)Is_InternetAvailable;

//Loading Indicator
-(void)showLoadingAnimation;
-(void)hideLoadingAnimation;

@end

