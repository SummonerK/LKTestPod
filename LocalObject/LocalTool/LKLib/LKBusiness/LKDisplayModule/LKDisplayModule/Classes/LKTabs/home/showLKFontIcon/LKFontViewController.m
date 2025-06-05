//
//  LKFontViewController.m
//  LKDisplayModule
//
//  Created by lofi on 2024/10/11.
//

#import "LKFontViewController.h"
#import <Masonry/Masonry.h>
#import <LKUtils/LKMacroDefine.h>
#import <LKIconFontKit/LKFont.h>

#import "LKDisplayHelper.h"
#import "testBackManager.h"

@interface LKFontViewController ()

@property(nonatomic, strong) UIButton *btonChange;
@property(nonatomic, strong) UIButton *btonNext;
@property(nonatomic, strong) UIImageView *imageViewIcon;
@property(nonatomic, strong) UILabel *labelTips; //tips label

@property(nonatomic, strong) testBackManager *authMgr;

@end

@implementation LKFontViewController

- (void)dealloc {
    NSLog(@"LKFontViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.authMgr = [testBackManager new];
    
    [self.view addSubview:self.imageViewIcon];
    [self.imageViewIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(110);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(350);
        make.height.mas_equalTo(350);
    }];
    
    [self.view addSubview:self.labelTips];
    [self.labelTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageViewIcon.mas_bottom).offset(40);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(190);
    }];
    
    [self.view addSubview:self.btonChange];
    [self.btonChange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-50-KSafeBottomHeight);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(KScreen_Width-40, 54));
    }];
    
    [self.view addSubview:self.btonNext];
    [self.btonNext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-50-KSafeBottomHeight-60);
        make.left.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(80, 54));
    }];
    
    NSLog(@"bundlePath = %@",[[NSBundle mainBundle] bundlePath]);
}

- (void)playButtonClick:(id)sender{
    LKFont * lkfont = [LKFont LKFontwechatWithSize:300];
    [lkfont addAttribute:NSForegroundColorAttributeName value:kColorRandom];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.imageViewIcon.image = [lkfont imageWithSize:CGSizeMake(350, 350)];
    }];
    
    weakObj(self)
    [self.authMgr realAuthCompleteBlock:^(XMRealAuthCode authCode) {
        strongObj(self)
        NSLog(@"接口回调");
        
        if (self) {
            NSLog(@"VC 是否还在");
        }
    }];
}

- (void)btonNextClick:(id)sender{
    LKFontViewController* vc = [LKFontViewController new];
    [self presentViewController:vc animated:YES completion:nil];
}

- (UIButton *)btonNext {
    if (!_btonNext) {
        _btonNext = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btonNext setTitle:@"Next" forState:UIControlStateNormal];
        [_btonNext addTarget:self action:@selector(btonNextClick:) forControlEvents:UIControlEventTouchUpInside];
        _btonNext.backgroundColor = kColorRandom;
    }
    
    return _btonNext;
}

- (UIButton *)btonChange {
    if (!_btonChange) {
        _btonChange = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btonChange setTitle:@"镜花水月" forState:UIControlStateNormal];
        [_btonChange addTarget:self action:@selector(playButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _btonChange.backgroundColor = kColorRandom;
    }
    
    return _btonChange;
}

- (UIImageView *)imageViewIcon {
    if (!_imageViewIcon) {
        _imageViewIcon = [UIImageView new];
        LKFont * lkfont = [LKFont LKFontwechatWithSize:350];
        [lkfont addAttribute:NSForegroundColorAttributeName value:kColorRandom];
        _imageViewIcon.image = [lkfont imageWithSize:CGSizeMake(350, 350)];
    }
    
    return _imageViewIcon;
}

- (UILabel *)labelTips {
    if (!_labelTips) {
        _labelTips = [UILabel new];
        LKFont * lkfont = [LKFont LKFontweibiaotiWithSize:40];
        [lkfont addAttribute:NSForegroundColorAttributeName value:[UIColor redColor]];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.firstLineHeadIndent = 10;//首行缩进
        [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
        paragraphStyle.alignment = NSTextAlignmentJustified;
        [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
        
        NSAttributedString *titleText = [[NSAttributedString alloc] initWithString:@"热销折扣-60%" attributes:@{
            NSFontAttributeName: kFont(15),
            NSForegroundColorAttributeName: [UIColor redColor],
            NSParagraphStyleAttributeName: paragraphStyle
        }];
        NSMutableAttributedString * textAtt = [[NSMutableAttributedString alloc] initWithAttributedString:lkfont.attributedString];
        [textAtt appendAttributedString:titleText];
        [textAtt addAttribute:NSBaselineOffsetAttributeName value:@(0.36*(40-15)) range:NSMakeRange(1, titleText.length)];
        
        _labelTips.backgroundColor = kColorRandomWithAlpha(0.1);
        _labelTips.attributedText = [textAtt copy];
        _labelTips.layer.cornerRadius = 10;
        _labelTips.layer.masksToBounds = YES;
    }
    return _labelTips;
}

@end
