//
//  LKBannerView.h
//  LKDisplayModule
//
//  Created by lofi on 2024/11/6.
//

#import <SDCycleScrollView/SDCycleScrollView.h>

NS_ASSUME_NONNULL_BEGIN

@interface LKBannerView : SDCycleScrollView

/** 两个点之间的间距*/
@property(nonatomic, assign) CGFloat spacingBetweenDots;

@end

NS_ASSUME_NONNULL_END
