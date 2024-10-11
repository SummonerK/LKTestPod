//
//  LKBaseNaviController.m
//  CocoaAsyncSocket
//
//  Created by lofi on 2024/10/10.
//

#import "LKBaseNaviController.h"

#import "LKMacroDefine.h"

@interface LKBaseNaviController ()

@end

@implementation LKBaseNaviController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        self.interactivePopGestureRecognizer.delegate = self;
        self.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *appearance = [UINavigationBarAppearance new];
        [appearance configureWithDefaultBackground];
        appearance.shadowColor = nil;
        appearance.backgroundEffect = nil;
        appearance.backgroundColor =  self.tintColor;
        self.navigationBar.backgroundColor = self.tintColor;
        self.navigationBar.barTintColor = self.tintColor;
        self.navigationBar.shadowImage = [UIImage new];
        self.navigationBar.standardAppearance = appearance;
        //iOS15新增特性：滑动边界样式
        self.navigationBar.scrollEdgeAppearance = appearance;
    } else {
        self.navigationBar.backgroundColor = self.tintColor;
        self.navigationBar.barTintColor = self.tintColor;
        self.navigationBar.shadowImage = [UIImage new];
        [[UINavigationBar appearance] setTranslucent:NO];
    }
    
    self.delegate = self;
}

- (UIColor *)tintColor {
    return [UIColor LKColorWithLightHex:@"#EDEDED" darkHex:@"#111111"];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //push的时候隐藏底部tabbar
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        self.tabBarController.tabBar.hidden = YES;
    } else {
        viewController.hidesBottomBarWhenPushed = NO;
        self.tabBarController.tabBar.hidden = NO;
    }
    [super pushViewController:viewController animated:animated];
}

@end
