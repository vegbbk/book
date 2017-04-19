//
//  BBSViewCell.h
//  BOOK
//
//  Created by liujianji on 16/3/4.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBSModel.h"
@interface BBSViewCell : UITableViewCell
/**
 *图片
 */
@property(strong,nonatomic)UIImageView *imgView;
/**
 *标题
 */
@property(strong,nonatomic)UILabel *lblTitle;
/**
 *时间
 */
@property(strong,nonatomic)UILabel *lblTime;
/**
 *浏览次数
 */
@property(strong,nonatomic)UILabel *lblbrowse;
/**
 *回复量
 */
@property(strong,nonatomic)UILabel *lblReplies;
@property(strong,nonatomic)BBSModel *model;

+(instancetype)CellWithTableView:(UITableView *)tableView;

@end
