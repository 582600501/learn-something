//
//  ViewController.m
//  MyPickView
//
//  Created by apple on 16/12/13.
//  Copyright © 2016年 ss. All rights reserved.
//

#import "ViewController.h"
#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    int selectrow;
    NSString * cityname;
    UIView * _myPickView;
}
@property (nonatomic,copy)NSArray * array1;
@property (nonatomic,copy)NSArray * array2;
@property (nonatomic,copy)NSArray * array3;
@property (nonatomic,copy)NSArray * array0;
@property (nonatomic,copy)NSDictionary * dic;
@property (nonatomic,strong)NSMutableArray * provinceArray;
@property (nonatomic,copy)NSDictionary * provinceDic;
@property (nonatomic,strong)NSMutableArray * cityArray;
@property (nonatomic,copy)NSArray * districtArray;
@property (nonatomic,copy)NSDictionary * cityDic;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //   UICollectionView * collection=[[UICollectionView alloc]init];
    //    collection.refreshControl
    NSString * plistPath=[[NSBundle mainBundle]pathForResource:@"area" ofType:@"plist"];
    _dic=[[NSDictionary alloc]initWithContentsOfFile:plistPath];;
    
    NSArray * arraytmp=[_dic allKeys];
    NSComparator finderSort = ^(id string1,id string2){
        
        if ([string1 integerValue] > [string2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }else if ([string1 integerValue] < [string2 integerValue]){
            return (NSComparisonResult)NSOrderedAscending;
        }
        else
            return (NSComparisonResult)NSOrderedSame;
    };
    
    //数组排序：
    NSArray *resultArray = [arraytmp sortedArrayUsingComparator:finderSort];
    NSLog(@"arraytmp：%@",arraytmp);
    
    
    //    UIButton * button=[[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 30)];
    //    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    //    webView.backgroundColor=[UIColor redColor];
    //    webView.layer.borderWidth=1;
    //    webView.layer.borderColor=[UIColor blackColor].CGColor;
    //    NSURL *url = [NSURL URLWithString:@"mqq://im/chat?chat_type=wpa&uin=1270990966&version=1&src_type=web"];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //    //        webView.delegate = self;
    //    [webView loadRequest:request];
    //    [button addSubview:webView];
    //    [button setBackgroundColor:[UIColor blackColor]];
    //    [button setTitle:@"wwww" forState:UIControlStateNormal];
    //    [self.view addSubview:webView];
    
    //  NSLog(@"result==%@",[result sortedArrayUsingSelector:@selector(compare:)]);
    NSDictionary * dic1=[_dic objectForKey:[resultArray objectAtIndex:3]];//
    _array0=resultArray; //第一层省字典的key
    
    
    NSArray * provinceKey=[dic1 allKeys];
    NSLog(@"%@",provinceKey);
    _provinceArray=[[NSMutableArray alloc]init];
    NSLog(@"_array1%@",dic1);
    _cityArray=[[NSMutableArray alloc]init];
    
    _districtArray=[[NSMutableArray alloc]init];
    
    for (int i=0; i<resultArray.count; i++) {
        NSDictionary * dictmp=[_dic objectForKey:[resultArray objectAtIndex:i]];//省的字典
        NSString * province=[[dictmp allKeys]objectAtIndex:0];
        [_provinceArray addObject:province];
        
    }
    
    NSDictionary * dictmp=[_dic objectForKey:[resultArray objectAtIndex:0]];
    NSDictionary * citytmp=[dictmp objectForKey:_provinceArray[0]];
    NSArray * citykey=[citytmp allKeys];
    NSMutableArray * citytmparray=[[NSMutableArray alloc]init];
    for (int i=0; i<citykey.count; i++) {
        NSDictionary * dictmp=[citytmp objectForKey:citykey[i]];
        NSLog(@"%@",dictmp);
        NSString * city=[[dictmp allKeys]objectAtIndex:0];
        [citytmparray addObject:city];
        
    }
    NSArray * result=[citytmparray sortedArrayUsingComparator:finderSort];
    _cityArray= [NSMutableArray arrayWithArray:result];
    
    //  NSLog(@"%lu %@",(unsigned long)_provinceArray.count,_provinceArray);
    // _districtArray=[citytmp objectForKey:citykey[10]];
    NSDictionary * dictmp2=[citytmp objectForKey:citykey[0]];
    NSLog(@"%@",dictmp2);
    NSString * city=[[dictmp2 allKeys]objectAtIndex:0];
    _districtArray=[dictmp2 valueForKey:city];
    NSLog(@"_districtArray==%@",_cityArray);
    
    
    _myPickView=[[UIView alloc]initWithFrame:CGRectMake(0, 100, SCREENW, 261)];
//    _myPickView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    UILabel * bgLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREENW, 45)];
    bgLabel.backgroundColor=[UIColor colorWithRed:246/255.0 green:247/255.0 blue:248/255.0 alpha:1];
    [_myPickView addSubview:bgLabel];
    
    UIButton * cancleButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 45)];
    cancleButton.titleLabel.font=[UIFont systemFontOfSize:17];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_myPickView addSubview:cancleButton];
    
    UIButton * confirmButton=[[UIButton alloc]initWithFrame:CGRectMake(SCREENW-50, 0, 50, 45)];
    confirmButton.titleLabel.font=[UIFont systemFontOfSize:17];

    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_myPickView addSubview:confirmButton];
    
    UIPickerView * pickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 45,SCREENW , 216)];
    
    pickerView.dataSource=self;
    pickerView.delegate=self;
    
    [_myPickView addSubview:pickerView];
    [self.view addSubview:_myPickView];
    //    _array1=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",nil];
    _array2=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",nil];
    _array3=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",nil];
    
}
-(NSComparisonResult )sort{
    
    return NSOrderedAscending;
}
- (NSComparisonResult)compare:(NSNumber *)decimalNumber;
{
    
    return NSOrderedAscending;
}
//列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 3;
}
// returns the # of rows in each component..
//每列的个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;{
    
    if (component==0) {
        return _provinceArray.count;
    }
    if (component==1) {
        //  NSLog(@"_cityArray.count===%ld",_cityArray.count);
        return _cityArray.count;
    }
    return _districtArray.count;
    
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED;
{
    // NSLog(@"%d",row);
    if (component==0) {
        return [_provinceArray objectAtIndex:row];
    }
    if (component==1) {
        
        cityname=[_cityArray objectAtIndex:row];
        return [_cityArray objectAtIndex:row];
    }
    return [_districtArray objectAtIndex:row];
}



- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component __TVOS_PROHIBITED;{
    return SCREENW/3.0;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED;
{
    
    return 40;
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component ==0) {
        NSString * title=[_provinceArray objectAtIndex:row];
        NSDictionary * dictmp=[_dic objectForKey:[NSString stringWithFormat:@"%d",(int)row]];
        NSDictionary * cittmp=[dictmp objectForKey:_provinceArray[row]];
        NSLog(@"%@",cittmp);
        _cityDic=cittmp;
        NSArray * citykey1=[cittmp allKeys];
        NSComparator finderSort = ^(id string1,id string2){
            
            if ([string1 integerValue] > [string2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }else if ([string1 integerValue] < [string2 integerValue]){
                return (NSComparisonResult)NSOrderedAscending;
            }
            else
                return (NSComparisonResult)NSOrderedSame;
        };
        
        //数组排序：
        NSArray *resultArray1 = [citykey1 sortedArrayUsingComparator:finderSort];
        NSLog(@"%@",resultArray1);
        NSArray * citykey=resultArray1;
        NSMutableArray * cityarray=[[NSMutableArray alloc]init];
        for (int i=0; i<citykey.count; i++) {
            NSDictionary * dictmp=[cittmp objectForKey:citykey[i]];
            
            NSString * city=[[dictmp allKeys]objectAtIndex:0];
            [cityarray addObject:city];
        }
        //        [_cityArray removeAllObjects];
        
        
        
        //数组排序：
        NSArray *resultArray = [cityarray sortedArrayUsingComparator:finderSort];
        
        _cityArray=[NSMutableArray arrayWithArray:resultArray];
        
        
        
        
        [pickerView selectedRowInComponent:1];
        [pickerView reloadComponent:1];
        
        
        NSInteger secondselectrow=[pickerView selectedRowInComponent:1];
        NSLog(@"secondselectrow=%d",(int)secondselectrow);
        NSString * city;
        NSDictionary * dic;
        if (citykey1.count>secondselectrow) {
            dic=[cittmp objectForKey:[NSString stringWithFormat:@"%d",(int)secondselectrow]];
//            city=[[dic allKeys]objectAtIndex:0];
            city=cityarray[secondselectrow];
        }
        else
        {
        dic=[cittmp objectForKey:[NSString stringWithFormat:@"%d",(int)(_dic.count-1)]];
//        city=[[dic allKeys]objectAtIndex:0];
//        [pickerView selectRow:(int)(_dic.count-1) inComponent:1 animated:NO];
            city=[cityarray lastObject];
        [pickerView selectRow:(int)(cityarray.count-1) inComponent:1 animated:NO];
        }
//        NSDictionary * dic=[cittmp objectForKey:@"0"];
//        NSString * city=[[dic allKeys]objectAtIndex:0];
        NSLog(@"city==%@",city);
        _districtArray=[dic valueForKey:city];
        
        [pickerView reloadComponent:2];
        [pickerView selectedRowInComponent:2];
        // [pickerView selectRow:0 inComponent:1 animated:NO];
        selectrow=(int)row;
        NSLog(@"%@",title);
        
        
        
    }
    if (component ==1) {
        NSArray * citykey=[_cityDic allKeys];
        // NSMutableArray * cityarray=[[NSMutableArray alloc]init];
        for (int i=0; i<citykey.count; i++) {
            NSDictionary * dictmp=[_cityDic objectForKey:citykey[i]];
            NSString * city=[[dictmp allKeys]objectAtIndex:0];
            if ([city isEqualToString:_cityArray[row]]) {
                _districtArray=[dictmp valueForKey:city];
                break;
            }
            
        }
        
        
        //        selectrow=(int)row;
        NSString * title=[_cityArray objectAtIndex:row];
        NSLog(@"%@",title);
        [pickerView reloadComponent:2];
    }
    if (component ==2) {
        NSString * title=[_districtArray objectAtIndex:row];
        NSLog(@"%@",title);
    }
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view __TVOS_PROHIBITED;{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textAlignment=NSTextAlignmentCenter;
        pickerLabel.textColor=[UIColor grayColor];
        [pickerLabel setFont:[UIFont systemFontOfSize:15]];
        pickerLabel.numberOfLines=0;
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
