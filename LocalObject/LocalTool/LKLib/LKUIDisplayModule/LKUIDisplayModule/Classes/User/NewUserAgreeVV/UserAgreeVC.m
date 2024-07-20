//
//  UserAgreeVC.m
//  LKUIDisplayModule
//
//  Created by lofi on 2024/7/20.
//

#import "UserAgreeVC.h"
#import <LKUtils/LKMacroDefine.h>
#import <Masonry/Masonry.h>
#import <LKUtils/UIColor+LKExt.h>
#import <YYText/YYLabel.h>
#import <YYText/NSAttributedString+YYText.h>


@interface UserAgreeVC ()<UITextViewDelegate>
///用户协议Label
@property (nonatomic, strong) YYLabel *labelAgreeText;

///用户协议TextView
@property (nonatomic, strong) UITextView *textViewShowAgreeText;
@end

@implementation UserAgreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor LKColorWithLightHex:@"#f2f2f2" darkHex:@"#f2f2f2"];
    self.view.backgroundColor = kColorWithLightAndDarkHexStr(@"#f2f2f2", @"#f2f2f2");
    [self setUpUI];
}

- (void)setUpUI {
    
    [self setupYYLabel];
}

- (void)setupYYLabel {
    [self.view addSubview:self.labelAgreeText];
    [self.labelAgreeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.mas_equalTo(-80);
        make.width.mas_equalTo(KScreen_Width/375*300);
        make.height.mas_equalTo(100);
    }];
    [self agreementSetupLabelHandle];
}

- (void)setupTextView {
    [self.view addSubview:self.textViewShowAgreeText];
    [self.textViewShowAgreeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.mas_equalTo(-80);
        make.width.mas_equalTo(KScreen_Width/375*300);
        make.height.mas_equalTo(88);
    }];
    [self agreementSetupHandle];
}

- (void)agreementSetupHandle {
    NSString *agreementMessage = self.textViewShowAgreeText.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:agreementMessage];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"serviceagreement"
                             range:[[attributedString string] rangeOfString:@"《俄语阅读用户服务协议》"]];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KScreen_Width/375*13] range:[[attributedString string] rangeOfString:agreementMessage]];
    [attributedString addAttribute:NSForegroundColorAttributeName value:KRGBA(142, 142, 142, 1) range:[[attributedString string] rangeOfString:agreementMessage]];
    self.textViewShowAgreeText.linkTextAttributes = @{ NSForegroundColorAttributeName: [UIColor blueColor],
                                                  NSUnderlineColorAttributeName:[UIColor clearColor],
                                                  NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    // 设置间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:[[attributedString string] rangeOfString:agreementMessage]];

    self.textViewShowAgreeText.attributedText = attributedString;
}

/// 设置YYLabel 展示内容
- (void)agreementSetupLabelHandle {
    NSString * stringContent = @"我已阅读并同意《俄语阅读用户服务协议》";
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:stringContent];
    NSString *highlightStr = @"《俄语阅读用户服务协议》";
    NSArray *array = [self findAllOccurrences:highlightStr inParentString:stringContent];
    YYTextBorder *border = [YYTextBorder borderWithFillColor:[UIColor LKColorWithLightHex:@"#f8f8f8" darkHex:@"f8f8f8"] cornerRadius:3];
    YYTextHighlight *highlight = [YYTextHighlight highlightWithBackgroundColor:[UIColor greenColor]];
    [highlight setColor:[UIColor orangeColor]];
    [highlight setBackgroundBorder:border];
    for (NSInteger i = 0; i < array.count; i++) {
        NSValue *value = array[i];
        // 2. 把"高亮"属性设置到某个文本范围
        [text yy_setTextHighlight:highlight range:value.rangeValue];
        [text yy_setColor:[UIColor blueColor] range:value.rangeValue];
        highlight.tapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            NSLog(@"textTapAction");
            NSLog(@"%@",highlightStr);
        };
    }
    
    self.labelAgreeText.attributedText = text;
}

- (NSArray<NSValue *> *)findAllOccurrences:(NSString*)findStr inParentString:(NSString*)parentStr{
    NSMutableArray<NSValue *> *ranges = [NSMutableArray array];
    NSRange searchRange = NSMakeRange(0, parentStr.length);
    while (searchRange.location != NSNotFound) {
        searchRange = [parentStr rangeOfString:findStr options:0 range:searchRange];
        if (searchRange.location != NSNotFound) {
            [ranges addObject:[NSValue valueWithRange:searchRange]];
            // 更新搜索范围以跳过当前匹配项
            searchRange.location = searchRange.location + searchRange.length;
            searchRange.length = parentStr.length - searchRange.location;
        }
    }
    return [ranges copy];
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    if ([URL.absoluteString  isEqualToString:@"serviceagreement"]) {
        NSLog(@"前往协议定义页面");
    }
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return NO;
}

- (UITextView *)textViewShowAgreeText {
    if (!_textViewShowAgreeText) {
        _textViewShowAgreeText = [[UITextView alloc] init];
        _textViewShowAgreeText.text = @"我已阅读并同意《俄语阅读用户服务协议》";
        _textViewShowAgreeText.backgroundColor = [UIColor clearColor];
        _textViewShowAgreeText.textColor = KRGBA(142, 142, 142, 1);
        _textViewShowAgreeText.textAlignment = NSTextAlignmentCenter;
        _textViewShowAgreeText.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _textViewShowAgreeText.font = [UIFont systemFontOfSize:[UIScreen mainScreen].bounds.size.width/375*13 weight:UIFontWeightRegular];
        _textViewShowAgreeText.showsVerticalScrollIndicator = NO;
        _textViewShowAgreeText.scrollEnabled = NO;
        _textViewShowAgreeText.editable = NO;
        _textViewShowAgreeText.delegate = self;
        _textViewShowAgreeText.linkTextAttributes = @{};
    }
    
    return _textViewShowAgreeText;
}

- (YYLabel *)labelAgreeText {
    if (!_labelAgreeText) {
        _labelAgreeText = [[YYLabel alloc] init];
        _labelAgreeText.numberOfLines = 0;
        _labelAgreeText.textAlignment = UITextAlignmentCenter;
        _labelAgreeText.preferredMaxLayoutWidth = KScreen_Width/375*300;
    }
    
    return _labelAgreeText;
}

@end
