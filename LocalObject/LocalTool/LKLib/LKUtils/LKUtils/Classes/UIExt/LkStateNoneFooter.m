//
//  LkStateNoneFooter.m
//  LKUtils
//
//  Created by lofi on 2024/8/1.
//

#import "LkStateNoneFooter.h"

@implementation LkStateNoneFooter

#pragma mark - 实现父类的方法
- (void)prepare {
    [super prepare];
}

- (void)placeSubviews{
    [super placeSubviews];
    
    self.stateLabel.hidden = YES;
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
    // 内容的高度
    CGFloat contentHeight = self.scrollView.mj_contentH + self.ignoredScrollViewContentInsetBottom;
    // 表格的高度
    CGFloat scrollHeight = self.scrollView.mj_h - self.scrollViewOriginalInset.top - self.scrollViewOriginalInset.bottom + self.ignoredScrollViewContentInsetBottom;
    // 设置位置和尺寸
    self.mj_y = MAX(contentHeight, scrollHeight);
}

@end

