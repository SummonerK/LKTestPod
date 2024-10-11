//
//  PageListModel.h
//  LKDisplayModule
//
//  Created by lofi on 2024/7/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageListModel : NSObject

@end

@interface Item : NSObject
- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle vc:(UIViewController *)vc;
@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *subTitle;
@property (nonatomic, strong, readonly) UIViewController *vc;
@end

@interface Section : NSObject
- (instancetype)initWithTitle:(NSString *)title items:(NSArray<Item *> *)items;
@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSArray<Item *> *items;
@end

NS_ASSUME_NONNULL_END
