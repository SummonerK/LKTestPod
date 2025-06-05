//
//  testBackManager.h
//  LKDisplayModule
//
//  Created by lofi on 2024/12/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, XMRealAuthCode) {
    XMRealAuthCode_Success,
    XMRealAuthCode_Success_Fixing,     // 点击了更正,审核中
};

@interface testBackManager : NSObject

- (void)realAuthCompleteBlock:(void (^)(XMRealAuthCode authCode))completeBlock;

@end

NS_ASSUME_NONNULL_END
