//
//  UIApplication+Ext.h
//  LKUtils
//
//  Created by lofi on 2024/8/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (Ext)

- (UIWindow *)xm_keyWindow;

+ (void)makeToast:(nullable NSString *)str;

@end

NS_ASSUME_NONNULL_END
