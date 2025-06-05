//
//  showEditTCell.m
//  LKDisplayModule
//
//  Created by lofi on 2024/11/6.
//

#import "showEditTCell.h"

#import <Masonry/Masonry.h>
#import <LKUtils/LKMacroDefine.h>
#import <LKIconFontKit/LKFont.h>

@interface showEditTCell()

@property(nonatomic, strong) UIView *viewEdit;          ///<编辑View

@end

@implementation showEditTCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    self.backgroundColor = kColorWithLightAndDarkHexStr(@"#FFFFFF", @"#191919");
    self.contentView.backgroundColor = kColorRandom;
    
    [self.contentView addSubview:self.viewEdit];
    [self.viewEdit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(26, 26));
    }];
}

#pragma mark - Getter

- (UIView *)viewEdit {
    if (!_viewEdit) {
        _viewEdit = [UIView new];
        _viewEdit.backgroundColor = kColorRandom;
    }
    
    return _viewEdit;
}


@end
