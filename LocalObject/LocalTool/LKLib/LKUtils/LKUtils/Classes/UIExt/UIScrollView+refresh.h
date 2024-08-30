//
//  UIScrollView+refresh.h
//  LKUtils
//
//  Created by lofi on 2024/8/1.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (refresh)
/// 注册下拉刷新事件
- (void)xm_headerRefreshWithActionBlock:(MJRefreshComponentAction)refreshingBlock;

/// 注册下拉刷新事件
- (void)xm_footerRefreshWithActionBlock:(MJRefreshComponentAction)refreshingBlock;

/// 注册下拉刷新事件
- (void)xm_footerRefreshNoneWithActionBlock:(MJRefreshComponentAction)refreshingBlock;

/// 结束上拉刷新
- (void)endFooterRefreshing;

/// 结束下拉刷新
- (void)endHeaderRefreshing;

/// 开始下拉刷新
- (void)beginHeaderRefreshing;

/// 开始上拉刷新
- (void)beginFooterRefreshing;

/// 结束刷新且没有更多数据
- (void)endRefreshingWithNoMoreData;

/// 重置没有更多数据状态
- (void)resetNoMoreData;

@end

NS_ASSUME_NONNULL_END
