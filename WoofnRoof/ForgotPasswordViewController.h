//
//  ForgotPasswordViewController.h
//  WoofnRoof
//
//  Created by iOS Developer on 17/09/16.
//  Copyright © 2016 Prabh Kiran Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestManager.h"

@interface ForgotPasswordViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *forgotEmailTextField;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

@end
