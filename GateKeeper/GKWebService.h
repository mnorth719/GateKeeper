//
//  GKWebService.h
//  GateKeeper
//
//  Created by Matt  North on 4/7/15.
//  Copyright (c) 2015 mk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GKModel.h"

typedef void(^GKServiceCompletion) (id response, id method, id error);

extern NSString * const GK_SERVICE_ROOT;

@interface GKWebService : NSObject

- (void)sendRequest:(NSString *)request toService:(NSString *)service withParams:(NSDictionary *)params withCompletion:(GKServiceCompletion)completion;

@end

//JSON conversion extension
@interface NSObject (GKObject)

- (NSString *)JSONStringWithPretty:(BOOL)prettyString;

@end
