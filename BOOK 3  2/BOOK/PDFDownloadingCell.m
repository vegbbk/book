//
//  PDFDownloadingCell.m
//  BOOK
//
//  Created by wangyang on 16/6/27.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "PDFDownloadingCell.h"

@implementation PDFDownloadingCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self CreateFrame];
    }
    return self;
    
}
//创建控件
-(void)CreateFrame{
    _bookImgView=[[UIImageView alloc]initWithFrame:CGRectMake(10,10 , 80, 100)];
    _bookImgView.userInteractionEnabled=YES;
    
    [self addSubview:_bookImgView];
    _downloadBtn=[[UIButton alloc]initWithFrame:_bookImgView.bounds];
    [_downloadBtn setTitle:@"暂停" forState:UIControlStateSelected];
    [_downloadBtn setTitle:@"开始 " forState:UIControlStateNormal];

     [_downloadBtn addTarget:self action:@selector(clickDownload:) forControlEvents:UIControlEventTouchUpInside];
    _downloadBtn.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.3];
    [_downloadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _downloadBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [_bookImgView addSubview:_downloadBtn];
    
      //名称
    _fileNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 10, CZScreenW-120, 20)];
    _fileNameLabel.font=[UIFont systemFontOfSize:13];
    _fileNameLabel.textColor=[UIColor blackColor];
    [self addSubview:_fileNameLabel];
    _progressLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 90, 150, 20)];
    _progressLabel.textColor=[UIColor blackColor];
    _progressLabel.font=[UIFont systemFontOfSize:13];
    
    [self addSubview:_progressLabel];
    //速度
    _speedLabel=[[UILabel alloc]initWithFrame:CGRectMake(CZScreenW-80, 90 , 80, 20)];
    _speedLabel.textColor=[UIColor blackColor];
    _speedLabel.font=[UIFont systemFontOfSize:13];
    
    [self addSubview:_speedLabel];
    
   
    
    _progress=[[UIProgressView alloc]initWithFrame:CGRectMake(110, 70, CZScreenW-120, 2)];
    _progress.progress=0.0;
    [self addSubview:_progress];
    
    
    
}
- (void)clickDownload:(UIButton *)sender {
    if (self.downloadBlock) {
        self.downloadBlock(sender);
    }
   
}
- (void)awakeFromNib {
    // Initialization code
}
+(instancetype)CellWithTableView:(UITableView *)tabView{
    static NSString *acell=@"bcell";
    id  cell=[tabView dequeueReusableCellWithIdentifier:acell];
    if (cell==nil) {
        cell=[[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:acell];
    }
    return cell;
    
}
- (void)setSessionModel:(ZFSessionModel *)sessionModel
{
    _sessionModel = sessionModel;
    self.fileNameLabel.text = sessionModel.bookName;
    _bookImgView.image=sessionModel.image;
    
    NSUInteger receivedSize = ZFDownloadLength(sessionModel.url);
    
    NSString *writtenSize = [NSString stringWithFormat:@"%.2f %@",
                             [sessionModel calculateFileSizeInUnit:(unsigned long long)receivedSize],
                             [sessionModel calculateUnit:(unsigned long long)receivedSize]];
    CGFloat progress = 1.0 * receivedSize / sessionModel.totalLength;
    self.progressLabel.text = [NSString stringWithFormat:@"%@/%@ ",writtenSize,sessionModel.totalSize];
    self.progress.progress = progress;
//    self.speedLabel.text = @"已暂停";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
