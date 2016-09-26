//
//  ViewController.m
//  WoofnRoof
//
//  Created by iOS Developer on 03/09/16.
//  Copyright © 2016 Prabh Kiran Kaur. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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
    
    NSMutableAttributedString *footerString  = [[NSMutableAttributedString alloc]initWithString:@"By signing up, I agree to WoofnRoof's "  attributes:@{ NSForegroundColorAttributeName: [UIColor whiteColor] }];
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

- (IBAction)loginWithFacebookAction:(id)sender {
    // change info.plist for blendedd facebook login currently using fha's fb login
    // 1- FacebookAppID
    // 2-FacebookAppSecret
    // 3-FacebookDisplayName
    // 4-UrlTypes/UrlSchemes/item0
    
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [login logOut];
    }
    
    [login logInWithReadPermissions:@[@"email",@"public_profile"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
     
     {
         if (error)
         {
             // Process error
             NSLog(@"facebook login error : %@",error);
             
         } else if (result.isCancelled)
         {
             // Handle cancellations
             
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Try Again" message:@"Login Failed from Facebook" preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
             [alertController addAction:ok];
             [self presentViewController:alertController animated:YES completion:nil];
             
         } else
         {
             
             // If you ask for multiple permissions at once, you
             // should check if specific permissions missing
             if ([result.grantedPermissions containsObject:@"email"]) {
                 // Do work
                 
                 if ([FBSDKAccessToken currentAccessToken]) {
                     
                     NSString *tokenString = [FBSDKAccessToken currentAccessToken].tokenString;
                     NSLog(@"Token : %@",tokenString);
                     
                     NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
                     [parameters setValue:@"id,name,email,birthday" forKey:@"fields"];
                     
                     [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
                      startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                          if (!error) {
                              
                              //// Do here what you want after login success from facebook
                              
                              NSString *emailFromFacebook = [NSString stringWithFormat:@"%@",result[@"email"]];
                              NSString *nameFromFacebook = [NSString stringWithFormat:@"%@",result[@"name"]];
                              NSString *birthdayFromFacebook = [NSString stringWithFormat:@"%@",result[@"birthday"]];
                              NSString *userIdFromFacebook = [NSString stringWithFormat:@"%@",result[@"id"]];
                              
                              NSLog(@"id : %@",userIdFromFacebook);
                              NSLog(@"name : %@",nameFromFacebook);
                              NSLog(@"email : %@",emailFromFacebook);
                              NSLog(@"birthday : %@",birthdayFromFacebook);
                              
                              ////hit facebook login api////
                              
                              [RequestManager getFromServer:@"login/facebook" parameters:[NSMutableDictionary dictionaryWithObjectsAndKeys:tokenString, @"facebookToken", nil] methodType:@"POST" withToken:false completionHandler:^(NSDictionary *responseDict){
                                  NSLog(@"%@",responseDict);
                                  if ([responseDict objectForKey:@"error"]) {
                                      
                                      ////error////
                                      
                                      NSLog(@"facebook api error : %@",[responseDict objectForKey:@"error"]);
                                  }
                                  else {
                                      
                                      ////success////
                                      
                                      NSLog(@"No error");
                                      [[NSUserDefaults standardUserDefaults] setObject:[responseDict objectForKey:@"token"] forKey:@"logged_token"];
                                      NSLog(@"%@",[responseDict valueForKey:@"orange-info"]);
                                      //                                      NSString *code = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"orange-info"]];
                                      //
                                      //                                      if ([code  isEqualToString: @"0"]) {
                                      //                                          NSLog(@"show orange screen");
                                      //                                          [self performSegueWithIdentifier:@"firstLogin" sender:self];
                                      //                                      }
                                      //                                      else {
                                      //                                          NSLog(@"goto main screen");
                                      //                                          [self performSegueWithIdentifier:@"notFirstLogin" sender:self];
                                      //                                      }
                                      
                                  }
                              }];
                          }
                      }];
                 }
             }
         }
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
