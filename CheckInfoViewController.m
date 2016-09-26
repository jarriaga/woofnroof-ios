//
//  CheckInfoViewController.m
//  WoofnRoof
//
//  Created by iOS Developer on 12/09/16.
//  Copyright © 2016 Prabh Kiran Kaur. All rights reserved.
//

#import "CheckInfoViewController.h"

@interface CheckInfoViewController ()
{
    NSString *latitudeLoc;
    NSString *longitudeLoc;
}
@end

@implementation CheckInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set border on login button
    self.profileSubmitButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.profileSubmitButton.layer.borderWidth = 1.0;
    self.profileSubmitButton.layer.cornerRadius = 3.0;
    
    self.profileEmailTextfield.text = self.emailProperty;
    
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager requestWhenInUseAuthorization];
        [locationManager startUpdatingLocation];
    }

}

- (IBAction)submitProfileAction:(id)sender {
    
    ////handle view contraints////
    
    [self.profileNameTextfield resignFirstResponder];
    [self.profileEmailTextfield resignFirstResponder];
    [self.profileDobTextfield resignFirstResponder];
    [self.profileContactTextfield resignFirstResponder];
    if (isiPhone4s || isiPhone5) {
        self.profileContentViewTopConst.constant = 0;
        self.profileContentViewBotConst.constant = 0;
        [self.profileContentView setNeedsUpdateConstraints];
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            [self.profileContentView layoutIfNeeded];
            
        } completion:nil];
    }

    ////hit update profile api////
    
    [RequestManager getFromServer:@"profile" parameters:[NSMutableDictionary dictionaryWithObjectsAndKeys:self.profileNameTextfield.text, @"name", self.profileDobTextfield.text, @"birthday", self.profileContactTextfield.text, @"mobile", latitudeLoc, @"latitude", longitudeLoc, @"longitude", nil] methodType:@"PUT" withToken:true completionHandler:^(NSDictionary *responseDict){
        NSLog(@"%@",responseDict);
        if ([responseDict objectForKey:@"error"]) {
            
            ////error////
            NSLog(@"something is wrong.");
            
        } else {
            
            ////success////
            
            UIAlertController *alertCont = [UIAlertController alertControllerWithTitle:nil message:[responseDict objectForKey:@"success"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                [self performSegueWithIdentifier:@"gotoMain" sender:self];
            }];
            [alertCont addAction:ok];
            [self presentViewController:alertCont animated:YES completion:nil];
        }
    }];
    
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    
    UIAlertController *alertCont = [UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to Get Your Location" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertCont addAction:ok];
    [self presentViewController:alertCont animated:YES completion:nil];
    
    [locationManager startMonitoringSignificantLocationChanges];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    
    if (currentLocation != nil)
    {
        [manager stopUpdatingLocation];
        longitudeLoc = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        latitudeLoc = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"Not Determined");
            break;
            
        case kCLAuthorizationStatusDenied:
        {
            NSLog(@"Denied");
            UIAlertController *alertCont = [UIAlertController alertControllerWithTitle:@"Error" message:@"You need to allow 'WoofnRoof' to access your location. Go to Settings to enable access." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertCont addAction:ok];
            [self presentViewController:alertCont animated:YES completion:nil];
        }
            break;
            
        case kCLAuthorizationStatusRestricted:
            NSLog(@"Restricted");
            break;
            
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"Always Allowed");
            break;
            
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"When In Use Allowed");
            break;
            
        default:
            break;
    }
    
}

#pragma mark - Keyboard handling

////textfield delegates////

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (isiPhone4s || isiPhone5) {
        if (textField.tag == 9 || textField.tag == 10) {
            
            self.profileContentViewTopConst.constant = -200;
            self.profileContentViewBotConst.constant = 200;
            [self.profileContentView setNeedsUpdateConstraints];
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                [self.profileContentView layoutIfNeeded];
                
            } completion:nil];
        }
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (isiPhone4s || isiPhone5) {
        
        if (textField.tag == 7) {
            
            self.profileContentViewTopConst.constant = -200;
            self.profileContentViewBotConst.constant = 200;
            [self.profileContentView setNeedsUpdateConstraints];
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                [self.profileContentView layoutIfNeeded];
                
            } completion:nil];
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 7) {
        [self.profileDobTextfield becomeFirstResponder];
    }
    else if (textField.tag == 9){
        [self.profileContactTextfield becomeFirstResponder];
    }
    else{
        [textField resignFirstResponder];
        if (isiPhone4s || isiPhone5) {
            self.profileContentViewTopConst.constant = 0;
            self.profileContentViewBotConst.constant = 0;
            [self.profileContentView setNeedsUpdateConstraints];
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                [self.profileContentView layoutIfNeeded];
                
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
        [self.profileNameTextfield resignFirstResponder];
        [self.profileEmailTextfield resignFirstResponder];
        [self.profileDobTextfield resignFirstResponder];
        [self.profileContactTextfield resignFirstResponder];
        if (isiPhone4s || isiPhone5) {
            self.profileContentViewTopConst.constant = 0;
            self.profileContentViewBotConst.constant = 0;
            [self.profileContentView setNeedsUpdateConstraints];
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                [self.profileContentView layoutIfNeeded];
                
            } completion:nil];
        }
    }
}

@end
