//
//  IBMainTabVC.h
//  LKDisplayModule
//
//  Created by lofi on 2024/7/23.
//

#import <UIKit/UIKit.h>
#import "IBTabVCConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface IBMainTabVC : UITabBarController
@property (nonatomic, copy) NSArray<LKTabBarItem *> *arrayTabItems;          //tab配置
@end

NS_ASSUME_NONNULL_END
