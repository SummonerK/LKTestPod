//
//  testBackManager.m
//  LKDisplayModule
//
//  Created by lofi on 2024/12/6.
//

#import "testBackManager.h"

@interface testBackManager()

@property(nonatomic, copy) void (^authUserBack)(XMRealAuthCode authCode);

@end

@implementation testBackManager

- (void)dealloc {
    NSLog(@"testBackManager dealloc");
}

- (void)longTimeBack {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.authUserBack) {
            self.authUserBack(XMRealAuthCode_Success);
        }
    });
}

- (void)realAuthCompleteBlock:(void (^)(XMRealAuthCode authCode))completeBlock {
    self.authUserBack = completeBlock;
    NSLog(@"----接口调用-----");
    [self longTimeBack];
}

@end
