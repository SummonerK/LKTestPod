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

@interface LKFontViewController ()

@property(nonatomic, strong) UIButton *btonChange;
@property(nonatomic, strong) UIImageView *imageViewIcon;
@property(nonatomic, strong) UILabel *labelTips; //tips label

@end

@implementation LKFontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.imageViewIcon];
    [self.imageViewIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(350);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(180);
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
}

- (void)playButtonClick:(id)sender{
    LKFont * lkfont = [LKFont LKFonthm_vipcard_lightWithSize:180];
    [lkfont addAttribute:NSForegroundColorAttributeName value:kColorRandom];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.imageViewIcon.image = [lkfont imageWithSize:CGSizeMake(180, 180)];
    }];
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
        LKFont * lkfont = [LKFont LKFonthm_vipcard_lightWithSize:180];
        [lkfont addAttribute:NSForegroundColorAttributeName value:kColorRandom];
        _imageViewIcon.image = [lkfont imageWithSize:CGSizeMake(180, 180)];
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
