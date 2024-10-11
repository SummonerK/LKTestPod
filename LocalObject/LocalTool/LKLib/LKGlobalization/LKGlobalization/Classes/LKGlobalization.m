//
//  LKGlobalization.m
//  CocoaAsyncSocket
//
//  Created by lofi on 2024/10/11.
//

#import "LKGlobalization.h"
#import <objc/runtime.h>

#define LKLocalizableBundle  @"LKLocalizable"
/// 这里涉及历史版本用key，所以不作变更，沿用@"TUICustomLanguageKey"
#define LKCustomLanguageKey @"TUICustomLanguageKey"
#define LKGlobalizationBundlePath(bundleName, bundleKeyClass) [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"].length > 0 ? [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"] : [[NSBundle bundleForClass:NSClassFromString(bundleKeyClass)] pathForResource:bundleName ofType:@"bundle"]
#define LKLocalization(bundleName) [NSBundle bundleWithPath:LKGlobalizationBundlePath(bundleName, @"XMGlobalization")]

@implementation LKGlobalization

+ (NSString *)localizedStringForKey:(NSString *)key value:(nullable NSString *)value bundle:(nonnull NSString *)bundleName {
    NSString *language = [self localizableLanguageKey];
    language = [@"Localizable" stringByAppendingPathComponent:language];
    NSBundle *bundle = [NSBundle bundleWithPath:[LKLocalization(bundleName) pathForResource:language ofType:@"lproj"]];
    value = [bundle localizedStringForKey:key value:value table:nil];
    if (value == nil) {
        NSLog(@"没有找到国际化：%@对应的值", key);
    }
    return value?:key;
}

+ (NSString *)localizedStringForKey:(NSString *)key bundle:(nonnull NSString *)bundleName {
    return [self localizedStringForKey:key value:nil bundle:bundleName];
}

+ (NSString *)localizedStringForKey:(NSString *)key {
    return [self localizedStringForKey:key value:nil bundle:LKLocalizableBundle];
}

+ (NSString *)localizedStringForKey:(NSString *)key placeHolder:(NSString *)placeHolder {
    NSString *localizedKey = [self localizedStringForKey:key];
    return [NSString stringWithFormat:localizedKey,placeHolder];
}

+ (NSString *)localizableLanguageKey {
    // 自定义
    NSString *customLanguage = [self getCustomLanguage];
    if (customLanguage.length) {
        return customLanguage;
    }
    
    // 默认跟随系统
    NSString *language = [NSLocale preferredLanguages].firstObject;
    if ([language hasPrefix:@"en"]) {
        language = @"en";
    } else if ([language hasPrefix:@"zh"]) {
        if ([language rangeOfString:@"Hans"].location != NSNotFound) {
            language = @"zh-Hans"; // 简体中文
        } else { // zh-Hant\zh-HK\zh-TW
            language = @"zh-Hant"; // 繁體中文
        }
    } else if ([language hasPrefix:@"id"]) {
        language = @"id";
    } else {
        language = @"en";
    }
    
    // MARK: - 由于暂时不支持繁体，避免繁体中文也使用英文，此处强制使用简体中文
    if ([language hasPrefix:@"zh"]) {
        language = @"zh-Hans";
    }
    
    return language;
}

+ (void)setCustomLanguage:(NSString *)language {
    [NSUserDefaults.standardUserDefaults setObject:language?:@"" forKey:LKCustomLanguageKey];
    [NSUserDefaults.standardUserDefaults synchronize];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [NSNotificationCenter.defaultCenter postNotificationName:LKChangeLanguageNotification object:nil];
    });
}

+ (NSString *)getCustomLanguage {
    return [NSUserDefaults.standardUserDefaults objectForKey:LKCustomLanguageKey];
}

@end


@interface LKUIBundle : NSBundle

@end

@implementation LKUIBundle

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
    if ([LKUIBundle private_mainBundle]) {
        return [[LKUIBundle private_mainBundle] localizedStringForKey:key value:value table:tableName];
    } else {
        return [super localizedStringForKey:key value:value table:tableName];
    }
}

+ (NSBundle *)private_mainBundle {
    NSString *customLanguage = [LKGlobalization localizableLanguageKey];
    if (customLanguage.length) {
        NSString *path = [[NSBundle mainBundle] pathForResource:customLanguage ofType:@"lproj"];
        if (path.length) {
            return [NSBundle bundleWithPath:path];
        }
    }
    return nil;
}

@end

@interface NSBundle (Localization)

@end

@implementation NSBundle (Localization)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //动态继承、交换，方法类似KVO，通过修改[NSBundle mainBundle]对象的isa指针，使其指向它的子类XMUIBundle，这样便可以调用子类的方法；其实这里也可以使用method_swizzling来交换mainBundle的实现，来动态判断，可以同样实现。
        object_setClass([NSBundle mainBundle], [LKUIBundle class]);
    });
}

@end
