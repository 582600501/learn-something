//
//  FileManager.h
//  FileManager
//
//  Created by Crystal on 2017/4/5.
//  Copyright © 2017年 crystal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

+ (id)defaultManager;
- (void)createFileDirectory;
- (void)writeContentWith:(NSString *)content rebotId:(NSString *)rebotId;
- (void)postFilesToBackStage;
@end
