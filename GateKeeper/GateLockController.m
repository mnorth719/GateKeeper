//
//  GateLockController.m
//  GateKeeper
//
//  Created by Matt  North on 4/2/15.
//  Copyright (c) 2015 mk. All rights reserved.
//

#import "GateLockController.h"

@interface GateLockController ()

@end

@implementation GateLockController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)touchedUnlockGate:(id)sender{
    [self.model openClosestGate];
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
