//
//  UILabel+JustifyAlignment.m
//  Address
//
//  Created by Crystal on 16/12/20.
//  Copyright © 2016年 crystal. All rights reserved.
//

#import "UILabel+JustifyAlignment.h"
#import <CoreText/CoreText.h>

@implementation UILabel (JustifyAlignment)

- (void)JustifyAlignment {
    CGSize textSize = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: self.font} context:nil].size;
    
    CGFloat margin = (self.frame.size.width - textSize.width) / (self.text.length - 1);
    NSNumber *number = [NSNumber numberWithFloat:margin];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attributeString addAttribute:(id)kCTKernAttributeName value:number range:NSMakeRange(0, self.text.length - 1)];
    self.attributedText = attributeString;
}

@end
