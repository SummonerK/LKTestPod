//
//  IBTabVCConfig.m
//  LKDisplayModule
//
//  Created by lofi on 2024/7/23.
//

#import <LKUtils/LKBaseNaviController.h>

#import "IBTabVCConfig.h"
#import "tabHomeVC.h"
#import "tabUEVC.h"
#import "tabSafeVC.h"
#import "tabAnimationVC.h"

@implementation LKTabBarItem

@end

@implementation IBTabVCConfig

+ (nonnull NSMutableArray<LKTabBarItem *> *)tabItems {
    NSMutableArray<LKTabBarItem *> *itemArr = [[NSMutableArray alloc] init];
    IBTabVCConfig * config = [IBTabVCConfig new];
    NSArray<TabbarItemDataModel *> *itemDatas = [config itemDatas];
    [itemDatas enumerateObjectsUsingBlock:^(TabbarItemDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LKTabBarItem *item = [config tabbarItem:obj];
        [itemArr addObject:item];
    }];
    return itemArr.mutableCopy;
}

- (NSArray<TabbarItemDataModel *> *)itemDatas {
    NSMutableArray <TabbarItemDataModel *> *itemArr = [[NSMutableArray alloc] init];
    // 首页（会话列表）
    TabbarItemDataModel *home = [[TabbarItemDataModel alloc] init];
    home.title = @"home";
    home.selectedImage = @"1";
    home.normalImage = @"11";
    home.className = NSStringFromClass(tabHomeVC.class);
    home.badgeEnabled = YES;
    [itemArr addObject:home];
    // 频道
    TabbarItemDataModel *channel = [[TabbarItemDataModel alloc] init];
    channel.title = @"UE";
    channel.selectedImage = @"5";
    channel.normalImage = @"55";
    channel.badgeEnabled = YES;
    channel.className = NSStringFromClass(tabUEVC.class);
    [itemArr addObject:channel];
    
    // 通讯录
    TabbarItemDataModel *contact = [[TabbarItemDataModel alloc] init];
    contact.title = @"Safe";
    contact.selectedImage = @"2";
    contact.normalImage = @"22";
    contact.className = NSStringFromClass(tabSafeVC.class);
    contact.badgeEnabled = YES;
    [itemArr addObject:contact];
    
    // 个人中心
    TabbarItemDataModel *set = [[TabbarItemDataModel alloc] init];
    set.title = @"Anima";
    set.selectedImage = @"3";
    set.normalImage = @"33";
    set.className = NSStringFromClass(tabAnimationVC.class);
    [itemArr addObject:set];
    
    return itemArr.copy;
}

- (LKTabBarItem *)tabbarItem:(TabbarItemDataModel *)itemData {
    LKTabBarItem *item = [[LKTabBarItem alloc] init];
    item.title = itemData.title;
    item.selectedImage =  [UIImage imageNamed:itemData.selectedImage];
    item.normalImage = [UIImage imageNamed:itemData.normalImage];
    Class cls = NSClassFromString(itemData.className);
    id instance = [[cls alloc] init];
    if ([instance isKindOfClass:UIViewController.class]) {
        UIViewController *vc = (UIViewController *)instance;
        item.controller = [[LKBaseNaviController alloc] initWithRootViewController:vc];
    }
    return item;
}

@end

