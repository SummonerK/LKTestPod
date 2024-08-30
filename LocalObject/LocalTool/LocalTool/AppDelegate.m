//
//  AppDelegate.m
//  LocalTool
//
//  Created by lofi on 2024/7/2.
//

#import "AppDelegate.h"
#import <LKDisplayModule/IBMainTabVC.h>
#import <LKDisplayModule/IBTabVCConfig.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self configTabbarRootViewController];
    
    return YES;
}

- (void)configTabbarRootViewController{
    IBMainTabVC *tbc = [[IBMainTabVC alloc] init];
    tbc.arrayTabItems = [IBTabVCConfig tabItems];
//    UIViewController * tbc = [[UIViewController alloc] init];
    self.window.rootViewController = tbc;
}
@end
