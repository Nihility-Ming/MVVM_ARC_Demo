//
//  BWMRequestCenter.m
//  BWMRequestCenter
//
//  Created by 伟明 毕 on 15/3/29.
//  Copyright (c) 2015年 Bi Weiming. All rights reserved.
//

#import "BWMRequestCenter.h"
#import <AFNetworking.h>

static NSTimeInterval _timeoutInterval = 10.0f;
static NSString * const _contentType = @"text/plain";

@implementation BWMRequestCenter

#pragma mark- Private Methods

+ (AFHTTPRequestOperationManager *)p_manager {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:_contentType];
    manager.requestSerializer.timeoutInterval = _timeoutInterval;
    return manager;
}

+ (AFHTTPRequestOperation *)p_GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    return [[self p_manager] GET:URLString parameters:parameters success:success failure:failure];
}

+ (AFHTTPRequestOperation *)p_POST:(NSString *)URLString
                       parameters:(id)parameters
                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    return [[self p_manager] POST:URLString parameters:parameters success:success failure:failure];
}

#pragma mark- GET Methods
+ (AFHTTPRequestOperation *)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    return [self p_GET:URLString parameters:parameters success:success failure:failure];
}


#pragma mark- POST Methods

+ (AFHTTPRequestOperation *)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    return [self p_POST:URLString parameters:parameters success:success failure:failure];
}



@end