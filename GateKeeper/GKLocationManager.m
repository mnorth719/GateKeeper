//
//  GKLocationManager.m
//  GateKeeper
//
//  Created by Matt  North on 4/11/15.
//  Copyright (c) 2015 mk. All rights reserved.
//
#import "GKLocationManager.h"
#import "GKGate.h"

@interface GKLocationManager()

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation GKLocationManager

- (id)init {
    
    self = [super init];
    
    if (self) {
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
        
        [self.locationManager requestWhenInUseAuthorization];
    }

    return self;
}

- (GKGate *)getClosestGate:(NSArray *)gates {
    
    GKGate *closesGate;
    
    for (GKGate *gate in gates) {
    
        if ([self.locationManager.location distanceFromLocation:closesGate.location] >
            [self.locationManager.location distanceFromLocation:gate.location] || closesGate == nil) {
            closesGate = gate;
        }
    }
    
    return closesGate;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    quickAlert(@"Error", [error localizedDescription], nil); 
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    [manager startUpdatingLocation];
}


@end
