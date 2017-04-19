//
//  DownLoadBookCell.h
//  BOOK
//
//  Created by wangyang on 16/6/15.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownLoadBookCell : UITableViewCell
@property(strong,nonatomic)UIImageView *bookImgView;
@property(strong,nonatomic)UIButton *btnswitch;
@property(strong,nonatomic)UILabel *bookName;
@property(strong,nonatomic)UIProgressView *progresss;
@property(strong,nonatomic)UILabel *bookSize;
@property(strong,nonatomic)UILabel *bookSpend;
@property(strong,nonatomic)UILabel *downSize;

+(instancetype)CellWithTableView:(UITableView *)tabView;

@end
