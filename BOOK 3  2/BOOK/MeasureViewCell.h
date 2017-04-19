//
//  MeasureViewCell.h
//  BOOK
//
//  Created by liujianji on 16/3/4.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"ljjLabel.h"
@interface MeasureViewCell : UITableViewCell
@property(strong,nonatomic)UIImageView *imgView;
@property(strong,nonatomic)UILabel *lblTime;
@property(strong,nonatomic)ljjLabel *lblTitle;
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
