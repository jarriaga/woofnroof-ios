//
//  ViewController.m
//  WoofnRoof
//
//  Created by iOS Developer on 03/09/16.
//  Copyright © 2016 Prabh Kiran Kaur. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableAttributedString *footerString ;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _footerLinkView.tintColor = [UIColor whiteColor];
    
    ////set border on login button////
    
    _signUpButton.layer.borderColor = [UIColor whiteColor].CGColor;
    _signUpButton.layer.borderWidth = 1.0;
    _signUpButton.layer.cornerRadius = 3.0;
    
    ////handling footerLinkView text////
    
    footerString = [[NSMutableAttributedString alloc]initWithString:@"By signing up, I agree to WoofnRoof's "  attributes:@{ NSForegroundColorAttributeName: [UIColor whiteColor] }];
    NSAttributedString *commaSpace = [[NSAttributedString alloc]initWithString:@", " attributes:@{ NSForegroundColorAttributeName: [UIColor whiteColor] }];
    
    //add terms of service link
    NSMutableAttributedString *termsOfService = [[NSMutableAttributedString alloc] initWithString:@"Terms of Service" attributes:@{ NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle) ,NSLinkAttributeName: [NSURL URLWithString:@"http://www.google.com"] }];
    [footerString appendAttributedString:termsOfService];
    [footerString appendAttributedString:commaSpace];
    
    //add payments TOI link
    NSMutableAttributedString *PaymentTermsOfService = [[NSMutableAttributedString alloc] initWithString:@"Payments Terms of Service" attributes:@{ NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle) ,NSLinkAttributeName: [NSURL URLWithString:@"http://www.facebook.com"], NSForegroundColorAttributeName: [UIColor whiteColor] }];
    [footerString appendAttributedString:PaymentTermsOfService];
    [footerString appendAttributedString:commaSpace];
    
    //add privacy link
    NSMutableAttributedString *privacyPolicy = [[NSMutableAttributedString alloc] initWithString:@"Privacy Policy" attributes:@{ NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle) ,NSLinkAttributeName: [NSURL URLWithString:@"http://www.facebook.com"], NSForegroundColorAttributeName: [UIColor whiteColor] }];
    [footerString appendAttributedString:privacyPolicy];
    [footerString appendAttributedString:commaSpace];
    
    //add guest refund link
    NSMutableAttributedString *guestRefundPolicy = [[NSMutableAttributedString alloc] initWithString:@"Guest Refund Policy" attributes:@{ NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle) ,NSLinkAttributeName: [NSURL URLWithString:@"http://www.facebook.com"], NSForegroundColorAttributeName: [UIColor whiteColor] }];
    [footerString appendAttributedString:guestRefundPolicy];
    
    //add 'and'
    NSAttributedString *andString = [[NSAttributedString alloc] initWithString:@" and " attributes:@{ NSForegroundColorAttributeName: [UIColor whiteColor] }];
    [footerString appendAttributedString:andString];
    
    //add guarnatee link
    NSMutableAttributedString *hostGuaranteePolicy = [[NSMutableAttributedString alloc] initWithString:@"Host Guarantee Terms." attributes:@{ NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle) ,NSLinkAttributeName: [NSURL URLWithString:@"http://www.facebook.com"], NSForegroundColorAttributeName: [UIColor whiteColor] }];
    [footerString appendAttributedString:hostGuaranteePolicy];
    
    //set text on view
    self.footerLinkView.attributedText = footerString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
