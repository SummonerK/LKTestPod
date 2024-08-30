//
//  UIApplication+Ext.m
//  LKUtils
//
//  Created by lofi on 2024/8/29.
//

#import "UIApplication+Ext.h"

@implementation UIApplication (Ext)

- (UIWindow *)xm_keyWindow {
    for (UIWindowScene* windowScene in self.connectedScenes) {
        if (windowScene.activationState == UISceneActivationStateForegroundActive ||
            windowScene.activationState == UISceneActivationStateBackground) {
            for (UIWindow *window in windowScene.windows) {
                if (window.windowLevel != UIWindowLevelNormal || window.hidden) {
                    continue;
                }
                if (CGRectEqualToRect(window.bounds, UIScreen.mainScreen.bounds) && window.isKeyWindow) {
                    return window;
                }
            }
        }
    }
    
    UIWindow *keyWindow = nil;
    for (UIWindow *window in self.windows) {
        if (window.windowLevel == UIWindowLevelNormal && window.hidden == NO && CGRectEqualToRect(window.bounds, UIScreen.mainScreen.bounds) && window.isKeyWindow) {
            keyWindow = window;
            break;
        }
    }
    if (!keyWindow) {
        keyWindow = self.delegate.window;
    }
    return keyWindow;
}

@end
