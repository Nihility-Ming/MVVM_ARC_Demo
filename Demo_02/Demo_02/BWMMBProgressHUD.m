//
//  BWMMBProgressHUD.m
//  BeautifulShop
//
//  Created by Bi Weiming on 15/4/24.
//  Copyright (c) 2015年 jenk. All rights reserved.
//

#import "BWMMBProgressHUD.h"

NSString * const kBWMMBProgressHUDLoadingMsg = @"正在加载...";
NSString * const kBWMMBProgressHUDLoadErrorMsg = @"加载失败";
NSString * const kBWMMBProgressHUDLoadSuccessMsg = @"加载成功";
NSString * const kBWMMBProgressHUDNoMoreDataMsg = @"没有更多数据了";
const NSTimeInterval kBWMMBProgressHUDHideTimeInterval = 1.2f;

static const CGFloat kFontSize = 14.0f;
static const CGFloat kOpacity = 0.85;

@implementation BWMMBProgressHUD

+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view title:(NSString *)title animated:(BOOL)animated {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:animated];
    HUD.labelFont = [UIFont systemFontOfSize:kFontSize];
    HUD.labelText = title;
    HUD.opacity = kOpacity;
    return HUD;
}

+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view title:(NSString *)title {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.labelFont = [UIFont systemFontOfSize:kFontSize];
    HUD.labelText = title;
    HUD.opacity = kOpacity;
    return HUD;
}

+ (void)hideHUD:(MBProgressHUD *)HUD title:(NSString *)title hideAfter:(NSTimeInterval)afterSecond {
    if (title) {
        HUD.labelText = title;
        HUD.mode = MBProgressHUDModeText;
    }
    [HUD hide:YES afterDelay:afterSecond];
}

+ (void)hideHUD:(MBProgressHUD *)HUD hideAfter:(NSTimeInterval)afterSecond {
    [HUD hide:YES afterDelay:afterSecond];
}

+ (void)hideHUD:(MBProgressHUD *)HUD
          title:(NSString *)title
      hideAfter:(NSTimeInterval)afterSecond
        msgType:(BWMMBProgressHUDMsgType)msgType {
    HUD.labelText = title;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self p_imageNamedWithMsgType:msgType]]];
    [HUD hide:YES afterDelay:afterSecond];
}

+ (MBProgressHUD *)showTitle:(NSString *)title toView:(UIView *)view hideAfter:(NSTimeInterval)afterSecond {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelFont = [UIFont systemFontOfSize:kFontSize];
    HUD.labelText = title;
    HUD.opacity = kOpacity;
    [HUD hide:YES afterDelay:afterSecond];
    return HUD;
}

+ (MBProgressHUD *)showTitle:(NSString *)title
           toView:(UIView *)view
        hideAfter:(NSTimeInterval)afterSecond
          msgType:(BWMMBProgressHUDMsgType)msgType {
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.labelFont = [UIFont systemFontOfSize:kFontSize];
    
    NSString *imageNamed = [self p_imageNamedWithMsgType:msgType];
    
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNamed]];
    HUD.labelText = title;
    HUD.opacity = kOpacity;
    HUD.mode = MBProgressHUDModeCustomView;
    [HUD hide:YES afterDelay:afterSecond];
    return HUD;
    
}

+ (NSString *)p_imageNamedWithMsgType:(BWMMBProgressHUDMsgType)msgType {
    NSString *imageNamed = nil;
    if (msgType == BWMMBProgressHUDMsgTypeSuccessful) {
        imageNamed = @"hud_success";
    } else if (msgType == BWMMBProgressHUDMsgTypeError) {
        imageNamed = @"hud_error";
    } else if (msgType == BWMMBProgressHUDMsgTypeWarning) {
        imageNamed = @"hud_warning";
    } else if (msgType == BWMMBProgressHUDMsgTypeInfo) {
        imageNamed = @"hud_info";
    }
    return imageNamed;
}

+ (MBProgressHUD *)showDeterminateHUDTo:(UIView *)view {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
    HUD.animationType = MBProgressHUDAnimationZoom;
    HUD.labelText = kBWMMBProgressHUDLoadingMsg;
    HUD.labelFont = [UIFont systemFontOfSize:kFontSize];
    return HUD;
}

@end
