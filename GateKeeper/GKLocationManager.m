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
    
        if ([[self getLocation] distanceFromLocation:closesGate.location] >
            [[self getLocation] distanceFromLocation:gate.location] || closesGate == nil) {
            closesGate = gate;
        }
    }
    
    return closesGate;
}

- (void)registerGatesAsRegions:(NSArray *)gates {
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    for (GKGate *gate in gates) {
        CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:gate.coordinates
                                                                     radius:500.0f
                                                                 identifier:gate.name];
        
        [self.locationManager startMonitoringForRegion:(CLRegion *)region];
    }
    
}

- (CLLocation *)getLocation {
    return self.locationManager.location;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    quickAlert(@"Error", [error localizedDescription], nil); 
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    [manager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertAction = @"Unlock";
    notification.alertBody = @"Swipe to unlock gate %@";
    notification.alertTitle = @"Found Gate!";
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    quickAlert(@"Error", [error localizedDescription], nil);
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    NSLog(@"started monitoring");
}


@end
