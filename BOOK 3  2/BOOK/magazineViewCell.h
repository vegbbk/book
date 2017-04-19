//
//  magazineViewCell.h
//  BOOK
//
//  Created by liujianji on 16/3/4.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface magazineViewCell : UICollectionViewCell
/**
 *图片封面
 */
@property(strong,nonatomic)UIImageView *imgView;
/**
 *图片名称
 */
@property(strong,nonatomic)UILabel *labName;
+(instancetype)cellCollectionWith:(UICollectionView *)collectionView :(NSIndexPath *)indexPath;

@end
