//
//  GKGate.h
//  GateKeeper
//
//  Created by Matt  North on 4/11/15.
//  Copyright (c) 2015 mk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GKModel.h"
#import "GKLocationManager.h"

@interface GKGate : NSObject

- (void)openGate;
+ (GKGate *)buildGateFromDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)convertToDictionary; 

@property (nonatomic, strong) GKModel *model;
@property (nonatomic, assign) CLLocationCoordinate2D coordinates;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) NSString *gateId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDecimalNumber *proximity;

@end
