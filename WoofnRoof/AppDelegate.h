//
//  AppDelegate.h
//  WoofnRoof
//
//  Created by iOS Developer on 03/09/16.
//  Copyright © 2016 Prabh Kiran Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#define BaseUrl @"http://woofnroof.com/api/"
#define isiPhone5  ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE
#define isiPhone4s  ([[UIScreen mainScreen] bounds].size.height == 480)?TRUE:FALSE

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

