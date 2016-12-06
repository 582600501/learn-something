//
//  ViewController.m
//  PullDataDemo
//
//  Created by Crystal on 16/8/29.
//  Copyright © 2016年 crystal. All rights reserved.
//

#import "ViewController.h"
#import "NSDictionary+JsonString.h"
#import "AFNetworking.h"
#import "CoreDataHelper.h"
#import "Good.h"

#import "Composition.h"
#import "Product.h"
#import "AllComposition.h"

NSString *const cateName = @"面膜";

NSString *const frontMarchingUrlOfGoodsList = @"http://search.bevol.cn/goods/index?p=%ld";
NSString *const lastUrlPartOfGoodsList = @"&keywords=%25E9%259D%25A2%25E8%2586%259C&callback=jQuery19108656576962675899_1472455627074&_=1472455627075";

NSString *const goodDetailMarchingUrl = @"http://source.bevol.cn/goods/info/id/%@.json";
NSString *const compositionDetailUrl = @"http://source.bevol.cn/goods/composition/id/%ld.json";

@interface ViewController ()

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *goodIds;
@property (nonatomic, strong) NSMutableArray *compositionDetails;
@property (nonatomic, strong, readonly) CoreDataHelper *coreDataHelper;
@end

@implementation ViewController

#pragma mark lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _page = 249;

 //   [self pullGoodsListData];

}

#pragma mark private methods
//抓取产品列表
- (void)pullGoodsListData {
    
    __weak ViewController *weakSelf = self;
    NSString *frontUrlPart = [NSString stringWithFormat:frontMarchingUrlOfGoodsList,_page];
    NSString *goodsListUrl = [NSString stringWithFormat:@"%@%@",frontUrlPart,lastUrlPartOfGoodsList];

   AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [[AFCompoundResponseSerializer alloc] init];
    [manager GET:goodsListUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [weakSelf analysisGoodsDic:responseObject];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
//将原数据转成Json格式
- (void)analysisGoodsDic:(id)responseObject {
    
    NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    
    NSArray *srtArray = [str componentsSeparatedByString:@"("];
    NSMutableArray *mutStrArray = [NSMutableArray arrayWithArray:srtArray];
    [mutStrArray removeObjectAtIndex:0];
    
    NSString *frontContenStr = [mutStrArray componentsJoinedByString:@"("];
    NSMutableString *mutFrontContentStr = [NSMutableString stringWithString:frontContenStr];
    NSString *contentStr = [frontContenStr substringToIndex:[mutFrontContentStr length] - 2];
    
    NSDictionary *dic = [NSDictionary dictionaryWithJsonString:contentStr];
    
    [self getGoodIdsWithGoodsDic:dic];
}
//解析获取列表内产品id
- (void)getGoodIdsWithGoodsDic:(NSDictionary *)goodsDic {
    
    NSDictionary *dataDic = [goodsDic objectForKey:@"data"];
    
    NSArray *goods = [dataDic objectForKey:@"items"];
    
    for (NSDictionary *good in goods) {
        
        NSString *goodId = [good objectForKey:@"mid"];
        [self.goodIds addObject:goodId];
    }
    
    [self pullGoodDetailWithGoodId:self.goodIds];
}

- (void)pullGoodDetailWithGoodId:(NSMutableArray *)goodIds {
    
    __weak ViewController *weakSelf = self;
    
    dispatch_group_t pageGroup = dispatch_group_create();
    for (NSString *goodId in goodIds) {
        
        NSString *goodDetailUrl = [NSString stringWithFormat:goodDetailMarchingUrl,goodId];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [[AFCompoundResponseSerializer alloc] init];
        
        dispatch_group_enter(pageGroup);
        [manager GET:goodDetailUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            NSDictionary *goodDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            Good *good = [[Good alloc] init];
            
            Product *product = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:[[self cdh] context]];
            
            [[goodDic allKeys] containsObject:@"title"] ? (product.name = [goodDic objectForKey:@"title"]) : (product.name = @"无");

            [[goodDic allKeys] containsObject:@"china_company"] ? (product.company = [goodDic objectForKey:@"china_company"]) : (product.company = @"无");
            [[goodDic allKeys] containsObject:@"country"] ? (product.country = [goodDic objectForKey:@"country"]) : (product.country = @"无");

            if ([[goodDic allKeys] containsObject:@"doyencomment"]) {
                
                if ([[goodDic objectForKey:@"doyencomment"] isKindOfClass:[NSString class]]) {
                    
                    product.doyenComment = [goodDic objectForKey:@"doyencomment"];
                } else {
                    
                    product.doyenComment = @"无";
                }
            } else {
                
                product.doyenComment = @"无";
            }
            [[goodDic allKeys] containsObject:@"china_address"] ? (product.address_china = [goodDic objectForKey:@"china_address"]) : (product.address_china = @"无");
            [[goodDic allKeys] containsObject:@"sell_capacity"] ? (product.capacity = [goodDic objectForKey:@"sell_capacity"]) : (product.capacity = @"无");
            [[goodDic allKeys] containsObject:@"price"] ? (product.price = [goodDic objectForKey:@"price"]) : (product.price = @"无");
            [[goodDic allKeys] containsObject:@"alias"] ? (product.other_name = [goodDic objectForKey:@"alias"]) : (product.other_name = @"无");
            [[goodDic allKeys] containsObject:@"brand"] ? (product.brand = [goodDic objectForKey:@"brand"]) : (product.brand = @"无");
            [[goodDic allKeys] containsObject:@"cateName"] ? (product.cateName = [goodDic objectForKey:@"cateName"]) : (product.cateName = @"无");
            [[goodDic allKeys] containsObject:@"approval"] ? (product.approval = [goodDic objectForKey:@"approval"]) : (product.approval = @"无");
            
            NSDictionary *efficacyDic = [NSDictionary dictionary];
            
            [[goodDic allKeys] containsObject:@"efficacy"] ? (efficacyDic = [goodDic objectForKey:@"efficacy"]) : (goodDic = nil);
            
            if (efficacyDic) {
                
                CFDictionaryRef dataDic;
                [[efficacyDic allKeys] containsObject:@"data"] ? (dataDic = (__bridge CFDictionaryRef)([efficacyDic objectForKey:@"data"])) : (dataDic = nil);
                
                if (dataDic) {

                    if (CFGetTypeID(dataDic) == CFDictionaryGetTypeID()) {
                        
                        NSDictionary *nsDataDic = (__bridge NSDictionary*)dataDic;
                        NSArray *array = [nsDataDic allValues];
                        product.efficacy = [array componentsJoinedByString:@"  "];
                    } else if (CFGetTypeID(dataDic) == CFArrayGetTypeID()) {
                        
                        NSArray *array = (__bridge NSArray *)dataDic;
                        product.efficacy = [array componentsJoinedByString:@"  "];
                    }
                    
                } else {
                    
                  product.efficacy = @"无";
                    
                }

            } else {
                
                product.efficacy = @"无";
            }

            [[goodDic allKeys] containsObject:@"composition"] ? (good.composition = [goodDic objectForKey:@"composition"]) : (good.composition = [NSMutableArray arrayWithObjects:@"无成分列表", nil]);
            
            if (good.composition && [good.composition count] > 0) {
                good.allcomposition = [[NSMutableArray alloc] init];
                good.compositionIds = [[NSMutableArray alloc] init];
                for (NSInteger i = 0 ; i < [good.composition count] ; i++) {

                    NSDictionary *compositionDic = [good.composition objectAtIndex:i];
                    Composition *composition = [NSEntityDescription insertNewObjectForEntityForName:@"Composition" inManagedObjectContext:[[self cdh] context]];
                    
                    NSArray *usedArray = [NSArray array];
                    
                    [[compositionDic allKeys] containsObject:@"name"] ? (composition.name = [compositionDic objectForKey:@"name"]) : (composition.name = @"无");
                    
                    
                    if ([[compositionDic allKeys] containsObject:@"useds"]) {
                        
                        if ([[compositionDic objectForKey:@"useds"] isKindOfClass:[NSArray class]]) {
                            
                            usedArray = [compositionDic objectForKey:@"useds"];
                            if ([usedArray count] > 0) {
                                NSDictionary *usedDic = usedArray[0];
                                composition.used = [usedDic objectForKey:@"title"];
                            }
                        } else {
                            
                            composition.used = @"无";
                        }
                    } else {
                        
                        composition.used = @"无";
                    }
                    
                    [[compositionDic allKeys] containsObject:@"safety"] ? (composition.safety = [compositionDic objectForKey:@"safety"]) : (composition.safety = @"无");
                    
                    [[compositionDic allKeys] containsObject:@"id"] ? (composition.compositionId = [compositionDic objectForKey:@"id"]) : (composition.compositionId = @"无");
                    
                    [good.compositionIds addObject:composition.compositionId];
                    
                    composition.product = product;
                    composition.sort = @(i);
                }
                
            }
            
            [weakSelf analysisCompositionDetailWithCompositionIds:good.compositionIds completion:^() {
                
                dispatch_group_leave(pageGroup);
            }];
   
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
    
    dispatch_group_notify(pageGroup, dispatch_get_main_queue(), ^{
//        NSLog(@"换页");
    });

}
//通过产品id解析获得各产品的成分详情
- (void)analysisCompositionDetailWithCompositionIds:(NSMutableArray *)compositionIds completion:(void(^) ())comp {

    __weak ViewController *weakSelf = self;
    dispatch_group_t group = dispatch_group_create();
    
    for (NSString *compositionId in compositionIds) {
        dispatch_group_enter(group);
        NSString *singleCompositionUrl = [NSString stringWithFormat:compositionDetailUrl,[compositionId integerValue]];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [[AFCompoundResponseSerializer alloc] init];
        [manager GET:singleCompositionUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSDictionary *compositionDetail = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            CompositionSingleDetail *singleComposition = [[CompositionSingleDetail alloc] init];
            
            [[compositionDetail allKeys] containsObject:@"name"] ? (singleComposition.name = [compositionDetail objectForKey:@"name"]) : (singleComposition.ename = @"无");
            [[compositionDetail allKeys] containsObject:@"remark"] ? (singleComposition.summary = [compositionDetail objectForKey:@"remark"]) : (singleComposition.summary = @"无");
            [[compositionDetail allKeys] containsObject:@"english"] ? (singleComposition.ename = [compositionDetail objectForKey:@"english"]) : (singleComposition.ename = @"无");
            [[compositionDetail allKeys] containsObject:@"cas"] ? (singleComposition.CASNum = [compositionDetail objectForKey:@"cas"]) : (singleComposition.ename = @"无");
            [[compositionDetail allKeys] containsObject:@"other_title"] ? (singleComposition.otherName = [compositionDetail objectForKey:@"other_title"]) : (singleComposition.otherName = @"无");
            [[compositionDetail allKeys] containsObject:@"safety"] ? (singleComposition.safety = [compositionDetail objectForKey:@"safety"]) : (singleComposition.safety = @"无");
            
            NSArray *usedArray = [NSArray array];
            NSMutableString *usedsStr = [NSMutableString string];
            
            if ([[compositionDetail allKeys] containsObject:@"useds"]) {
                
                if ([[compositionDetail objectForKey:@"useds"] isKindOfClass:[NSArray class]]) {
                    
                    usedArray = [compositionDetail objectForKey:@"useds"];
                    if ([usedArray count] > 0) {
                        for (NSDictionary *usedDic in usedArray) {
                            
                             [usedsStr appendFormat:@"%@  ",[usedDic objectForKey:@"title"]];
                        }
                    }
                } else {
                    
                    usedsStr = [NSMutableString stringWithFormat:@"无"];
                }
            } else {
                
                usedsStr = [NSMutableString stringWithFormat:@"无"];
            }
            
            singleComposition.used = usedsStr;

            dispatch_group_leave(group);
            
            [weakSelf.compositionDetails addObject:singleComposition];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{

        comp();
        
        for (CompositionSingleDetail *detail in weakSelf.compositionDetails) {
            
            AllComposition *singleComposition = [NSEntityDescription insertNewObjectForEntityForName:@"AllComposition" inManagedObjectContext:[[weakSelf cdh] context]];
            singleComposition.name = detail.name;
            singleComposition.summary = detail.summary;
            singleComposition.cas_num = detail.CASNum;
            singleComposition.used = detail.used;
            singleComposition.ename = detail.ename;
            singleComposition.other_name = detail.otherName;
            singleComposition.safety = detail.safety;
        }

//        i ++;

//        if (weakSelf.page < 2) {
//           
//            weakSelf.page ++;
//            [self.goodIds removeAllObjects];
//            [weakSelf pullGoodsListData];
//        }
        [weakSelf performSelectorOnMainThread:@selector(backMainThread) withObject:nil waitUntilDone:NO];

    });
    
}

- (void)backMainThread {
    
    [[self cdh] saveContext];
    if (_page < 250) {
        
        _page ++;
        [self.goodIds removeAllObjects];
        [self.compositionDetails removeAllObjects];
        [self pullGoodsListData];
    }
}

#pragma mark property method

- (NSMutableArray *)goodIds {
    
    if (!_goodIds) {
        
        _goodIds = [[NSMutableArray alloc] init];
    }
    
    return _goodIds;
}

- (NSMutableArray *)compositionDetails {
    
    if (!_compositionDetails) {
        
        _compositionDetails = [[NSMutableArray alloc] init];
        
    }
    
    return _compositionDetails;
}

- (CoreDataHelper *)cdh {

    if (!_coreDataHelper) {
        _coreDataHelper = [CoreDataHelper new];
        [_coreDataHelper setupCoreData];
    }
    return _coreDataHelper;
}


@end
