//
//  LKBannerView.m
//  LKDisplayModule
//
//  Created by lofi on 2024/11/6.
//

#import "LKBannerView.h"
#import <SDCycleScrollView/TAPageControl.h>

@implementation LKBannerView

- (void)setSpacingBetweenDots:(CGFloat)spacingBetweenDots {
    _spacingBetweenDots    = spacingBetweenDots;
    UIControl *pageControl = [self valueForKey:@"pageControl"];
    if ([pageControl isKindOfClass:[TAPageControl class]]) {
        ((TAPageControl *)pageControl).spacingBetweenDots = spacingBetweenDots;
    }
}

@end
