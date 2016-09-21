//
//  CheckInfoViewController.m
//  WoofnRoof
//
//  Created by iOS Developer on 12/09/16.
//  Copyright © 2016 Prabh Kiran Kaur. All rights reserved.
//

#import "CheckInfoViewController.h"

@interface CheckInfoViewController (){
    UITextField *activetextfield;
    UIToolbar *keyboardToolbar;
    UIDatePicker *datePicker;
    NSDateFormatter *df ;
}
@end

@implementation CheckInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //close keyboard when touch anywhere
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
        [self.view addGestureRecognizer:tap];
    
    //start keyboard notification
        [self registerForKeyboardNotifications];
    
    //set datepicker
        datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        datePicker.tag = 5;
        _dateOfBIrthTextfield.inputView = datePicker;
    
    //create tollbar for datepicker field
        if (keyboardToolbar == nil) {
            keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
        UIBarButtonItem *extraSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *accept = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyboard)];
        [keyboardToolbar setItems:[[NSArray alloc] initWithObjects: extraSpace, accept, nil]];
    }
    //set tollbar on field
        _dateOfBIrthTextfield.inputAccessoryView = keyboardToolbar;
    
   
}

-(void)viewDidUnload{
    //end keyboard notication
    [self unRegisterForKeyboardNotifications];
}

//dismiss keyboard
-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

//method called when date is changed
- (void)datePickerValueChanged:(id)sender{
    NSDate *date = datePicker.date;
    if (df == nil) {
        df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"MMMM dd, yyyy"];
    }
    [_dateOfBIrthTextfield setText:[df stringFromDate:date]];
    date = NULL;
}

//textfield delegate methods
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    activetextfield = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    activetextfield = nil;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 1) {
        [_emailTextfield becomeFirstResponder];
    } else if (textField.tag == 2) {
        [_dateOfBIrthTextfield becomeFirstResponder];
           } else if (textField.tag == 3) {
         [_contactNumberTextfield becomeFirstResponder];
    } else if(textField.tag == 4){
        [self.view endEditing:true];
    }
    return true;
}


#pragma mark - event of keyboard relative methods
- (void)registerForKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShown:)  name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:)          name:UIKeyboardWillHideNotification object:nil];
}

// unregister for keyboard notifications while not visible.
-(void)unRegisterForKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification                                       object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self                                                name:UIKeyboardWillHideNotification object:nil];
}

//method to make tetxtfield go up (if not visible)
- (void)keyboardWillShown:(NSNotification*)aNotification{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height + 40, 0.0);
    _mainScrollView.contentInset = contentInsets;
    _mainScrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activetextfield.frame.origin) ) {
        [self.mainScrollView scrollRectToVisible:activetextfield.frame animated:YES];
    }
}

//set scrollview to normal
- (void)keyboardWillBeHidden:(NSNotification*)aNotification{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _mainScrollView.contentInset = contentInsets;
    _mainScrollView.scrollIndicatorInsets = contentInsets;
}




@end
