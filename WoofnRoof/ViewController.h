//
//  ViewController.h
//  WoofnRoof
//
//  Created by iOS Developer on 03/09/16.
//  Copyright © 2016 Prabh Kiran Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "RequestManager.h"

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *signUpButton;
@property (strong, nonatomic) IBOutlet UITextView *footerLinkView;

@end

