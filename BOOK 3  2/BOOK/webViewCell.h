//
//  webViewCell.h
//  BOOK
//
//  Created by wangyang on 16/3/29.
//  Copyright © 2016年 liujianji. All rights reserved.
//
@protocol webViewCellDelegate <NSObject>

-(void)getWithPhoto:(NSMutableArray *)array andindex:(NSInteger)index;


@end
#import <UIKit/UIKit.h>

@interface webViewCell : UICollectionViewCell
@property(nonatomic,strong)UIWebView *wbView;
@property(nonatomic,copy)NSString *urlStr;
+(instancetype)cellCollectionWith:(UICollectionView *)collectionView :(NSIndexPath *)indexPath;
@property(assign,nonatomic)id <webViewCellDelegate>Delegate;

@end
