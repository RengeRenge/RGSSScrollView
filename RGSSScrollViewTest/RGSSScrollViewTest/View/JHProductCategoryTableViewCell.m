//
//  JHProductCategoryTableViewCell.m
//  XJCloud
//
//  Created by renge on 2021/2/19.
//  Copyright © 2021 ld. All rights reserved.
//

#import "JHProductCategoryTableViewCell.h"

@implementation JHProductCategoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.backgroundColor = selected ? [UIColor systemBackgroundColor] :  [UIColor clearColor];
    self.tintColor = selected ? nil : [UIColor grayColor];
}

- (void)tintColorDidChange {
    [super tintColorDidChange];
    self.cateName.textColor = self.tintColor;
}

@end
