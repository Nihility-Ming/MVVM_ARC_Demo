//
//  BWMRequestCenter.h
//  BWMRequestCenter
//
//  Created by 伟明 毕 on 15/3/29.
//  Copyright (c) 2015年 Bi Weiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFHTTPRequestOperation.h>

/**
 *  BWM专用网络请求
 */
@interface BWMRequestCenter : NSObject

#pragma mark- GET Methods
/** GET请求 */
+ (AFHTTPRequestOperation *)GET:(NSString *)URLString
                       parameters:(NSDictionary *)parameters
                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

#pragma mark- POST Methods
/** POST请求 */
+ (AFHTTPRequestOperation *)POST:(NSString *)URLString
                       parameters:(NSDictionary *)parameters
                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


@end
