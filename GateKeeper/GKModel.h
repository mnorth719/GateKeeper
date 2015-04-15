//
//  GKModel.h
//  GateKeeper
//
//  Created by Matt  North on 4/7/15.
//  Copyright (c) 2015 mk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GKModel : NSObject

@property (unsafe_unretained, nonatomic) id delegate;
@property (strong, nonatomic) NSString *userId;

- (BOOL)hasValidToken;
- (void)registerPin:(NSNumber *)pin;
- (void)openClosestGate;
- (NSString *)token;
+ (id)nullify:(id)object;

//error displaying
void quickAlert(NSString *title, NSString *message, NSString *optionalButtonTitle);

@end

@protocol GKModelDelegate <NSObject>

- (void)modelDidAuthorizePin;
- (void)modelDidOpenGate; 

@end
