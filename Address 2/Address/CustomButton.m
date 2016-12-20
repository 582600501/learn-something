//
//  CustomButton.m
//  Address
//
//  Created by Crystal on 16/12/20.
//  Copyright © 2016年 crystal. All rights reserved.
//

#import "CustomButton.h"
#define RGB(a, b, c) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:1.0]

@interface CustomButton ()
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) CGFloat radius;
@end

@implementation CustomButton

#pragma mark public methods
- (instancetype)initWithFrame:(CGRect)frame NormalColor:(UIColor *)normalColor SelectedColor:(UIColor *)selectedColor TextColor:(UIColor *)textColor BorderColor:(UIColor *)borderColor BorderWidth:(CGFloat)borderWidth Radius:(CGFloat)radius {
    
    if (self = [super initWithFrame:frame]) {
        self.normalColor = normalColor;
        self.selectedColor = selectedColor;
        self.textColor = textColor;
        self.borderColor = borderColor;
        self.borderWidth = borderWidth;
        self.radius = radius;
        [self setupUI];
    }
    
    return self;
}

#pragma mark lifecycle methods
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        [self setupUI];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}


- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self setupUI];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
}

#pragma mark pravite methods
- (void)setupUI {
    
    self.borderWidth ? self.layer.borderWidth = self.borderWidth : 0;
    self.borderColor ? self.layer.borderColor = self.borderColor.CGColor : RGB(255, 255, 255).CGColor;
    self.radius ? self.layer.cornerRadius = self.radius : 0;
    self.radius ? (self.layer.masksToBounds = YES) : (self.layer.masksToBounds = NO);
    
    UIColor *normalColor = [UIColor whiteColor];
    UIColor *highLightColor = [UIColor whiteColor];
    
    self.normalColor ? normalColor = self.normalColor : normalColor;
    self.selectedColor ? highLightColor = self.selectedColor : highLightColor;
    
    [self setBackgroundImage:[self imageWithColor:normalColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[self imageWithColor:highLightColor] forState:UIControlStateHighlighted];
    
    UIColor *titleColor = [UIColor blackColor];
    self.textColor ? titleColor = self.textColor : titleColor;
    
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    [self setTitleColor:titleColor forState:UIControlStateHighlighted];
    [self setTitleColor:titleColor forState:UIControlStateDisabled];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return colorImage;
}

@end
