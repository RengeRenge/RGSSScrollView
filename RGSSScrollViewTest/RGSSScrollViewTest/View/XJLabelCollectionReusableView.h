//
//  XJLabelCollectionReusableView.h
//  kdy
//
//  Created by renge on 2018/8/8.
//  Copyright © 2018年 Ningbo Xiaojiang IOT Technology Co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const XJLabelCollectionViewMinimalHeight;
extern NSString *XJLabelCollectionReusableViewId;

@interface XJLabelCollectionReusableView : UICollectionReusableView

@property (nonatomic, strong) UIView *blackView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *seperator;

@property (nonatomic, assign) BOOL hideBlackView;
@property (nonatomic, assign) CGFloat labelMarginLeft;

@end
