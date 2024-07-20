//
//  UIColor+LKExt.h
//  LKUtils
//
//  Created by lofi on 2024/7/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (LKExt)

/// 设置浅色模式颜色和深色模式颜色
/// - Parameters:
///   - lightHexStr: 浅色模式十六进制颜色 ， 如：#ffffff
///   - darkHexStr: 深色模式十六进制颜色 ， 如：#000000
+ (UIColor *)LKColorWithLightHex:(NSString *)lightHexStr darkHex:(NSString *)darkHexStr;

/// 设置浅色模式颜色和深色模式颜色
/// - Parameters:
///   - lightHexStr: 浅色模式十六进制颜色 ， 如：[UIColor colorWithHexString:@"#ffffff"
///   - darkHexStr: 深色模式十六进制颜色 ， 如：[UIColor colorWithHexString:@"#000000"
+ (UIColor *)LKColorWithColorLight:(UIColor *)light dark:(UIColor *)dark;

@end

NS_ASSUME_NONNULL_END
