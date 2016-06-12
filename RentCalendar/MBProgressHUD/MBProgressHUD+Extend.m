//
//  MBProgressHUD+Extend.m
//  KuaiYouJia
//
//  Created by guide_sun on 16/4/19.
//  Copyright © 2016年 KuaiYouJia. All rights reserved.
//

#import "MBProgressHUD+Extend.h"
#define kLastWindow [UIApplication sharedApplication].keyWindow
@implementation MBProgressHUD (Extend)

#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (!view) {
        view = kLastWindow;
     }
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:view animated:YES];
            MBProgressHUD *hud  = [MBProgressHUD showHUDAddedTo:view animated:YES];
            hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
            
            hud.mode = MBProgressHUDModeCustomView;
            
            hud.removeFromSuperViewOnHide = YES;
            if (text.length >17) {
                hud.detailsLabelText = text;
                [hud hide:YES afterDelay:2.5];
            }else{
                hud.labelText = text;
                [hud hide:YES afterDelay:1.5];
            }
            
        });
}
#pragma mark 显示成功信息
+ (void)showSuccess:(NSString *)successText toView:(UIView *)view
{
    if (!view) {
        view = kLastWindow;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:view animated:YES];
        //    [self show:successText icon:@"success.png" view:view];
    });

}
#pragma mark 显示错误信息
+ (void)showError:(NSString *)errorText toView:(UIView *)view{
    [self show:errorText icon:@"error.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showLoadingMessage:(NSString *)message toView:(UIView *)view {
    if (!view) {
        view = kLastWindow;
    }
    [MBProgressHUD hideHUDForView:view animated:YES];
    MBProgressHUD *hud = [[MBProgressHUD alloc]init];
    dispatch_async(dispatch_get_main_queue(), ^{
        [view addSubview:hud];
        [hud show:YES];
        hud.labelText = message;
        hud.removeFromSuperViewOnHide = YES;
    });
    
    return hud;
}
+ (void)showTipMessage:(NSString *)tipMessage toView:(UIView *)view{
    if (!view) {
        view = kLastWindow;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:view animated:YES];
        
        MBProgressHUD *hud  = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.margin = 10.f;
        if (tipMessage.length >17) {
            hud.detailsLabelText = tipMessage;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:2.5];
        }else{
            hud.labelText = tipMessage;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:1.5];
        }
    });
}

@end
