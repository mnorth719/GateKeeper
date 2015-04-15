//
//  AppTokenController.h
//  GateKeeper
//
//  Created by Matt  North on 4/2/15.
//  Copyright (c) 2015 mk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GKViewController.h"

@interface AppTokenController : GKViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *appTextField;


@end
