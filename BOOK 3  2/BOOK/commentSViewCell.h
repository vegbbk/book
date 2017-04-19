//
//  commentSViewCell.h
//  BOOK
//
//  Created by liujianji on 16/3/10.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commentSViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UILabel *LabName;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UILabel *LabTime;
+(instancetype)cellWithTableView:(UITableView *)tabView;
@end
