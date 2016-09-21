//
//  CheckInfoViewController.h
//  WoofnRoof
//
//  Created by iOS Developer on 12/09/16.
//  Copyright © 2016 Prabh Kiran Kaur. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CheckInfoViewController : UIViewController<UITextFieldDelegate >

@property (strong, nonatomic) IBOutlet UITextField *nameTextfield;
@property (strong, nonatomic) IBOutlet UITextField *emailTextfield;
@property (strong, nonatomic) IBOutlet UITextField *dateOfBIrthTextfield;
@property (strong, nonatomic) IBOutlet UITextField *contactNumberTextfield;
@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIView *calendarView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *_calendarHeightConstraint;


@end
