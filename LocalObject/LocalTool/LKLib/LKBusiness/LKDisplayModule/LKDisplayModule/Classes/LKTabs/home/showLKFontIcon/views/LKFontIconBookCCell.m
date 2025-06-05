//
//  LKFontIconBookCCell.m
//  LKDisplayModule
//
//  Created by lofi on 2024/10/11.
//

#import "LKFontIconBookCCell.h"

#import <Masonry/Masonry.h>
#import <LKUtils/LKMacroDefine.h>
#import <LKIconFontKit/LKFont.h>

@interface LKFontIconBookCCell ()

@property(nonatomic, strong) UIImageView *imageViewHeader;  // 头像
@property(nonatomic, strong) UILabel *labelTips;          //说明

@end

@implementation LKFontIconBookCCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.backgroundColor                 = kColorRandomWithAlpha(0.2);
    [self.contentView addSubview:self.imageViewHeader];
    [self.imageViewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.contentView addSubview:self.labelTips];
    [self.labelTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageViewHeader.mas_bottom).offset(8);
        make.bottom.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
    }];
}

- (void)setIconKey:(NSString *)iconKey {
    _iconKey = iconKey;
    
    NSString * value = [LKFont.allIcons valueForKey:_iconKey];
    LKFont * lkfont = [LKFont iconWithCode:value size:50];
    self.imageViewHeader.image = [lkfont imageWithSize:CGSizeMake(50, 50)];
    self.labelTips.text = _iconKey;
}

#pragma mark - getter&setter

- (UIImageView *)imageViewHeader {
    if (!_imageViewHeader) {
        _imageViewHeader                 = [UIImageView new];
        _imageViewHeader.contentMode     = UIViewContentModeScaleAspectFill;
        _imageViewHeader.backgroundColor = [UIColor whiteColor];
    }
    return _imageViewHeader;
}

- (UILabel *)labelTips {
    if (!_labelTips) {
        _labelTips = [UILabel new];
        _labelTips.font = kFont(11);
        _labelTips.numberOfLines = 0;
        _labelTips.textAlignment = NSTextAlignmentCenter;
    }
    return _labelTips;
}

@end
