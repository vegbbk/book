//
//  downLoadPDFCell.h
//  BOOK
//
//  Created by wangyang on 16/4/11.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AFHTTPRequestOperation.h"
@interface downLoadPDFCell : UITableViewCell
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UIButton *btnDownUp;
@property(nonatomic,strong)UIProgressView *proGress;
@property(nonatomic,strong)UILabel *labName;
@property(nonatomic,strong)UILabel *speedlab;
@property(nonatomic,strong)UILabel *sizeLab;
//@property(nonatomic,strong)  AFHTTPRequestOperation *operation;
+(instancetype)CellWithTableView:(UITableView *)tableView;
@end
