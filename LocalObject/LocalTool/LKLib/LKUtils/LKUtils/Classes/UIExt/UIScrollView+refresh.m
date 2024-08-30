//
//  UIScrollView+refresh.m
//  LKUtils
//
//  Created by lofi on 2024/8/1.
//

#import "UIScrollView+refresh.h"
#import "LkStateNoneFooter.h"

@implementation UIScrollView (refresh)

- (void)xm_headerRefreshWithActionBlock:(MJRefreshComponentAction)refreshingBlock {
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:refreshingBlock];
}

- (void)xm_footerRefreshWithActionBlock:(MJRefreshComponentAction)refreshingBlock {
    self.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:refreshingBlock];
}
/// 注册下拉刷新事件
- (void)xm_footerRefreshNoneWithActionBlock:(MJRefreshComponentAction)refreshingBlock{
    self.mj_footer = [LkStateNoneFooter footerWithRefreshingBlock:refreshingBlock];
}

- (void)endFooterRefreshing{
    [self.mj_footer endRefreshing];
}

- (void)endHeaderRefreshing {
    [self.mj_header endRefreshing];
}

- (void)beginHeaderRefreshing {
    [self.mj_header beginRefreshing];
}

- (void)beginFooterRefreshing {
    [self.mj_footer beginRefreshing];
}

- (void)endRefreshingWithNoMoreData {
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)resetNoMoreData {
    [self.mj_footer resetNoMoreData];
}

@end
