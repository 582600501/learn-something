//
//  ViewController.m
//  ChatWithUIImageResizingMode
//
//  Created by apple on 17/4/25.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "ViewController.h"

#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic,strong) UITextView * textview;
@property (nonatomic,strong) UIImageView * img;
@property (nonatomic,strong) UIImageView * img2;
@property (nonatomic,strong) UIImageView * img3;

@property (nonatomic,strong) UILabel * textlabel;
@property (nonatomic,strong) UIButton * sendButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIImage * testimg = [UIImage imageNamed:@"selfchat"];
    
    _img = [[UIImageView alloc] initWithFrame:CGRectMake(100, 20, 200, 40.00/93.00*200)];
//    _img.backgroundColor = [UIColor grayColor];
    _img.image = [self regisImgWithImgName:@"selfchat"];
    
    [self.view addSubview:_img];
    
    testimg = [testimg stretchableImageWithLeftCapWidth:-testimg.size.width*0.5 topCapHeight:testimg.size.height*0.8];
    
    _img2 = [[UIImageView alloc] initWithFrame:CGRectMake(70, 200, 130, 160)];
    _img2.image = [self regisImgWithImgName:@"selfchat"];
    [self.view addSubview:_img2];

    
    UILabel * _tipLabel = [[UILabel alloc] init];
    _tipLabel.numberOfLines=0;

    NSString * str = @"在iOS在上篇博客（iOS开发之微信聊天工具栏的封装）中对微信聊天页面下方的工具栏进行了在上篇博客（iOS开发之微信聊天工具栏的封装）中对微信聊天页面下方的工具栏进行了";

    
    NSMutableAttributedString * attr=[[NSMutableAttributedString alloc]initWithString:str];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
    NSMutableParagraphStyle * paragraphStyle=[[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:3];
    [attr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(1, str.length-1)];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, attr.length)];
    _tipLabel.attributedText=attr;
    
    [_tipLabel sizeToFit];
    if (_tipLabel.frame.size.width> SCREENW-120) {
        CGSize maxLabelSize=CGSizeMake(SCREENW-120, 9999);
        CGSize expectSize=[_tipLabel sizeThatFits:maxLabelSize];
        _tipLabel.frame=CGRectMake(10,0,SCREENW-120, expectSize.height+20);
    }
    else
    {
    
        CGFloat w = _tipLabel.frame.size.width ;
        
        _tipLabel.frame = CGRectMake(10, 0, w, 40);
        

    
    }
   
    
    
    _img3 = [[UIImageView alloc] initWithFrame:CGRectMake(70, 400, _tipLabel.frame.size.width+20, _tipLabel.frame.size.height)];
    _img3.image = [testimg stretchableImageWithLeftCapWidth:-testimg.size.width*0.5 topCapHeight:testimg.size.height*0.8];
    _img3.layer.cornerRadius = 3;
    _img3.layer.masksToBounds = YES;
    [_img3 addSubview:_tipLabel];
    [self.view addSubview:_img3];

    _textlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _img.frame.size.width, _img.frame.size.height)];
    _textlabel.text = @"cccccccc";
    
    [_img addSubview:_textlabel];
    
    _sendButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 380, 100, 40)];
    _sendButton.backgroundColor = [UIColor grayColor];
    [_sendButton setTitle:@"kkk" forState:UIControlStateNormal];
    
   // [self.view addSubview:_sendButton];
}


-(UIImage *)regisImgWithImgName:(NSString *)name{

    UIImage * img = [UIImage imageNamed:name];
    CGFloat w = img.size.width;
    CGFloat h = img.size.height;
    return [img resizableImageWithCapInsets:UIEdgeInsetsMake(h/2+3, w/2, h/2, w/2)];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
