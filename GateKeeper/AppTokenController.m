//
//  AppTokenController.m
//  GateKeeper
//
//  Created by Matt  North on 4/2/15.
//  Copyright (c) 2015 mk. All rights reserved.
//

#import "AppTokenController.h"
#import "GKModel.h"

@interface AppTokenController ()

@property (unsafe_unretained, nonatomic) GKModel *model;

@end

@implementation AppTokenController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text.length > 0) {
        
        NSNumber *pin = [NSNumber numberWithInteger:[textField.text integerValue]];
        [self.model registerPin:pin];
    }
    
    return YES; 
}

@end
