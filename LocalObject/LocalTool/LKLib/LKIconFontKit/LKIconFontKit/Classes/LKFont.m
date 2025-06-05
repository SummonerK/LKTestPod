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
             @"LKFontweibiaoti1" : @"\ue60e",
             @"LKFontxuanzhong" : @"\ue637",
             @"LKFontshenheshibai" : @"\ue602",
             @"LKFontshenhetongguo" : @"\ue60b",
             @"LKFontbhjshenhezhong" : @"\ue60d",
             @"LKFontbhjdaishenhe" : @"\ue60f",
             @"LKFontbhjshenhetongguo" : @"\ue612",
             @"LKFontshenhe" : @"\ue603",
             @"LKFontdaohangtuangou" : @"\ue613",
             @"LKFontfanhui" : @"\ue60a",
             @"LKFonttangshi" : @"\ue606",
             @"LKFontwaidai" : @"\ue625",
             @"LKFontyixiangkan" : @"\ue8bf",
             @"LKFontWIFI" : @"\ue8c1",
             @"LKFontDaytimemode" : @"\ue771",
             @"LKFontnightmode" : @"\ue773",
             @"LKFontcangku" : @"\ue7c1",
             @"LKFontdaohang" : @"\ue640",
             @"LKFontphone" : @"\ue787",
             @"LKFontstorefill" : @"\ue78d",
             @"LKFontditu" : @"\ue62a",
             @"LKFontchenggong" : @"\ue609",
             @"LKFontyuandianda" : @"\ue82e",
             @"LKFontcopy" : @"\ue66a",
             @"LKFontbianji" : @"\ue8ac",
             @"LKFontshuye":@"\ue605",
             @"LKFontwushuju":@"\ue6a1",
             @"LKFontdingweicopy15":@"\ue66e",
             @"LKFontdingweiweizhi":@"\ue824",
             @"LKFontround":@"\ue6d7",
             @"LKFontsearch":@"\ue608",
             @"LKFontwechatpay":@"\ue6ba",
             @"LKFontwechat":@"\ue6bb",
             @"LKFontdish1":@"\ue669",
             @"LKFontrefreshleft":@"\ue673",
             @"LKFontremoveoutline":@"\ue674",
             @"LKFontwarningoutline":@"\ue682",
             @"LKFontcircleplusoutline":@"\ue664",
             @"LKFontcircleplus":@"\ue667",
             @"LKFonterror":@"\ue668",
             @"LKFontremove":@"\ue679",
             @"LKFontsuccess":@"\ue67e",
             @"LKFontwarning":@"\ue681",
             @"LKFontcaretforward":@"\ue98c",
             @"LKFonthm_announcement_light":@"\ue611",
             @"LKFonthm_arrow_left_light":@"\ue614",
             @"LKFonthm_arrow_right_light":@"\ue616",
             @"LKFonthm_arrow_lower_light":@"\ue617",
             @"LKFonthm_arrow_up_light":@"\ue618",
             @"LKFonthm_close_light":@"\ue619",
             @"LKFonthm_add_light":@"\ue61b",
             @"LKFonthm_subtract_light":@"\ue61c",
             @"LKFonthm_card_light":@"\ue61d",
             @"LKFonthm_purse_light":@"\ue61e",
             @"LKFonthm_question_light":@"\ue61f",
             @"LKFonthm_coupon_light":@"\ue623",
             @"LKFonthm_delete_light":@"\ue624",
             @"LKFonthm_vipcard_light":@"\ue627",
             @"LKFonthm_more_light":@"\ue628",
             @"LKFonthm_othermore_light":@"\ue629",
             @"LKFonthm_link_light":@"\ue632",
             @"LKFontstop_ringing":@"\ue604",
             @"LKFontgouwuche7":@"\ue610",
             @"LKFontwaimaixianxing20":@"\ue686",
             @"LKFontwode":@"\ue62c",
             @"LKFontzhuye":@"\ue62d",
             @"LKFontjiaoxuezhongxin":@"\ue62e",
             @"LKFontwodefill":@"\ue62f",
             @"LKFontzhuyefill":@"\ue630",
             @"LKFontjiaoxuezhongxinfill":@"\ue631",
             @"LKFontqian1":@"\ue6de",
             @"LKFontchupiao":@"\ue634",
             @"LKFontyisongda":@"\ue6d5",
             @"LKFonterweima":@"\ue607",
             @"LKFontqian":@"\ue601",
             @"LKFonthanbao":@"\ue6bc",
             @"LKFontmbile":@"\ue9ce",
    };
}

+ (instancetype)LKFontWithKey:(NSString*)key Size:(CGFloat)size{
    if (!key || key.length == 0) {
        return [self LKFontyuandiandaWithSize:size];
    }
    NSString * value = [self.allIcons valueForKey:key];
    if (!value || value.length == 0) {
        return [self LKFontyuandiandaWithSize:size];
    }
    LKFont * lkfont = [self iconWithCode:value size:size];
    return lkfont;
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
