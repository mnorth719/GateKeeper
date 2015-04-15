//
//  GKGate.m
//  GateKeeper
//
//  Created by Matt  North on 4/11/15.
//  Copyright (c) 2015 mk. All rights reserved.
//

#import "GKGate.h"
#import "GateKeeperService.h"

@interface GKGate()

@property (nonatomic, strong) NSString *gateId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDecimalNumber *proximity;

@end


@implementation GKGate

- (id)initWithModel:(GKModel *)model {
    self = [super init];
    
    if (self) {
        self.model = model;
        
    }
    
    return self;
}

- (void)openGate {
    
    if ([self.model token]) {
        GateKeeperService *gkService = [GateKeeperService new];
        [gkService openGateWithAuth:self.model.token andGateId:self.gateId andUserId:self.model.userId withCompletion:^(id response, id method, id error) {
            
            if (error) {
                quickAlert(@"Error:", [error localizedDescription], nil);
            }else{
                quickAlert(@" ", [NSString stringWithFormat:@"opened gate - %@", self.name], nil);
            }
            
        }];
         
         }else{
        quickAlert(@"Error", @"Invalid Auth", nil);
    }
}

- (void)setCoordinates:(CLLocationCoordinate2D)coordinates {
    _coordinates = coordinates;
    self.location = [[CLLocation alloc] initWithLatitude:coordinates.latitude longitude:coordinates.longitude];
}

+ (GKGate *)buildGateFromDictionary:(NSDictionary *)dictionary {
    GKGate *gate = [GKGate new];;
    gate.name = dictionary[@"name"];
    gate.gateId = dictionary[@"id"];
    
    CLLocationDegrees lat = [[dictionary[@"location"] objectForKey:@"latitude"] doubleValue];
    CLLocationDegrees lon = [[dictionary[@"location"] objectForKey:@"longitude"] doubleValue];
    gate.coordinates = CLLocationCoordinate2DMake(lat, lon);
    gate.proximity = [NSDecimalNumber decimalNumberWithDecimal:[dictionary[@"proximity"] decimalValue]];
    return gate;
}

@end
