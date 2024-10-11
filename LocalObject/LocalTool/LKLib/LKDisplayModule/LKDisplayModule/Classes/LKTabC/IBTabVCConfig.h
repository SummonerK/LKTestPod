//
//  IBTabVCConfig.h
//  LKDisplayModule
//
//  Created by lofi on 2024/7/23.
//

#import <Foundation/Foundation.h>
#import "TabbarItemDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LKTabBarItem : NSObject
@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIViewController *controller;
@end

@interface IBTabVCConfig : NSObject

+ (nonnull NSMutableArray<LKTabBarItem *> *)tabItems;

@end

NS_ASSUME_NONNULL_END
