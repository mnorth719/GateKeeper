//
//  GKWebService.m
//  GateKeeper
//
//  Created by Matt  North on 4/7/15.
//  Copyright (c) 2015 mk. All rights reserved.
//

#import "GKWebService.h"

NSString * const GK_SERVICE_ROOT = @"api";

@implementation GKWebService

- (void)sendRequest:(NSString *)request toService:(NSString *)service withParams:(NSDictionary *)params withCompletion:(GKServiceCompletion)completion {
    
    NSString *webURL = [[NSUserDefaults standardUserDefaults] valueForKey:@"webServiceURL"];
    
    if (!webURL){
        quickAlert(@"Error", @"Please Enter a service URL in app settings", nil);
        return;
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/%@/%@", webURL, service, request]];
    NSString *JSONString = [params JSONStringWithPretty:NO];
    
    if (url && JSONString) {
        NSMutableURLRequest *TheRequest = [NSMutableURLRequest requestWithURL:url];
        [TheRequest setHTTPMethod:@"POST"];
        [TheRequest setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO]];
        [TheRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [TheRequest setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        
        [NSURLConnection sendAsynchronousRequest:TheRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            if (connectionError) {
                completion(nil, request, connectionError);
            }else{
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                
                id serializedObj = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:nil];
                
                //if response is valid, call completion
                if (![self validateResponseData:httpResponse andData:serializedObj]){
                    completion (serializedObj, request, nil);
                }else{
                    
                    completion (nil, request, [self validateResponseData:httpResponse andData:serializedObj]);
                }
            }
            
        }];
    }
}

- (NSError *)validateResponseData:(NSHTTPURLResponse *)httpResponse andData:(id)responseBody {
    NSInteger statusCode = [httpResponse statusCode];
    
    NSError *error;
    
    switch (statusCode) {
        case 404:
        case 403:
        case 400:
        case 500:
        case 503:
        case 0:
        {
            
            NSString *errorMsg;
            if ([responseBody objectForKey:@"message"]) {
                errorMsg = [responseBody objectForKey:@"message"];
            }else{
                errorMsg = @"Unknown Error";
            }
            
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorMsg
                                                                 forKey:NSLocalizedDescriptionKey];
            error = [[NSError alloc] initWithDomain:@"GKNotFound" code:statusCode userInfo:userInfo];
        }
            break;
        default:
            break;
    }
    return error;
}

@end

@implementation NSObject (GKObject)

- (NSString *)JSONStringWithPretty:(BOOL)prettyString {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:(prettyString ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    
    if (jsonData && !error) {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return nil;
}

@end
