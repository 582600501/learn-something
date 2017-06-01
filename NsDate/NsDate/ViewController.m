//
//  ViewController.m
//  NsDate
//
//  Created by apple on 17/5/23.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate * date = [NSDate date];
    NSString * str = [dateFormatter stringFromDate:date];
    NSLog(@"%@",str);
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    //输入格式
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd"];
    NSDate * date2 = [dateFormatter2 dateFromString:@"2017-05-24"];
    NSString * str2 = [dateFormatter2 stringFromDate:date2];
    NSLog(@"%@",str2);
    
    NSDate * eardate = [date earlierDate:date2];
    NSString * str3 = [dateFormatter2 stringFromDate:eardate];

    if (![str3 isEqualToString:@"2017-05-21"]) {
        NSLog(@"当前时间earlier");
    }else{
     NSLog(@"当前时间later");
    
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
