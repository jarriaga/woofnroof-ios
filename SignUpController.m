//
//  SignUpController.m
//  WoofnRoof
//
//  Created by iOS Developer on 12/09/16.
//  Copyright © 2016 Prabh Kiran Kaur. All rights reserved.
//

#import "SignUpController.h"

@implementation SignUpController

-(void) viewDidLoad{
    [super viewDidLoad];
    
    //set border on submit button
    _submitButton.layer.borderColor = [UIColor whiteColor].CGColor;
    _submitButton.layer.borderWidth = 1.0;
    _submitButton.layer.cornerRadius = 3.0;
    
}

- (IBAction)submitSignupDetailsAction:(id)sender {
    
    ////handle view contraints////
    
    [self.emailTextfield resignFirstResponder];
    [self.passwordTextfield resignFirstResponder];
    [self.confirmPasswordTextfield resignFirstResponder];
    
    if (isiPhone4s || isiPhone5) {
        self.contentViewTopConst.constant = 0;
        self.contentViewBotConst.constant = 0;
        [self.signupContentView setNeedsUpdateConstraints];
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            [self.signupContentView layoutIfNeeded];
            
        } completion:nil];
    }
    
    ////hit signup api////
    
    [RequestManager getFromServer:@"signup/email" parameters:[NSMutableDictionary dictionaryWithObjectsAndKeys:self.emailTextfield.text, @"email", self.passwordTextfield.text, @"password", self.confirmPasswordTextfield.text, @"password_confirmation", @"", @"mobile", nil] methodType:@"POST" completionHandler:^(NSDictionary *responseDict){
        NSLog(@"%@",responseDict);
        if ([responseDict objectForKey:@"error"]) {
            
            ////signup error////
            
            NSArray *emailErrorArray = [NSArray array];
            NSArray *passwordErrorArray = [NSArray array];
            
            if ([[responseDict objectForKey:@"error"] objectForKey:@"email"]) {
                emailErrorArray = [[responseDict objectForKey:@"error"] objectForKey:@"email"];
            }
            if ([[responseDict objectForKey:@"error"] objectForKey:@"password"]) {
                passwordErrorArray = [[responseDict objectForKey:@"error"] objectForKey:@"password"];
            }
            
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"%@\n%@",[emailErrorArray componentsJoinedByString:@"\n"],[passwordErrorArray componentsJoinedByString:@"\n"]] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            [self presentViewController:alertController animated:YES completion:nil];
            
        } else {
            
            ////signup success////
            
            NSLog(@"No error");
            
            ////hit login api////
            
            [RequestManager getFromServer:@"login/email" parameters:[NSMutableDictionary dictionaryWithObjectsAndKeys:[responseDict objectForKey:@"email"], @"email", self.passwordTextfield.text, @"password", nil] methodType:@"POST" completionHandler:^(NSDictionary *responseDict){
                NSLog(@"%@",responseDict);
                if ([responseDict objectForKey:@"error"]) {
                    
                    ////login error////
                    
                    if ([[responseDict objectForKey:@"error"] isKindOfClass:[NSString class]]) {
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[responseDict objectForKey:@"error"] preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                        [alertController addAction:ok];
                        [self presentViewController:alertController animated:YES completion:nil];
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
                        
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"%@\n%@",[emailErrorArray componentsJoinedByString:@"\n"],[passwordErrorArray componentsJoinedByString:@"\n"]] preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                        [alertController addAction:ok];
                        [self presentViewController:alertController animated:YES completion:nil];
                    }
                    
                } else {
                    
                    ////login success////
                    
                    NSLog(@"No error");
                    [[NSUserDefaults standardUserDefaults] setObject:[responseDict objectForKey:@"token"] forKey:@"logged_token"];
                    NSLog(@"%@",[responseDict valueForKey:@"orange-info"]);
                    NSString *code = [NSString stringWithFormat:@"%@",[responseDict valueForKey:@"orange-info"]];
                    
                    if ([code isEqualToString: @"0"]) {
                        NSLog(@"show orange screen");
                        [self performSegueWithIdentifier:@"signupSuccess" sender:self];
                    }
                    else {
                        NSLog(@"goto main screen"); //no need to perform any navigation here since this will always be the first login after signup
                    }
                    
                }
            }];
        }
    }];
}


- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Keyboard handling

////textfield delegates////

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (isiPhone4s || isiPhone5) {
        if (textField.tag == 2 || textField.tag == 3) {
            
            self.contentViewTopConst.constant = -200;
            self.contentViewBotConst.constant = 200;
            [self.signupContentView setNeedsUpdateConstraints];
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                [self.signupContentView layoutIfNeeded];
                
            } completion:nil];
        }
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (isiPhone4s || isiPhone5) {
        
        if (textField.tag == 1) {
            
            self.contentViewTopConst.constant = -200;
            self.contentViewBotConst.constant = 200;
            [self.signupContentView setNeedsUpdateConstraints];
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                [self.signupContentView layoutIfNeeded];
                
            } completion:nil];
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 1) {
        [self.passwordTextfield becomeFirstResponder];
    }
    else if (textField.tag == 2){
        [self.confirmPasswordTextfield becomeFirstResponder];
    }
    else{
        [textField resignFirstResponder];
        if (isiPhone4s || isiPhone5) {
            self.contentViewTopConst.constant = 0;
            self.contentViewBotConst.constant = 0;
            [self.signupContentView setNeedsUpdateConstraints];
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                [self.signupContentView layoutIfNeeded];
                
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
        [self.emailTextfield resignFirstResponder];
        [self.passwordTextfield resignFirstResponder];
        [self.confirmPasswordTextfield resignFirstResponder];
        
        self.contentViewTopConst.constant = 0;
        self.contentViewBotConst.constant = 0;
        [self.signupContentView setNeedsUpdateConstraints];
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            [self.signupContentView layoutIfNeeded];
            
        } completion:nil];
        
    }
}


@end
