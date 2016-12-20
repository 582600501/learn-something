//
//  AddressViewController.m
//  Address
//
//  Created by Crystal on 16/12/19.
//  Copyright © 2016年 crystal. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressMessageCell.h"
#import "CustomButton.h"
#import "Masonry.h"

#define CELLHEIGHT 50
#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define RGB(a, b, c) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:1.0]

@interface AddressViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CustomButton *saveButton;
@end

@implementation AddressViewController

#pragma mark lifecycle methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[
                       @{@"title":@"收件人", @"placehoder":@"请输入真实姓名"},
                       @{@"title":@"手机号码", @"placehoder":@"请输入联系电话"},
                       @{@"title":@"所在地区", @"placehoder":@"请选择地区"},
                       @{@"title":@"详细地址", @"placehoder":@"请输入详细街道地址"},
                       @{@"title":@"设为默认地址", @"subtitle":@"*每次下单会使用该地址"},
    ];
    [self setupUI];
    [self setupTableView];
    [self setupSaveButton];
    [self setupConstraint];
}

#pragma mark private methods
- (void)setupUI {
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = RGB(235, 238, 239);
}

- (void)setupTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor purpleColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = false;
    
    [self.view addSubview:self.tableView];
}

- (void)setupSaveButton {
    
    self.saveButton = [[CustomButton alloc] initWithFrame:CGRectZero NormalColor:RGB(232, 67, 75) SelectedColor:RGB(255, 43, 44) TextColor:RGB(255, 255, 255) BorderColor:nil BorderWidth:0 Radius:3.0f];
    [self.saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveButton addTarget:self action:@selector(clickSave:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.saveButton];
    
}

- (void)setupConstraint {

    __weak UIViewController *weakSelf = self;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf.view).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH, [self.dataSource count]*CELLHEIGHT));
//        make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(0, 0, 200, 0));
    }];
    
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(30);
        make.right.equalTo(weakSelf.view).with.offset(-30);
        make.height.mas_equalTo(@40);
        make.bottom.equalTo(weakSelf.view).with.offset(-50);
    }];
    
}

- (void)clickSave:(CustomButton *)saveButton {
    
}

#pragma mark UITableViewDataSource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"AddressMessageCell";
    AddressMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[AddressMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell configCellWithDic:self.dataSource[indexPath.row] IndexPath:indexPath];
    
    return cell;
}

#pragma mark UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return CELLHEIGHT;
}

@end
