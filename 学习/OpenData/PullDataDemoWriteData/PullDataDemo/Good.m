//
//  Good.m
//  PullDataDemo
//
//  Created by Crystal on 16/8/29.
//  Copyright © 2016年 crystal. All rights reserved.
//

#import "Good.h"

@implementation Good
/*
 @property (nonatomic, copy) NSString *name;
 @property (nonatomic, copy) NSString *company;
 @property (nonatomic, strong) NSMutableArray *composition;
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
 */
- (NSString *)description {
    
    return [NSString stringWithFormat:@"*********%@*********\n公司:%@\n国家:%@\n专家建议:%@\n中国公司地址:%@\n容量:%@\n价格:%@\n别名:%@\n品牌:%@\n分类:%@\n备案文号:%@\n*********成分*********",self.name,self.company,self.country,self.doyenComment,self.chinaAddress,self.capacity,_price,_alias,_brand,_cateName,_approval];
}

@end

@implementation GoodComposition

- (NSString *)description {
    
    return [NSString stringWithFormat:@"中文名: %@     安全风险: %@     使用目的: %@", _name, _safety, _used];
}

@end

/*
 
 @property (nonatomic, copy) NSString *name;
 @property (nonatomic, copy) NSString *summary;
 @property (nonatomic, copy) NSString *CASNum;
 @property (nonatomic, copy) NSString *used;
 @property (nonatomic, copy) NSString *ename;
 @property (nonatomic, copy) NSString *otherName;
 @property (nonatomic, copy) NSString *safety;
 */
@implementation CompositionSingleDetail

- (NSString *)description {
    
    return [NSString stringWithFormat:@"*********%@*********\n英文名(INCI):%@\nCAS号:%@\n使用目的:%@\n其他名称:%@\n安全风险:%@\n成分概述:\n                  %@", _name, _ename, _CASNum, _used, _otherName, _safety, _summary];
}

@end