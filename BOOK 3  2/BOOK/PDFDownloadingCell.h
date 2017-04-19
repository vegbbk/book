//
//  PDFDownloadingCell.h
//  BOOK
//
//  Created by wangyang on 16/6/27.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFSessionModel.h"
typedef void(^ZFDownloadBlock)(UIButton *);

@interface PDFDownloadingCell : UITableViewCell
@property(strong,nonatomic)UIImageView *bookImgView;
@property (strong, nonatomic) UILabel *fileNameLabel;
@property (strong, nonatomic) UIProgressView *progress;

@property (strong, nonatomic) UILabel *progressLabel;
@property (strong, nonatomic) UILabel *speedLabel;
@property (strong, nonatomic) UIButton *downloadBtn;
@property (nonatomic, copy  ) ZFDownloadBlock downloadBlock;
@property (nonatomic, strong) ZFSessionModel  *sessionModel;
+(instancetype)CellWithTableView:(UITableView *)tabView;
@end
