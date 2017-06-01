//
//  Good.h
//  PullDataDemo
//
//  Created by Crystal on 16/8/29.
//  Copyright © 2016年 crystal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Good : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, strong) NSMutableArray *composition;
@property (nonatomic, strong) NSMutableArray *allcomposition;
@property (nonatomic, strong) NSMutableArray *compositionIds;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *doyenComment;//专家建议
@property (nonatomic, copy) NSString *chinaAddress;
@property (nonatomic, copy) NSString *capacity;//容量
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *alias; //别名
@property (nonatomic, copy) NSString *brand;
@property (nonatomic, copy) NSString *cateName;
@property (nonatomic, copy) NSArray *efficacy;
@property (nonatomic, copy) NSString *approval;
@property (nonatomic, strong) NSMutableArray *compositionDetail;

@end

@interface GoodComposition : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *used;
@property (nonatomic, copy) NSString *safety;
@property (nonatomic, copy) NSString *compositionId;

@end

@interface CompositionSingleDetail : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *CASNum;
@property (nonatomic, copy) NSString *used;
@property (nonatomic, copy) NSString *ename;
@property (nonatomic, copy) NSString *otherName;
@property (nonatomic, copy) NSString *safety;


@end