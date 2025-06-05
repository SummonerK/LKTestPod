//
//  showBannerVC.m
//  LKDisplayModule
//
//  Created by lofi on 2024/11/6.
//

#import "showBannerVC.h"

#import <Masonry/Masonry.h>
#import <LKUtils/LKMacroDefine.h>
#import <LKIconFontKit/LKFont.h>

#import "LKBannerView.h"

@interface showBannerVC () <SDCycleScrollViewDelegate>

/** 轮播控件*/
@property(nonatomic, strong) LKBannerView *cycleScrollView;

@end

@implementation showBannerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    [self layoutViews];
    [self updateViews];
}

- (void)initViews {
    [self.view addSubview:self.cycleScrollView];
}

- (void)layoutViews {
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(300);
    }];
}
//https://img2.baidu.com/it/u=1463517774,3231270220&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=1104
//http://img2.baidu.com/it/u=355234538,247195152&fm=253&app=138&f=JPEG?w=800&h=1104
//http://img2.baidu.com/it/u=1201395687,2619217481&fm=253&app=138&f=JPEG?w=800&h=1104

//https://img1.baidu.com/it/u=733418214,3903491350&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=313
//https://img0.baidu.com/it/u=3383915175,3938514169&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500
//https://img0.baidu.com/it/u=3447383648,1039898475&fm=253&fmt=auto&app=120&f=JPEG?w=1422&h=800
- (void)updateViews {
    NSMutableArray *images = [@[] mutableCopy];
    [images addObject:@"https://img1.baidu.com/it/u=733418214,3903491350&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=313"];
    [images addObject:@"https://img0.baidu.com/it/u=3383915175,3938514169&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500"];
    [images addObject:@"https://img0.baidu.com/it/u=3447383648,1039898475&fm=253&fmt=auto&app=120&f=JPEG?w=1422&h=800"];
    _cycleScrollView.imageURLStringsGroup = images.copy;
    _cycleScrollView.spacingBetweenDots   = 2;
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}
#pragma mark - Getter

- (LKBannerView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView                         = [LKBannerView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
        _cycleScrollView.backgroundColor         = [UIColor clearColor];
        _cycleScrollView.autoScrollTimeInterval  = 3.0;
        _cycleScrollView.contentMode             = UIViewContentModeScaleAspectFill;
        _cycleScrollView.showPageControl         = YES;
        _cycleScrollView.hidesForSinglePage      = YES;
        _cycleScrollView.pageControlDotSize      = CGSizeMake(12, 12);
        LKFont * lkfont = [LKFont LKFontyuandiandaWithSize:10];
        [lkfont addAttribute:NSForegroundColorAttributeName value:[UIColor LKColorWithHex:@"999999"]];
        UIImage * imageDefault = [lkfont imageWithSize:CGSizeMake(12, 12)];
        LKFont * lkfont_select = [LKFont LKFontyuandiandaWithSize:11];
        [lkfont_select addAttribute:NSForegroundColorAttributeName value:[UIColor LKColorWithHex:@"ffffff"]];
        UIImage * imageSelect = [lkfont_select imageWithSize:CGSizeMake(12, 12)];
        _cycleScrollView.pageDotImage            = imageDefault;
        _cycleScrollView.currentPageDotImage     = imageSelect;
        _cycleScrollView.pageControlBottomOffset = -2;
    }
    return _cycleScrollView;
}


@end
