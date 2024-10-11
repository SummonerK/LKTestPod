//
//  IBMainTabVC.m
//  LKDisplayModule
//
//  Created by lofi on 2024/7/23.
//

#import "IBMainTabVC.h"
#import <LKUtils/UIColor+LKExt.h>

@interface IBMainTabVC ()

@end

@implementation IBMainTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.backgroundColor = [UIColor LKColorWithLightHex:@"#FFFFFF" darkHex:@"#FFFFFF"];
    self.tabBar.backgroundImage = [UIImage new];
    self.tabBar.tintColor = [UIColor blueColor];
    self.tabBar.barTintColor = [UIColor blueColor];
    self.tabBar.unselectedItemTintColor = [UIColor LKColorWithLightHex:@"#e5e5e5" darkHex:@"#e5e5e5"];
    self.tabBar.shadowImage = [UIImage new];
    
    // Do any additional setup after loading the view.
}

- (void)setArrayTabItems:(NSArray<LKTabBarItem *> *)arrayTabItems{
    _arrayTabItems = arrayTabItems;
    //tab bar items
    NSMutableArray *controllers = [NSMutableArray array];
    int index = 0;
    for (LKTabBarItem *item in _arrayTabItems) {
        UITabBarItem *tabItem = [[UITabBarItem alloc] initWithTitle:item.title image:[item.normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[item.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        tabItem.tag = index;
        item.controller.tabBarItem = tabItem;
        [item.controller.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -4)];
        [item.controller.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10 weight:UIFontWeightRegular], NSFontAttributeName, nil] forState:UIControlStateNormal];
        
        [controllers addObject:item.controller];
        index++;
    }
    self.viewControllers = controllers;
}

@end
