//
//  CheckInfoViewController.h
//  WoofnRoof
//
//  Created by iOS Developer on 12/09/16.
//  Copyright © 2016 Prabh Kiran Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "RequestManager.h"

@interface CheckInfoViewController : UIViewController<UITextFieldDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) IBOutlet UITextField *profileNameTextfield;
@property (strong, nonatomic) IBOutlet UITextField *profileEmailTextfield;
@property (strong, nonatomic) IBOutlet UITextField *profileDobTextfield;
@property (strong, nonatomic) IBOutlet UITextField *profileContactTextfield;
@property (weak, nonatomic) IBOutlet UIButton *profileSubmitButton;
@property (weak, nonatomic) IBOutlet UIView *profileContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *profileContentViewTopConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *profileContentViewBotConst;
@property (weak, nonatomic) NSString *emailProperty;

@end
