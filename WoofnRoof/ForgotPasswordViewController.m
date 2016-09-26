//
//  ForgotPasswordViewController.m
//  WoofnRoof
//
//  Created by iOS Developer on 17/09/16.
//  Copyright © 2016 Prabh Kiran Kaur. All rights reserved.
//

#import "ForgotPasswordViewController.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //set border on login button
    self.resetButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.resetButton.layer.borderWidth = 1.0;
    self.resetButton.layer.cornerRadius = 3.0;

    
}

- (IBAction)resetPasswordAction:(id)sender {
    
    [self.forgotEmailTextField resignFirstResponder];
    
    ////hit forgot password api////
    
    [RequestManager getFromServer:@"forgot-password" parameters:[NSMutableDictionary dictionaryWithObjectsAndKeys:self.forgotEmailTextField.text, @"email", nil] methodType:@"POST" withToken:false completionHandler:^(NSDictionary *responseDict){
        NSLog(@"%@",responseDict);
        if ([responseDict objectForKey:@"error"]) {
            
            ////error////
            
            NSString *messageString;
            
            if ([[responseDict objectForKey:@"error"] isKindOfClass:[NSString class]]) {
                messageString = [responseDict objectForKey:@"error"];
            }
            else {
                messageString = [NSString stringWithFormat:@"%@",[[[responseDict objectForKey:@"error"] objectForKey:@"email"] componentsJoinedByString:@"\n"]];
            }
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:messageString preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else {
         
            ////success////
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[responseDict objectForKey:@"success"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:ok];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
}

- (IBAction)backToLoginAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Keyboard handling

////textfield delegates////

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return true;
}

////touches events////

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [self.forgotEmailTextField resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
