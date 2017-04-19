//
//  ZBNewFeatureCell.h
//  ZBWeiBo
//
//  Created by teacher on 15-12-14.
//  Copyright (c) 2015年 Cycle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"
#import "LeftSortsViewController.h"
#import "CZTabBarController.h"

@interface ZBNewFeatureCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView  *imageView;
@property (nonatomic, weak) UIButton *shareButton;

@property (nonatomic, weak) UIButton *startButton;

// 判断是否是最后一页
//+(instancetype)cellCollectionWith:(UICollectionView *)collectionView :(NSIndexPath *)indexPath;

-(void)setIndexPath:(NSIndexPath *)indexPath count:(int)count;
@end
