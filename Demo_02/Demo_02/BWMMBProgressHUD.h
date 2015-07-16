//
//  BWMMBProgressHUD.h
//  BeautifulShop
//
//  Created by Bi Weiming on 15/4/24.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

extern NSString * const kBWMMBProgressHUDLoadingMsg;
extern NSString * const kBWMMBProgressHUDLoadErrorMsg;
extern NSString * const kBWMMBProgressHUDLoadSuccessMsg;
extern NSString * const kBWMMBProgressHUDNoMoreDataMsg;
extern const NSTimeInterval kBWMMBProgressHUDHideTimeInterval;

typedef NS_ENUM(NSUInteger, BWMMBProgressHUDMsgType) {
    BWMMBProgressHUDMsgTypeSuccessful,
    BWMMBProgressHUDMsgTypeError,
    BWMMBProgressHUDMsgTypeWarning,
    BWMMBProgressHUDMsgTypeInfo
};

/**
 *  @brief  一个MBProgressHUD封装的工厂
 */
@interface BWMMBProgressHUD : NSObject

/**
 *  @brief  添加一个带菊花的HUD
 *
 *  @param view  目标view
 *  @param title 标题
 *
 *  @return MBProgressHUD
 */
+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view title:(NSString *)title;
+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view
                            title:(NSString *)title
                         animated:(BOOL)animated;

/**
 *  @brief  隐藏指定的HUD
 *
 *  @param HUD         指定的HUD
 *  @param afterSecond 多少秒后
 */
+ (void)hideHUD:(MBProgressHUD *)HUD hideAfter:(NSTimeInterval)afterSecond;
+ (void)hideHUD:(MBProgressHUD *)HUD
          title:(NSString *)title
      hideAfter:(NSTimeInterval)afterSecond;
+ (void)hideHUD:(MBProgressHUD *)HUD
          title:(NSString *)title
      hideAfter:(NSTimeInterval)afterSecond
        msgType:(BWMMBProgressHUDMsgType)msgType;

/**
 *  @brief  显示一个自定的HUD
 *
 *  @param title       标题
 *  @param view        目标view
 *  @param afterSecond 持续时间
 *
 *  @return MBProgressHUD
 */
+ (MBProgressHUD *)showTitle:(NSString *)title
                      toView:(UIView *)view
                   hideAfter:(NSTimeInterval)afterSecond;
+ (MBProgressHUD *)showTitle:(NSString *)title
           toView:(UIView *)view
        hideAfter:(NSTimeInterval)afterSecond
          msgType:(BWMMBProgressHUDMsgType)msgType;

/**
 *  @brief  显示一个型式的HUD
 *
 *  @param view 目标view
 *
 *  @return MBProgressHUD
 */
+ (MBProgressHUD *)showDeterminateHUDTo:(UIView *)view;

@end
