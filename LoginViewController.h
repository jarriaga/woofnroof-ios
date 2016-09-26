//
//  LoginViewController.h
//  WoofnRoof
//
//  Created by iOS Developer on 12/09/16.
//  Copyright © 2016 Prabh Kiran Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestManager.h"
#import "CheckInfoViewController.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *loginContentView;
@property (strong, nonatomic) IBOutlet UITextField *loginEmailTextfield;
@property (strong, nonatomic) IBOutlet UITextField *loginPasswordTextfield;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginContentViewTopConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginContentViewBotConst;


@end
