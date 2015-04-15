//
//  GKViewController.h
//  GateKeeper
//
//  Created by Matt  North on 4/7/15.
//  Copyright (c) 2015 mk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GKModel.h"

@interface GKViewController : UIViewController

@property (unsafe_unretained, nonatomic) GKModel *model;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil model:(GKModel*)model;

@end
