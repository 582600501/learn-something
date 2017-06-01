//
//  NSDictionary+JsonString.h
//  PullDataDemo
//
//  Created by Crystal on 16/8/29.
//  Copyright © 2016年 crystal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JsonString)

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
