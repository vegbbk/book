//
//  PDFDownloadedCell.m
//  BOOK
//
//  Created by wangyang on 16/6/27.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "PDFDownloadedCell.h"

@implementation PDFDownloadedCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self CreateFrame];
    }
    return self;
    
}

-(void)CreateFrame{
    
    _imgView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, CZScreenW*0.3, 120)];
    [self addSubview:_imgView];
    _imgView.userInteractionEnabled=YES;
    _imgView.image=[UIImage imageNamed:@"图层 3"];
       _fileNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(CZScreenW*0.4, 50, 150, 20)];
    _fileNameLabel.textColor=[UIColor lightGrayColor];
    _fileNameLabel.font=[UIFont systemFontOfSize:13];
    _fileNameLabel.text=@"哈哈";
    [self addSubview:_fileNameLabel];
    _sizeLabel=[[UILabel alloc]initWithFrame:CGRectMake(CZScreenW-90, 100, 80, 20)];
    _sizeLabel.textColor=[UIColor lightGrayColor];
    _sizeLabel.font=[UIFont systemFontOfSize:13];
    _sizeLabel.text=@"哈哈";
    [self addSubview:_sizeLabel];
   
}
-(void)setSessionModel:(ZFSessionModel *)sessionModel
{
    _SessionModel = sessionModel;
    self.fileNameLabel.text = sessionModel.bookName;
    self.sizeLabel.text = sessionModel.totalSize;
    self.imgView.image=sessionModel.image;
    
}
- (void)awakeFromNib{
    // Initialization code
}
+(instancetype)CellWithTableView:(UITableView *)tabView{
    static NSString *acell=@"acell";
    id  cell=[tabView dequeueReusableCellWithIdentifier:acell];
    if (cell==nil) {
        cell=[[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:acell];
    }
    return cell;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
