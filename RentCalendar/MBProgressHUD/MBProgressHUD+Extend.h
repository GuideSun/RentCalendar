//
//  MBProgressHUD+Extend.h
//  KuaiYouJia
//
//  Created by guide_sun on 16/4/19.
//  Copyright © 2016年 KuaiYouJia. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Extend)
/**
 *  显示加载状态的HUD
 *
 *  @param message 加载的提示信息
 *  @param view    所在的视图view
 *
 *  @return hud
 */
+ (MBProgressHUD *)showLoadingMessage:(NSString *)message toView:(UIView *)view;
/**
 *  请求成功的HUD
 *
 *  @param successText 成功的提示信息
 *  @param view        view
 */
+ (void)showSuccess:(NSString *)successText toView:(UIView *)view;
/**
 *  请求失败的HUD
 *
 *  @param errorText 请求失败的提示信息
 *  @param view      view
 */
+ (void)showError:(NSString *)errorText toView:(UIView *)view;
/**
 *  textfiled 等显示的提示信息
 *
 *  @param tipMessage 提示信息内容
 *  @param view       view
 */
+ (void)showTipMessage:(NSString *)tipMessage toView:(UIView *)view;

@end
