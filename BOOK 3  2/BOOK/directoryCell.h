//
//  directoryCell.h
//  BOOK
//
//  Created by wangyang on 16/3/24.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface directoryCell : UICollectionViewCell
@property(strong,nonatomic)UIImageView *imgView;
/**
 *图片名称
 */
@property(strong,nonatomic)UILabel *labName;
+(instancetype)cellCollectionWith:(UICollectionView *)collectionView :(NSIndexPath *)indexPath;

@end
