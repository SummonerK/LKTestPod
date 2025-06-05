//
//  LKGlobalization.h
//  CocoaAsyncSocket
//
//  Created by lofi on 2024/10/11.
//

#import <Foundation/Foundation.h>
// 字符串国际化
#define LKLocalizable(key) [LKGlobalization localizedStringForKey:key]

#define LKChangeLanguageNotification @"LKChangeLanguageNotification"

NS_ASSUME_NONNULL_BEGIN

@interface LKGlobalization : NSObject

@property (class, getter=getCustomLanguage, setter=setCustomLanguage:) NSString *customLanguage;

// 字符串国际化，bundle 的格式参考 XMLocalizable.bundle
+ (NSString *)localizedStringForKey:(NSString *)key bundle:(NSString *)bundleName;

+ (NSString *)localizableLanguageKey;

+ (NSString *)localizedStringForKey:(NSString *)key;

+ (NSString *)localizedStringForKey:(NSString *)key placeHolder:(NSString *)placeHolder;


@end

NS_ASSUME_NONNULL_END
