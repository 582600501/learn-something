//
//  ViewController.m
//  NIne
//
//  Created by ss on 16/3/31.
//  Copyright (c) 2016年 ss. All rights reserved.
//

#import "ViewController.h"

#define SCREENSIZE [UIScreen mainScreen].bounds
#define  SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
{

    UILabel * _numLabel;
    UIButton * _deletButton;
    UIView * _bgView;
    UIButton * _zhankai;
    


}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createUI];
}

-(void)createUI{//button heigh:70 width: SCREENW/3
    
    NSArray * array=@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"shou",@"0",@"粘贴"];
    _zhankai=[[UIButton alloc]initWithFrame:CGRectMake(SCREENW/2-30, SCREENH-60, 60, 60)];
    [_zhankai setTitle:@"展开" forState:UIControlStateNormal];
    _zhankai.backgroundColor=[UIColor redColor];
    [_zhankai addTarget:self action:@selector(didselect:) forControlEvents:UIControlEventTouchUpInside];
    _zhankai.tag=100;
    [self.view addSubview:_zhankai];
    _bgView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREENH-335, SCREENW, 335)];
    _bgView.backgroundColor=[UIColor colorWithRed:206/255.0 green:210/255.0 blue:216/255.0 alpha:1];
    [self.view addSubview:_bgView];
    
    _numLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREENW, 55)];
    _numLabel.text=@"ssssss";
    _numLabel.backgroundColor=[UIColor whiteColor];
    _numLabel.layer.borderWidth=1;
    _numLabel.layer.borderColor=[UIColor blackColor].CGColor;
    _numLabel.textColor=[UIColor redColor];
    [_bgView addSubview:_numLabel];
    for (int i=0; i<12; i++) {
        UIButton * button=[[UIButton alloc]initWithFrame:CGRectMake((i%3)*SCREENW/3,(i/3)*70+55, SCREENW/3, 70)];
        button.tag=i+200;
        [button addTarget:self action:@selector(didselect:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.borderColor=[UIColor blackColor].CGColor;
        button.layer.borderWidth=1;
       // button.titleLabel.text=[NSString stringWithFormat:@"%d",i];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [_bgView addSubview:button];
    }
    
}
-(void)didselect:(UIButton *)button{

    if (button.tag==209) {
        _bgView.frame=CGRectMake(0, SCREENH, SCREENW, 335);
    }
    if (button.tag==100) {
        _bgView.frame=CGRectMake(0, SCREENH-335, SCREENW, 335);
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
