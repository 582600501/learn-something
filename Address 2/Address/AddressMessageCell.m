//
//  AddressMessageCell.m
//  Address
//
//  Created by Crystal on 16/12/19.
//  Copyright © 2016年 crystal. All rights reserved.
//

#import "AddressMessageCell.h"
#import "Masonry.h"
#import "UILabel+JustifyAlignment.h"

@interface AddressMessageCell ()
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UISwitch *addressSwitch;
@property (nonatomic, strong) UILabel *regionLabel;
@end

@implementation AddressMessageCell

#pragma mark lifecycle methods
- (void)awakeFromNib {
    [super awakeFromNib];

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.detailTextLabel setTextColor:[UIColor grayColor]];
    }
    
    return self;
}

#pragma mark private methods
- (void)setupConstraint {
    
    UITableViewCell *weakSelf = self;

    CGRect originFrame = self.textLabel.frame;
    [self.textLabel setFrame:CGRectMake(originFrame.origin.x, originFrame.origin.y, 70, originFrame.size.height)];
    [self.textLabel JustifyAlignment];
    
    if ([self.textField superview]) {
        
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.textLabel.mas_right).with.offset(20);
            make.right.top.bottom.equalTo(weakSelf.contentView).with.offset(0);
        }];
        
    } else if ([self.regionLabel superview]) {
        [self.regionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.textLabel.mas_right).with.offset(20);
            make.right.top.bottom.equalTo(weakSelf.contentView).with.offset(0);
            //make.right.equalTo(weakSelf.contentView).with.offset(-10);
        }];
        
    } else if ([self.addressSwitch superview]) {
        [self.addressSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-10);
            make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        }];
    } else {
        
    }
    
}

#pragma mark public methods
- (void)configCellWithDic:(NSDictionary *)dic IndexPath:(NSIndexPath *)indexPath {
    
    [self.textLabel setText:dic[@"title"]];
    self.textLabel.backgroundColor = [UIColor greenColor];
    
    switch (indexPath.row) {
        case 0:
        {
            [self.contentView addSubview:self.textField];
            [self.textField setPlaceholder:dic[@"placehoder"]];
        }
            break;
        case 1:
        {
            [self.contentView addSubview:self.textField];
            [self.textField setPlaceholder:dic[@"placehoder"]];
        }
            break;
        case 2:
        {
            [self.contentView addSubview:self.regionLabel];
            [self.regionLabel setText:dic[@"placehoder"]];
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 3:
        {
            [self.contentView addSubview:self.textField];
            [self.textField setPlaceholder:dic[@"placehoder"]];
        }
            break;
        case 4:
        {
            [self.contentView addSubview:self.addressSwitch];
            [self.detailTextLabel setText:dic[@"subtitle"]];
        }
            break;
            
        default:
            break;
    }

    [self setupConstraint];
}

#pragma mark property methods
- (UITextField *)textField {
    
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectZero];
    }
    
    return _textField;
}

- (UISwitch *)addressSwitch {
    
    if (!_addressSwitch) {
        _addressSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    }
    
    return _addressSwitch;
}

- (UILabel *)regionLabel {
    
    if (!_regionLabel) {
        _regionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_regionLabel setTextColor:[UIColor colorWithRed:199/255.0 green:199/255.0 blue:205/255.0 alpha:1.0]];
    }
    
    return _regionLabel;
}

@end
