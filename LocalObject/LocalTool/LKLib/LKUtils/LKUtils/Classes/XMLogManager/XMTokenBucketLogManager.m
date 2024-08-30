//
//  XMTokenBucketLogManager.m
//  XMLog
//
//  Created by lofi on 2024/8/27.
//

#import "XMTokenBucketLogManager.h"
#include <stdio.h>
#include <sys/time.h>

@implementation XMTokenBucketLogManager

+ (nonnull XMTokenBucketLogManager *)shareInstance{
    static dispatch_once_t once;
    static XMTokenBucketLogManager *instance;
    dispatch_once(&once, ^{
        instance = [[XMTokenBucketLogManager alloc] init];
        NSFileHandle *fileHandle = nil;
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSString * documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        NSString *currentFilePath = [documentsDirectory stringByAppendingPathComponent:@"frequency.log"];
        [fileManager createFileAtPath:currentFilePath contents:nil attributes:nil];
        fileHandle = [NSFileHandle fileHandleForWritingAtPath:currentFilePath];
        instance.fileHandler = fileHandle;
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        pthread_mutex_init(&_lock, NULL);
    }
    return self;
}

- (void)addLogWithFile:(NSString*)logs {
    // 开启异步子线程，将打印写入文件
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSFileHandle *output = self.fileHandler;
        pthread_mutex_lock(&self->_lock);
        if (output != nil) {
            time_t rawtime;
            struct tm timeinfo;
            char buffer[64];
            time(&rawtime);
            localtime_r(&rawtime, &timeinfo);
            struct timeval curTime;
            gettimeofday(&curTime, NULL);
            int milliseconds = curTime.tv_usec / 1000;
            strftime(buffer, 64, "%Y-%m-%d %H:%M", &timeinfo);
            char fullBuffer[128] = { 0 };
            snprintf(fullBuffer, 128, "%s:%2d.%.3d ", buffer, timeinfo.tm_sec, milliseconds);
            [output writeData:[[[NSString alloc] initWithCString:fullBuffer encoding:NSASCIIStringEncoding] dataUsingEncoding:NSUTF8StringEncoding]];
            [output writeData:[logs dataUsingEncoding:NSUTF8StringEncoding]];
            static NSData *returnData = nil;
            if (returnData == nil)
                returnData = [@"\n" dataUsingEncoding:NSUTF8StringEncoding];
            [output writeData:returnData];
            pthread_mutex_unlock(&self->_lock);
        }
    });
}

void CLLogWithFile(NSString *format, ...) {
    va_list args;
    va_start(args, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    [[XMTokenBucketLogManager shareInstance] addLogWithFile:message];
}

@end
/**
 static NSFileHandle *CLLogFileHandle()
 {
     static NSFileHandle *fileHandle = nil;
     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^
                   {
                       NSFileManager *fileManager = [[NSFileManager alloc] init];
                       
                       NSString *documentsDirectory = [Tools pathDocuments];
                       
                       NSString *currentFilePath = [documentsDirectory stringByAppendingPathComponent:@"application-0.log"];
                       NSString *oldestFilePath = [documentsDirectory stringByAppendingPathComponent:@"application-60.log"];
                       
                       //60文件存在，删除
                       if ([fileManager fileExistsAtPath:oldestFilePath]){
                           [fileManager removeItemAtPath:oldestFilePath error:nil];
                       }
                       //遍历文件，将文件编号往后移动，新增第0的一个文件
                       for (int i = 60 - 1; i >= 0; i--) {
                           NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"application-%d.log", i]];
                           NSString *nextFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"application-%d.log", i + 1]];
                           if ([fileManager fileExistsAtPath:filePath])
                           {
                               [fileManager moveItemAtPath:filePath toPath:nextFilePath error:nil];
                           }
                       }
                       
                       [fileManager createFileAtPath:currentFilePath contents:nil attributes:nil];
                       fileHandle = [NSFileHandle fileHandleForWritingAtPath:currentFilePath];
                       [fileHandle truncateFileAtOffset:0];
                   });
     
     return fileHandle;
 }
  
 void CLLogWithFile(NSString *format, ...) {
     va_list L;
     va_start(L, format);
     NSString *message = [[NSString alloc] initWithFormat:format arguments:L];
     NSLog(@"%@", message);
     // 开启异步子线程，将打印写入文件
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         NSFileHandle *output = CLLogFileHandle();
         if (output != nil) {
             time_t rawtime;
             struct tm timeinfo;
             char buffer[64];
             time(&rawtime);
             localtime_r(&rawtime, &timeinfo);
             struct timeval curTime;
             gettimeofday(&curTime, NULL);
             int milliseconds = curTime.tv_usec / 1000;
             strftime(buffer, 64, "%Y-%m-%d %H:%M", &timeinfo);
             char fullBuffer[128] = { 0 };
             snprintf(fullBuffer, 128, "%s:%2d.%.3d ", buffer, timeinfo.tm_sec, milliseconds);
             [output writeData:[[[NSString alloc] initWithCString:fullBuffer encoding:NSASCIIStringEncoding] dataUsingEncoding:NSUTF8StringEncoding]];
             [output writeData:[message dataUsingEncoding:NSUTF8StringEncoding]];
             static NSData *returnData = nil;
             if (returnData == nil)
                 returnData = [@"\n" dataUsingEncoding:NSUTF8StringEncoding];
             [output writeData:returnData];
         }
     });
     va_end(L);
 }

 */
