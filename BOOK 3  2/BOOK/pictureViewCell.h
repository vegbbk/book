//
//  pictureViewCell.h
//  BOOK
//
//  Created by liujianji on 16/3/9.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pictureViewCell : UICollectionViewCell
@property(strong,nonatomic)UIImageView *imgView;
+(instancetype)cellCollectionWith:(UICollectionView *)collectionView :(NSIndexPath *)indexPath;
@end
