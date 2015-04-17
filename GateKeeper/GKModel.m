//
//  GKModel.m
//  GateKeeper
//
//  Created by Matt  North on 4/7/15.
//  Copyright (c) 2015 mk. All rights reserved.
//

#import "GKModel.h"
#import "GateKeeperService.h"
#import "GKGate.h"
#import "GKLocationManager.h"

@interface GKModel()

@property (strong, nonatomic) NSArray *gates;
@property (strong, nonatomic) GKLocationManager *locationManager;

@end

@implementation GKModel

- (id)init {
    self = [super init];
    
    if (self) {
        //additional set up here
        self.locationManager = [GKLocationManager new];
    }
    
    return self;
}

- (BOOL)hasValidToken {
    return [[[NSUserDefaults standardUserDefaults] stringForKey:@"appToken"] length] > 0;
}

- (NSString *)token {
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"appToken"];
}

- (void)registerPin:(NSNumber *)pin {
    GateKeeperService *gkService = [GateKeeperService new];
    [gkService registerPin:pin withCompletion:^(id response, id method, id error) {
        if (!error) {
            
            NSLog(@"%@", response);
            if ([self.delegate respondsToSelector:@selector(modelDidAuthorizePin)]) {
                [self.delegate modelDidAuthorizePin];
            }
            
            NSMutableArray *gatesArray = [NSMutableArray array];
            
            for (NSDictionary *gate in response[@"gates"]) {
                GKGate *gateObj = [GKGate buildGateFromDictionary:gate];
                gateObj.model = self; 
                [gatesArray addObject:gateObj];
            }
            self.gates = [NSArray arrayWithArray:gatesArray];
            self.userId = response[@"userId"];
            [[NSUserDefaults standardUserDefaults] setValue:[response objectForKey:@"token"] forKey:@"appToken"];
            
            [self.locationManager registerGatesAsRegions:self.gates];
            
        }else {
            quickAlert(@"Error", [error localizedDescription], nil);
        }
    }];
}

- (void)openClosestGate {
    GKGate *closestGate = [self.locationManager getClosestGate:self.gates];
    NSDecimalNumber *distance = [[NSDecimalNumber alloc] initWithDouble:[[self.locationManager getLocation] distanceFromLocation:closestGate.location]];
    distance = [GKModel roundToNearestHundreths:distance];
    
    if (closestGate && [closestGate.proximity compare:distance] != NSOrderedAscending) {
        [closestGate openGate];
    }else{
        quickAlert(@"Error", @"No gates found in range.", nil);
    }
}

+ (id)nullify:(id)object {
    if (object == nil) {
        return [NSNull null];
    }
    
    return object; 
}

+ (NSDecimalNumber *)roundToNearestHundreths:(NSDecimalNumber *)number
{
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                                                                                      scale:2
                                                                                           raiseOnExactness:NO
                                                                                            raiseOnOverflow:YES
                                                                                           raiseOnUnderflow:YES
                                                                                        raiseOnDivideByZero:YES];
    
    NSDecimalNumber *rounded = [number decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return rounded;
}

void quickAlert(NSString *title, NSString *message, NSString *optionalButtonTitle) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:(optionalButtonTitle != nil) ? optionalButtonTitle : @"Ok"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

@end
