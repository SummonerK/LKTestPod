//
//  PageListModel.m
//  LKDisplayModule
//
//  Created by lofi on 2024/7/23.
//

#import "PageListModel.h"

@implementation PageListModel

@end

@interface Item()
@property (nonatomic, strong) UIViewController *vc;
@end

@implementation Item
- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle vc:(UIViewController *)vc{
    self = [super init];
    if ( !self ) return nil;
    _title = title;
    _subTitle = subTitle;
    _vc = vc;
    return self;
}
@end

@implementation Section
- (instancetype)initWithTitle:(NSString *)title items:(NSArray<Item *> *)items {
    self = [super init];
    if ( self ) {
        _title = title;
        _items = items;
    }
    return self;
}
@end
