//
//  XJLabelCollectionReusableView.m
//  kdy
//
//  Created by renge on 2018/8/8.
//  Copyright © 2018年 Ningbo Xiaojiang IOT Technology Co., LTD. All rights reserved.
//

#import "XJLabelCollectionReusableView.h"

CGFloat const XJLabelCollectionViewMinimalHeight = 20.f;
NSString *XJLabelCollectionReusableViewId = @"XJLabelCollectionReusableViewId";

@implementation XJLabelCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.blackView = [[UIView alloc] init];
    self.blackView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.blackView];
    
    self.label = [[UILabel alloc] init];
    [self addSubview:self.label];
    
    self.seperator = [UIView new];
    self.seperator.backgroundColor = UIColor.secondarySystemBackgroundColor;
    [self addSubview:self.seperator];
}

- (void)setHideBlackView:(BOOL)hideBlackView {
    if (_hideBlackView == hideBlackView) {
        return;
    }
    _hideBlackView = hideBlackView;
    self.blackView.hidden = hideBlackView;
    [self setNeedsLayout];
}

- (void)setLabelMarginLeft:(CGFloat)labelMarginLeft {
    if (_labelMarginLeft == labelMarginLeft) {
        return;
    }
    _labelMarginLeft = labelMarginLeft;
    [self setNeedsLayout];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configUI];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    if (!_hideBlackView) {
        self.blackView.frame = CGRectMake(XJLabelCollectionViewMinimalHeight, (bounds.size.height - XJLabelCollectionViewMinimalHeight) / 2.f, 5, XJLabelCollectionViewMinimalHeight);
    }
    CGFloat lead = _labelMarginLeft;
    if (!_hideBlackView) {
        lead += CGRectGetMaxX(self.blackView.frame);
    }
    self.label.frame = CGRectMake(lead, (bounds.size.height - XJLabelCollectionViewMinimalHeight) / 2.f, bounds.size.width - 10 - lead, XJLabelCollectionViewMinimalHeight);
    
    self.seperator.frame = CGRectMake(lead, bounds.size.height - 2, bounds.size.width - lead, 1);
}

@end
