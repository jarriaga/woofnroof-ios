//
//  SignUpController.h
//  WoofnRoof
//
//  Created by iOS Developer on 12/09/16.
//  Copyright © 2016 Prabh Kiran Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestManager.h"
#import "CheckInfoViewController.h"

@interface SignUpController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *signupContentView;
@property (strong, nonatomic) IBOutlet UITextField *emailTextfield;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTextfield;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewTopConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewBotConst;
@end
