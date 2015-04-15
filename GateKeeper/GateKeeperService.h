//
//  GateKeeperService.h
//  GateKeeper
//
//  Created by Matt  North on 4/7/15.
//  Copyright (c) 2015 mk. All rights reserved.
//

#import "GKWebService.h"
#import "GKModel.h"


@interface GateKeeperService : GKWebService

- (void)registerPin:(NSNumber*)pin withCompletion:(GKServiceCompletion)completion;
- (void)openGateWithAuth:(NSString *)auth andGateId:(NSString *)gateId andUserId:(NSString *)userId withCompletion:(GKServiceCompletion)completion;
@end
