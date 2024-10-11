//
//  TabbarItemDataModel.h
//  LKDisplayModule
//
//  Created by lofi on 2024/7/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TabbarItemDataModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *selectedImage;

@property (nonatomic, copy) NSString *normalImage;

@property (nonatomic, strong) NSString *className;

@property (nonatomic, assign) BOOL badgeEnabled;

@end

NS_ASSUME_NONNULL_END
