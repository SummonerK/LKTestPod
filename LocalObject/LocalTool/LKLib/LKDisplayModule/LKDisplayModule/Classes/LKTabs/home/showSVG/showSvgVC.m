//
//  showSvgVC.m
//  LKDisplayModule
//
//  Created by lofi on 2024/8/29.
//

#import "showSvgVC.h"
#import <Masonry/Masonry.h>
#import <LKUtils/LKMacroDefine.h>
#import <LKGlobalization/LKGlobalization.h>

#import "LKSVGPlayer.h"

@interface showSvgVC ()

@property(nonatomic, strong) UIButton *btonPlayer;
@property(nonatomic, strong) UILabel *labelTips; //tips label

@end

@implementation showSvgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.btonPlayer];
    
    [self.btonPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(350);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
    
    [self.view addSubview:self.labelTips];
    
    [self.labelTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.btonPlayer.mas_bottom).offset(40);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(160);
    }];
}

- (void)playButtonClick:(id)sender{
    [LKSVGPlayer showSvgPlayerWithView:self.btonPlayer];
}

- (UIButton *)btonPlayer {
    if (!_btonPlayer) {
        _btonPlayer = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btonPlayer setTitle:@"镜花水月" forState:UIControlStateNormal];
        [_btonPlayer addTarget:self action:@selector(playButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _btonPlayer.backgroundColor = kColorRandom;
    }
    
    return _btonPlayer;
}

- (UILabel *)labelTips {
    if (!_labelTips) {
        _labelTips = [UILabel new];
        _labelTips.font = kFont(14);
        _labelTips.text = LKLocalizable(@"Confirm");
        _labelTips.backgroundColor = kColorRandom;
        _labelTips.layer.cornerRadius = 10;
        _labelTips.layer.masksToBounds = YES;
    }
    return _labelTips;
}

@end
