//
//  PGIndexBannerSubiew.m
//  NewPagedFlowViewDemo
//
//  Created by Mars on 16/6/18.
//  Copyright © 2016年 Mars. All rights reserved.
//

#import "PGIndexBannerSubiew.h"

@implementation PGIndexBannerSubiew

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
              [self addSubview:self.mainImageView];
        [self addSubview:self.coverView];
        [self addSubview:self.allCoverButton];
    }
    
    return self;
}

- (UIImageView *)mainImageView {
    
    if (_mainImageView == nil) {
        
        _mainImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.mainImageView.layer.shadowColor = [UIColor greenColor].CGColor;//阴影颜色
        self.mainImageView.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
        self.mainImageView.layer.shadowOpacity = 0.5;//不透明度
        self.mainImageView.layer.shadowRadius = 10.0;//半径

    }
    return _mainImageView;
}

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] initWithFrame:self.bounds];
        _coverView.backgroundColor = [UIColor blackColor];
    }
    return _coverView;
}

- (UIButton *)allCoverButton {
    if (_allCoverButton == nil) {
        _allCoverButton = [[UIButton alloc] initWithFrame:self.bounds];
    }
    return _allCoverButton;
}

@end
