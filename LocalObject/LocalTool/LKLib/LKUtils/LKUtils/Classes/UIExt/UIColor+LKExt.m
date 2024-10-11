//
//  UIColor+LKExt.m
//  LKUtils
//
//  Created by lofi on 2024/7/20.
//

#import "UIColor+LKExt.h"
#import <YYCategories/YYCategories.h>

@implementation UIColor (LKExt)

+ (UIColor *)LKColorWithLightHex:(NSString *)lightHexStr darkHex:(NSString *)darkHexStr {
    if (!lightHexStr) {
        lightHexStr = @"#FFFFFF";
    }
    if (!darkHexStr) {
        darkHexStr = @"#000000";
    }
    UIColor *lightColor = [UIColor colorWithHexString:lightHexStr];
    UIColor *darkColor = [UIColor colorWithHexString:darkHexStr];
    return [self LKColorWithColorLight:lightColor dark:darkColor];
}

+ (UIColor *)LKColorWithColorLight:(UIColor *)light dark:(UIColor *)dark {
    if (@available(iOS 13.0, *)) {
        return [self colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            switch (traitCollection.userInterfaceStyle) {
                case UIUserInterfaceStyleDark:
                    return dark;
                case UIUserInterfaceStyleLight:
                case UIUserInterfaceStyleUnspecified:
                default:
                    return light;
            }
        }];
    } else {
        return light;
    }
}

+ (UIColor *)LKColorWithHex:(NSString *)hexStr {
    return [UIColor colorWithHexString:hexStr];
}

/// 随机颜色
+ (UIColor *)LKRandomColor:(CGFloat)withAlpha{
    CGFloat red   = ((CGFloat) (arc4random() % 158) + 49)/ 255.0;
    CGFloat green = ((CGFloat) (arc4random() % 158) + 49)/ 255.0;
    CGFloat blue  = ((CGFloat) (arc4random() % 158) + 49)/ 255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:withAlpha];
}

@end
