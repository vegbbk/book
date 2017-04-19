//
//  PDFDownloadedCell.h
//  BOOK
//
//  Created by wangyang on 16/6/27.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFDownloadManager.h"
#import "ZFSessionModel.h"
@interface PDFDownloadedCell : UITableViewCell
@property(strong,nonatomic)UILabel *fileNameLabel;
@property(strong,nonatomic)UILabel *sizeLabel;
@property(strong,nonatomic)UIImageView *imgView;
@property(nonatomic,strong)ZFSessionModel *SessionModel;
+(instancetype)CellWithTableView:(UITableView *)tabView;


@end
