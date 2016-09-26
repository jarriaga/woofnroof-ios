//
//  LoginViewController.m
//  WoofnRoof
//
//  Created by iOS Developer on 12/09/16.
//  Copyright © 2016 Prabh Kiran Kaur. All rights reserved.
//


#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set border on login button
    _loginButton.layer.borderColor = [UIColor whiteColor].CGColor;
    _loginButton.layer.borderWidth = 1.0;
    _loginButton.layer.cornerRadius = 3.0;
    
}
- (IBAction)submitLoginDetailsAction:(id)sender {
    
    ////handle view contraints////
    
    [self.loginEmailTextfield resignFirstResponder];
    [self.loginPasswordTextfield resignFirstResponder];
    
    if (isiPhone4s || isiPhone5) {
        self.loginContentViewTopConst.constant = 0;
        self.loginContentViewBotConst.constant = 0;
        [self.loginContentView setNeedsUpdateConstraints];
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            [self.loginContentView layoutIfNeeded];
            
        } completion:nil];
    }
    
    ////hit login api////
    
    [RequestManager getFromServer:@"login/email" parameters:[NSMutableDictionary dictionaryWithObjectsAndKeys:self.loginEmailTextfield.text, @"email", self.loginPasswordTextfield.text, @"password", nil] methodType:@"POST" withToken:false completionHandler:^(NSDictionary *responseDict){
        NSLog(@"%@",responseDict);
        if ([responseDict objectForKey:@"error"]) {
            
            ////error////
            
            NSString *messageString;
            
            if ([[responseDict objectForKey:@"error"] isKindOfClass:[NSString class]]) {
                
                messageString = [responseDict objectForKey:@"error"];
                
            }
            else {
                NSArray *emailErrorArray = [NSArray array];
                NSArray *passwordErrorArray = [NSArray array];
                
                if ([[responseDict objectForKey:@"error"] objectForKey:@"email"]) {
                    emailErrorArray = [[responseDict objectForKey:@"error"] objectForKey:@"email"];
                }
                if ([[responseDict objectForKey:@"error"] objectForKey:@"password"]) {
                    passwordErrorArray = [[responseDict objectForKey:@"error"] objectForKey:@"password"];
                }
                
                messageString = [NSString stringWithFormat:@"%@\n%@",[emailErrorArray componentsJoinedByString:@"\n"],[passwordErrorArray componentsJoinedByString:@"\n"]];
                
            }
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:messageString preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            [self presentViewController:alertController animated:YES completion:nil];
            
        } else {
            
            ////success////
            
            NSLog(@"No error");
            [[NSUserDefaults standardUserDefaults] setObject:[responseDict objectForKey:@"token"] forKey:@"logged_token"];
            NSLog(@"%@",[responseDict valueForKey:@"orange-info"]);
            NSString *code = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"orange-info"]];
            
            if ([code  isEqualToString: @"0"]) {
                NSLog(@"show orange screen");
                [self performSegueWithIdentifier:@"firstLogin" sender:self];
            }
            else {
                NSLog(@"goto main screen");
                [self performSegueWithIdentifier:@"notFirstLogin" sender:self];
            }
            
        }
    }];
}

- (IBAction)backToMainAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Keyboard handling

////textfield delegates////

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (isiPhone4s || isiPhone5) {
        if (textField.tag == 5) {
            
            self.loginContentViewTopConst.constant = -130;
            self.loginContentViewBotConst.constant = 130;
            [self.loginContentView setNeedsUpdateConstraints];
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                [self.loginContentView layoutIfNeeded];
                
            } completion:nil];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (isiPhone4s || isiPhone5) {
        if (textField.tag == 4) {
            
            self.loginContentViewTopConst.constant = -130;
            self.loginContentViewBotConst.constant = 130;
            [self.loginContentView setNeedsUpdateConstraints];
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                [self.loginContentView layoutIfNeeded];
                
            } completion:nil];
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 4) {
        [self.loginPasswordTextfield becomeFirstResponder];
    }
    else{
        [textField resignFirstResponder];
        if (isiPhone4s || isiPhone5) {
            self.loginContentViewTopConst.constant = 0;
            self.loginContentViewBotConst.constant = 0;
            [self.loginContentView setNeedsUpdateConstraints];
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                [self.loginContentView layoutIfNeeded];
                
            } completion:nil];
        }
    }
    
    return true;
}

////touches events////

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [self.loginEmailTextfield resignFirstResponder];
        [self.loginPasswordTextfield resignFirstResponder];
        
        self.loginContentViewTopConst.constant = 0;
        self.loginContentViewBotConst.constant = 0;
        [self.loginContentView setNeedsUpdateConstraints];
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            [self.loginContentView layoutIfNeeded];
            
        } completion:nil];
        
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"firstLogin"]) {
        CheckInfoViewController *embed = segue.destinationViewController;
        embed.emailProperty = self.loginEmailTextfield.text;
        
    }
}
@end
