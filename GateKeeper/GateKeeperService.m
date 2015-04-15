//
//  GateKeeperService.m
//  GateKeeper
//
//  Created by Matt  North on 4/7/15.
//  Copyright (c) 2015 mk. All rights reserved.
//

#import "GateKeeperService.h"
#import "GateKeeperService.h"

@implementation GateKeeperService

- (void)registerPin:(NSNumber*)pin withCompletion:(GKServiceCompletion)completion {
    NSDictionary *paramsObj = [NSDictionary dictionaryWithObjectsAndKeys:
                               pin, @"pin",
                               nil];
    [super sendRequest:@"pin" toService:GK_SERVICE_ROOT withParams:paramsObj withCompletion:^(id response, id method, id error) {
        completion(response, method, error); 
    }];
}

- (void)openGateWithAuth:(NSString *)auth andGateId:(NSString *)gateId andUserId:(NSString *)userId withCompletion:(GKServiceCompletion)completion {
    NSDictionary *paramsObj = [NSDictionary dictionaryWithObjectsAndKeys:
                               auth, @"token",
                               gateId, @"gateId",
                               userId, @"userId"
                               , nil];
    
    [super sendRequest:@"gate" toService:GK_SERVICE_ROOT withParams:paramsObj withCompletion:^(id response, id method, id error) {
        completion(response, method, error);
    }];
}

@end
