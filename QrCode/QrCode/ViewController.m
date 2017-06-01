//
//  ViewController.m
//  QrCode
//
//  Created by apple on 17/5/2.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage * Img= [UIImage imageNamed:@"bbb"];
    float w = Img.size.width;
    float h = Img.size.height;
    
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 150, h/w*150)];
    img.image = Img;
    img.userInteractionEnabled = YES;
    UITapGestureRecognizer  * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealLongPress:)];
    
    [img addGestureRecognizer:tap];
    
    [self.view addSubview:img];
    
}
#pragma mark-> 长按识别二维码
-(void)dealLongPress:(UIGestureRecognizer*)gesture{
    
    UIImageView*tempImageView=(UIImageView*)gesture.view;
    if(tempImageView.image){
        //1. 初始化扫描仪，设置设别类型和识别质量
        CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
        //2. 扫描获取的特征组
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:tempImageView.image.CGImage]];
        //3. 获取扫描结果
        CIQRCodeFeature *feature = [features objectAtIndex:0];
        NSString *scannedResult = feature.messageString;
        
      UIWebView *  _webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREENW, SCREENH-10)];
      _webview.delegate=self;
        NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:scannedResult]];
        //让webview读取这个请求
        
        [_webview loadRequest:request];
        
        NSLog(@"%@",scannedResult);
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:scannedResult delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else {
        
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:@"您还没有生成二维码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
