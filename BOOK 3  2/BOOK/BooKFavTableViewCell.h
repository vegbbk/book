//
//  BooKFavTableViewCell.h
//  BOOK
//
//  Created by liujianji on 16/3/7.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BooKFavTableViewCell : UITableViewCell
@property(strong,nonatomic)UIImageView *imgView;
@property(strong,nonatomic)UILabel *bookName;
+(instancetype)CellWithTableView:(UITableView *)tableView;

@end
