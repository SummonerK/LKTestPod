//
//  LKMacroDefine.h
//  LKUtils
//
//  Created by lofi on 2024/7/16.
//

#ifndef LKMacroDefine_h
#define LKMacroDefine_h
#import "UIColor+LKExt.h"

/////////////////////////////////////////////////////////////////////////////////
//
//                             设备系统相关
//
/////////////////////////////////////////////////////////////////////////////////
#define KScreen_Width        [UIScreen mainScreen].bounds.size.width
#define KScreen_Height       [UIScreen mainScreen].bounds.size.height
#define Kis_Iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define Kis_IPhoneX (KScreen_Width >=375.0f && KScreen_Height >=812.0f && Kis_Iphone)
#define KStatusBar_Height    (Kis_Iphone ? (44.0):(20.0))
#define KTabBar_Height       (Kis_Iphone ? (57.0 + 34.0):(57.0))
#define KNavBar_Height       (KScreen_Height  >= 812.0 ? 64 : 44)
#define KSafeBottomHeight (KScreen_Height  >= 812.0 ? 20 : 0)
#define KBottom_SafeHeight   (Kis_IPhoneX ? (34.0):(0))

/////////////////////////////////////////////////////////////////////////////////
//
//                             颜色和字体
//
/////////////////////////////////////////////////////////////////////////////////
#define KRGBA(r, g, b, a)    [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define KRGB(r, g, b)    [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.f]
// 设置浅色模式十六进制颜色和十六进制深色模式颜色 如：kColorWithLightAndDarkHexStr(@"#ffffff", @"#1d1d1d")
#define kColorWithLightAndDarkHexStr(arg1, arg2) [UIColor LKColorWithLightHex:arg1 darkHex:arg2]

#define kColorRandom [UIColor LKRandomColor]

#pragma mark - 字体
#define kFontDINAlternateBold(float) [UIFont fontWithName:@"DINAlternate-Bold" size:float]
#define kFont(float)         [UIFont fontWithName:@"PingFangSC-Regular" size:float]
#define kFontMedium(float)   [UIFont fontWithName:@"PingFangSC-Medium" size:float]
#define kFontBold(float)     [UIFont fontWithName:@"PingFangSC-Bold" size:float]
#define kFontSemibold(float) [UIFont fontWithName:@"PingFangSC-Semibold" size:float]

#pragma mark - 自适应字体

#define kFitFontPingFangSCRegular(arg) [UIFont fontWithName:@"PingFangSC-Regular" size:(arg * KScreen_Width/375.0)]
#define kFitFontPingFangSCMedium(arg)  [UIFont fontWithName:@"PingFangSC-Medium" size:(arg *   KScreen_Width/375.0)]
#define kFitFontPingFangSemibold(arg)  [UIFont fontWithName:@"PingFangSC-Semibold" size:(arg * KScreen_Width/375.0)]

/////////////////////////////////////////////////////////////////////////////////
//
//                             weakObj&strongObj
//
/////////////////////////////////////////////////////////////////////////////////
#ifndef weakObj
    #if __has_feature(objc_arc)
        #define weakObj(object)  __weak __typeof__(object) weak##_##object = object;
    #else
        #define weakObj(object)  __block __typeof__(object) block##_##object = object;
    #endif
#endif

#ifndef strongObj
    #if __has_feature(objc_arc)
        #define strongObj(object)  __typeof__(object) object = weak##_##object; if(!object) return;
    #else
        #define strongObj(object)  __typeof__(object) object = block##_##object; if(!object) return;
    #endif
#endif

#endif /* LKMacroDefine_h */
