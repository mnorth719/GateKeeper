//
//  GKLocationManager.h
//  GateKeeper
//
//  Created by Matt  North on 4/11/15.
//  Copyright (c) 2015 mk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class GKGate;

@interface GKLocationManager : NSObject <CLLocationManagerDelegate>

- (GKGate *)getClosestGate:(NSArray *)gates;
- (CLLocation *)getLocation;
- (void)registerGatesAsRegions:(NSArray *)gates;

@end
