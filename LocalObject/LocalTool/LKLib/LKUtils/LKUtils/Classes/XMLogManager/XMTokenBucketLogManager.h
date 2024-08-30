//
//  XMTokenBucketLogManager.h
//  XMLog
//
//  Created by lofi on 2024/8/27.
//

#import <Foundation/Foundation.h>
#include <pthread.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMTokenBucketLogManager : NSObject{
    pthread_mutex_t _lock;      //C语言互斥锁，更小消耗，适合高并发
}

@property (nonatomic, strong) NSFileHandle *fileHandler;

+ (nonnull XMTokenBucketLogManager *)shareInstance;

void CLLogWithFile(NSString *format, ...);

@end

NS_ASSUME_NONNULL_END
