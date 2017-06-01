//
//  FileManager.m
//  FileManager
//
//  Created by Crystal on 2017/4/5.
//  Copyright © 2017年 crystal. All rights reserved.
//

#import "FileManager.h"
#import <UIKit/UIKit.h>

@interface FileManager()
@property (nonatomic, strong) NSFileManager *fileManager;
@property (nonatomic,strong)dispatch_queue_t concurrentWriteFileQueue;
@end

NSString *cacheDirectoryPath = @"/Users/Crystal/Desktop/CahceChatHistoty"; //缓存路径
NSString *canPostDirectoryPath = @"/Users/Crystal/Desktop/PostChatHistoty"; //待发送路径

NSString *postFilePath = @"/Users/Crystal/Desktop/PostChatHistoty/%@%@%@"; //待发送文件名

@implementation FileManager

+ (id)defaultManager {
    static FileManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        manager.fileManager = [NSFileManager defaultManager];
        manager.concurrentWriteFileQueue = dispatch_queue_create("writeFile.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    });
    return manager;
}

- (void)createFileDirectory {
    NSError * error = nil;
    BOOL cacheRet = [self.fileManager createDirectoryAtPath:cacheDirectoryPath  //创建目录的路径
                                   withIntermediateDirectories:YES//路径不存在是否创建目录 YES代表创建(会把不存在的目录也创建) NO代表不创建
                                                    attributes:nil    //文件属性(权限),通常写nil代表默认权限
                                                         error:&error];
    if (cacheRet) {
        NSLog(@"create cacheDirectory success!");
    } else {
        NSLog(@"error = %@",error);
    }
    
    BOOL postRet = [self.fileManager createDirectoryAtPath:canPostDirectoryPath
                                  withIntermediateDirectories:YES
                                                   attributes:nil                                                         error:&error];
    if (postRet) {
        NSLog(@"create postDirectory success!");
    } else {
        NSLog(@"error = %@",error);
    }
}

- (void)writeContentWith:(NSString *)content rebotId:(NSString *)rebotId {
    __block NSString *newContent = content;
    __weak FileManager *weakSelf = self;
    dispatch_barrier_async(self.concurrentWriteFileQueue, ^() {
        NSString *filePath = [NSString stringWithFormat:@"%@/%@.txt", cacheDirectoryPath, rebotId];
        newContent = [NSString stringWithFormat:@"%@\n", newContent];
        NSData * data = [newContent dataUsingEncoding:NSUTF8StringEncoding];
        CGFloat newDataSize = [data length];
        NSLog(@"newDataSize ---- %f", newDataSize);
        
        if ([weakSelf.fileManager fileExistsAtPath:filePath]) {
            NSError * error = nil;
            NSDictionary * dict = [weakSelf.fileManager attributesOfItemAtPath:filePath                                              error:&error];
            CGFloat fileSize = [dict fileSize];
            NSLog(@"fileSize ---- %f", fileSize);
            if ((newDataSize + fileSize) > 20) {
                BOOL moveRet = [weakSelf.fileManager moveItemAtPath:filePath toPath:[NSString stringWithFormat:postFilePath, rebotId,[weakSelf getCurrentDateStr], @".txt"] error:&error];
                if (moveRet) {
                    NSLog(@"move file success!");
                    [weakSelf createNewFileWithPath:filePath];
                } else {
                    NSLog(@"move file error !");
                }
            }
        } else {
            [weakSelf createNewFileWithPath:filePath];
        }
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:data];
    });
    
}

- (void)createNewFileWithPath:(NSString *)filePath {
    BOOL ret = [self.fileManager createFileAtPath:filePath //路径以及文件名
                                         contents:nil //要创建的文件的内容 nil代表空文件 若文件以及存在会覆盖该文件
                                       attributes:nil];
    if (ret) {
        NSLog(@"create file success!");
    } else {
        NSLog(@"create file error !");
    }
}

- (void)postFilesToBackStage {
    NSArray *filePathArr = [self.fileManager contentsOfDirectoryAtPath:canPostDirectoryPath error:nil];
    //Post文件  后台返回成功文件名，if success 删除文件
}

- (NSString *)getCurrentDateStr {
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    return timeString;
}

@end
