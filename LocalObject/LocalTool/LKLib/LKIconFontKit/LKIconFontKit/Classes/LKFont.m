//
//  LKFont.m
//  LKIconFontKit
//
//  Created by lofi on 2024/10/11.
//

#import "LKFont.h"

@implementation LKFont

+ (UIFont *)iconFontWithSize:(CGFloat)size
{
#ifndef DISABLE_FONTAWESOME_AUTO_REGISTRATION
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"LKIconFontKit" withExtension:@"bundle"];
        if (!bundleURL) {
            return;
        }
        NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];
        NSURL * sourceUrl = [[bundle resourceURL] URLByAppendingPathComponent:@"iconfont.ttf"];
        [self registerIconFontWithURL: sourceUrl];
    });
#endif
    
    UIFont *font = [UIFont fontWithName:@"iconfont" size:size];
    NSAssert(font, @"UIFont object should not be nil, check if the font file is added to the application bundle and you're using the correct font name.");
    return font;
}

+ (NSDictionary *)allIcons {
    return @{
             @"icon-weibiaoti1" : @"\ue60e",
             @"icon-xuanzhong" : @"\ue637",
             @"icon-shenheshibai" : @"\ue602",
             @"icon-shenhetongguo" : @"\ue60b",
             @"icon-bhjshenhezhong" : @"\ue60d",
             @"icon-bhjdaishenhe" : @"\ue60f",
             @"icon-bhjshenhetongguo" : @"\ue612",
             @"icon-shenhe" : @"\ue603",
             @"icon-daohangtuangou" : @"\ue613",
             @"icon-fanhui" : @"\ue60a",
             @"icon-tangshi-" : @"\ue606",
             @"icon-waidai" : @"\ue625",
             @"icon-yixiangkan" : @"\ue8bf",
             @"icon-WIFI" : @"\ue8c1",
             @"icon-Daytimemode" : @"\ue771",
             @"icon-nightmode" : @"\ue773",
             @"icon-cangku" : @"\ue7c1",
             @"icon-daohang" : @"\ue640",
             @"icon-phone" : @"\ue787",
             @"icon-store-fill" : @"\ue78d",
             @"icon-ditu" : @"\ue62a",
             @"icon-chenggong" : @"\ue609",
             @"icon-yuandianda" : @"\ue82e",
             @"icon-copy" : @"\ue66a",
             @"icon-bianji" : @"\ue8ac",
             @"icon-shuye":@"\ue605",
             @"icon-wushuju":@"\ue6a1",
             @"icon-dingweicopy15":@"\ue66e",
             @"icon-dingweiweizhi":@"\ue824",
             @"icon-round":@"\ue6d7",
             @"icon-search":@"\ue608",
             @"icon-wechat-pay":@"\ue6ba",
             @"icon-wechat":@"\ue6bb",
             @"icon-dish-1":@"\ue669",
             @"icon-refresh-left":@"\ue673",
             @"icon-remove-outline":@"\ue674",
             @"icon-warning-outline":@"\ue682",
             @"icon-circle-plus-outline":@"\ue664",
             @"icon-circle-plus":@"\ue667",
             @"icon-error":@"\ue668",
             @"icon-remove":@"\ue679",
             @"icon-success":@"\ue67e",
             @"icon-warning":@"\ue681",
             @"icon-caret-forward":@"\ue98c",
             @"icon-hm_announcement_light":@"\ue611",
             @"icon-hm_arrow_left_light":@"\ue614",
             @"icon-hm_arrow_right_light":@"\ue616",
             @"icon-hm_arrow_lower_light":@"\ue617",
             @"icon-hm_arrow_up_light":@"\ue618",
             @"icon-hm_close_light":@"\ue619",
             @"icon-hm_add_light":@"\ue61b",
             @"icon-hm_subtract_light":@"\ue61c",
             @"icon-hm_card_light":@"\ue61d",
             @"icon-hm_purse_light":@"\ue61e",
             @"icon-hm_question_light":@"\ue61f",
             @"icon-hm_coupon_light":@"\ue623",
             @"icon-hm_delete_light":@"\ue624",
             @"icon-hm_vipcard_light":@"\ue627",
             @"icon-hm_more_light":@"\ue628",
             @"icon-hm_othermore_light":@"\ue629",
             @"icon-hm_link_light":@"\ue632",
             @"icon-stop_ringing":@"\ue604",
             @"icon-gouwuche7":@"\ue610",
             @"icon-waimai-xianxing2-0":@"\ue686",
             @"icon-wode":@"\ue62c",
             @"icon-zhuye":@"\ue62d",
             @"icon-jiaoxuezhongxin":@"\ue62e",
             @"icon-wodefill":@"\ue62f",
             @"icon-zhuyefill":@"\ue630",
             @"icon-jiaoxuezhongxinfill":@"\ue631",
             @"icon-qian1":@"\ue6de",
             @"icon-chupiao":@"\ue634",
             @"icon-yisongda":@"\ue6d5",
             @"icon-erweima":@"\ue607",
             @"icon-qian":@"\ue601",
             @"icon-hanbao":@"\ue6bc",
             @"icon-mbile":@"\ue9ce",
    };
}

+ (instancetype)LKFontweibiaotiWithSize:(CGFloat)size {
    return [self iconWithCode:@"\ue60e" size:size];
}

+ (instancetype)LKFontxuanzhongWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue637" size:size];
}

+ (instancetype)LKFontshenheshibaiWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue602" size:size];
}

+ (instancetype)LKFontshenhetongguoWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue60b" size:size];
}

+ (instancetype)LKFontbhjshenhezhongWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue60d" size:size];
}

+ (instancetype)LKFontbhjdaishenheWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue60f" size:size];
}

+ (instancetype)LKFontbhjshenhetongguoWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue612" size:size];
}

+ (instancetype)LKFontshenheWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue603" size:size];
}

+ (instancetype)LKFontdaohangtuangouWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue613" size:size];
}

+ (instancetype)LKFontfanhuiWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue60a" size:size];
}

+ (instancetype)LKFonttangshiWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue606" size:size];
}

+ (instancetype)LKFontwaidaiWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue625" size:size];
}

+ (instancetype)LKFontyixiangkanWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue8bf" size:size];
}

+ (instancetype)LKFontWIFIWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue8c1" size:size];
}

+ (instancetype)LKFontDaytimemodeWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue771" size:size];
}

+ (instancetype)LKFontnightmodeWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue773" size:size];
}

+ (instancetype)LKFontcangkuWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue7c1" size:size];
}

+ (instancetype)LKFontdaohangWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue640" size:size];
}

+ (instancetype)LKFontphoneWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue787" size:size];
}

+ (instancetype)LKFontstorefillWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue78d" size:size];
}

+ (instancetype)LKFontdituWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue62a" size:size];
}

+ (instancetype)LKFontchenggongWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue609" size:size];
}

+ (instancetype)LKFontyuandiandaWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue82e" size:size];
}

+ (instancetype)LKFontcopyWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue66a" size:size];
}

+ (instancetype)LKFontbianjiWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue8ac" size:size];
}

+ (instancetype)LKFontshuyeWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue605" size:size];
}

+ (instancetype)LKFontwushujuWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue6a1" size:size];
}

+ (instancetype)LKFontdingweicopy15WithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue66e" size:size];
}

+ (instancetype)LKFontdingweiweizhiWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue824" size:size];
}

+ (instancetype)LKFontroundWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue6d7" size:size];
}

+ (instancetype)LKFontsearchWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue608" size:size];
}

+ (instancetype)LKFontwechatpayWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue6ba" size:size];
}

+ (instancetype)LKFontwechatWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue6bb" size:size];
}

+ (instancetype)LKFontdish1WithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue669" size:size];
}

+ (instancetype)LKFontrefreshleftWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue673" size:size];
}

+ (instancetype)LKFontremoveoutlineWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue674" size:size];
}

+ (instancetype)LKFontwarningoutlineWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue682" size:size];
}

+ (instancetype)LKFontcircleplusoutlineWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue664" size:size];
}

+ (instancetype)LKFontcircleplusWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue667" size:size];
}

+ (instancetype)LKFonterrorWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue668" size:size];
}

+ (instancetype)LKFontremoveWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue679" size:size];
}

+ (instancetype)LKFontsuccessWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue67e" size:size];
}

+ (instancetype)LKFontwarningWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue681" size:size];
}

+ (instancetype)LKFontcaretforwardWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue98c" size:size];
}

+ (instancetype)LKFonthm_announcement_lightWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue611" size:size];
}

+ (instancetype)LKFonthm_arrow_left_lightWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue614" size:size];
}

+ (instancetype)LKFonthm_arrow_right_lightWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue616" size:size];
}

+ (instancetype)LKFonthm_arrow_lower_lightWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue617" size:size];
}

+ (instancetype)LKFonthm_arrow_up_lightWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue618" size:size];
}

+ (instancetype)LKFonthm_close_lightWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue619" size:size];
}

+ (instancetype)LKFonthm_add_lightWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue61b" size:size];
}

+ (instancetype)LKFonthm_subtract_lightWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue61c" size:size];
}

+ (instancetype)LKFonthm_card_lightWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue61d" size:size];
}

+ (instancetype)LKFonthm_purse_lightWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue61e" size:size];
}

+ (instancetype)LKFonthm_question_lightWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue61f" size:size];
}

+ (instancetype)LKFonthm_coupon_lightWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue623" size:size];
}

+ (instancetype)LKFonthm_delete_lightWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue624" size:size];
}

+ (instancetype)LKFonthm_vipcard_lightWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue627" size:size];
}

+ (instancetype)LKFonthm_more_lightWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue628" size:size];
}

+ (instancetype)LKFonthm_othermore_lightWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue629" size:size];
}

+ (instancetype)LKFonthm_link_lightWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue632" size:size];
}

+ (instancetype)LKFontstop_ringingWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue604" size:size];
}

+ (instancetype)LKFontgouwuche7WithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue610" size:size];
}

+ (instancetype)LKFontwaimaixianxing20WithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue686" size:size];
}

+ (instancetype)LKFontwodeWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue62c" size:size];
}

+ (instancetype)LKFontzhuyeWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue62d" size:size];
}

+ (instancetype)LKFontjiaoxuezhongxinWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue62e" size:size];
}

+ (instancetype)LKFontwodefillWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue62f" size:size];
}

+ (instancetype)LKFontzhuyefillWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue630" size:size];
}

+ (instancetype)LKFontjiaoxuezhongxinfillWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue631" size:size];
}

+ (instancetype)LKFontqian1WithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue6de" size:size];
}

+ (instancetype)LKFontchupiaoWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue634" size:size];
}

+ (instancetype)LKFontyisongdaWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue6d5" size:size];
}

+ (instancetype)LKFonterweimaWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue607" size:size];
}

+ (instancetype)LKFontqianWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue601" size:size];
}

+ (instancetype)LKFonthanbaoWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue6bc" size:size];
}

+ (instancetype)LKFontmbileWithSize:(CGFloat)size {
  return [self iconWithCode:@"\ue9ce" size:size];
}

@end
