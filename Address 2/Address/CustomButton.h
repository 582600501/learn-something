//
//  CustomButton.h
//  Address
//
//  Created by Crystal on 16/12/20.
//  Copyright © 2016年 crystal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButton : UIButton
- (instancetype)initWithFrame:(CGRect)frame NormalColor:(UIColor *)normalColor SelectedColor:(UIColor *)selectedColor TextColor:(UIColor *)textColor BorderColor:(UIColor *)borderColor BorderWidth:(CGFloat)borderWidth Radius:(CGFloat)radius;
@end
