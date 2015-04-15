//
//  GKNavigationController.m
//  GateKeeper
//
//  Created by Matt  North on 4/7/15.
//  Copyright (c) 2015 mk. All rights reserved.
//

#import "GKNavigationController.h"
#import "GateLockController.h"
#import "AppTokenController.h"

@interface GKNavigationController ()

@property (strong, nonatomic) GKModel *model;

@end

@implementation GKNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _model = [[GKModel alloc] init];
    [_model setDelegate:self];
    
//    if ([_model hasValidToken]) {
//        [self presentGateController:YES];
//    }else{
//        [self presentTokenController:YES];
//    }
    [self presentTokenController:YES];
}

- (void)presentGateController:(BOOL)animated {
    GateLockController *gateController = [[GateLockController alloc] initWithNibName:@"GateLockController"
                                                                              bundle:[NSBundle mainBundle]
                                                                               model:_model];
    [self pushViewController:gateController animated:animated];
    
}

- (void)presentTokenController:(BOOL)animated {
    AppTokenController *tokenController = [[AppTokenController alloc] initWithNibName:@"AppTokenController"
                                                                               bundle:[NSBundle mainBundle]
                                                                                model:_model];
    
    [self pushViewController:tokenController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)modelDidAuthorizePin {
    if ([self.visibleViewController isKindOfClass:[AppTokenController class]]) {
        [self popToRootViewControllerAnimated:YES];
        [self presentGateController:YES];
    }
}

- (void)modelDidOpenGate {
    quickAlert(@"Nice!", @"Opened Gate!", nil);
}



@end
