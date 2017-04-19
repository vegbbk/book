

//
//  DownLoadBookCell.m
//  BOOK
//
//  Created by wangyang on 16/6/15.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "DownLoadBookCell.h"

@implementation DownLoadBookCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createFrame];
    }
    return self;
    
}
//创建视图
-(void)createFrame{
    _bookImgView=[[UIImageView alloc]initWithFrame:CGRectMake(10,10 , 150, 80)];

    [self addSubview:_bookImgView];
    _btnswitch=[[UIButton alloc]initWithFrame:_bookImgView.bounds];
    [self addSubview:_btnswitch];
    _btnswitch.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.3];
    [_btnswitch addTarget:self action:@selector(clikeSwitch:) forControlEvents:UIControlEventTouchUpInside];
    [_btnswitch setTitle:@"开始" forState:UIControlStateNormal];
     _btnswitch.titleLabel.textColor=[UIColor whiteColor];
     _btnswitch.selected=NO;
    _btnswitch.titleLabel.font=[UIFont systemFontOfSize:13];
    
    [_bookImgView addSubview:_btnswitch];
    _bookName=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_bookImgView.frame)+10, 20, 150, 20)];
    _bookName.font=[UIFont systemFontOfSize:13];
    [self addSubview:_bookName];
    _progresss=[[UIProgressView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_bookImgView.frame)+5, 40, CZScreenW-_progresss.x, 5)];
    _progresss.progress=0.0;
    
    [self addSubview:_progresss];
}
- (void)awakeFromNib {

}
-(void)clikeSwitch:(UIButton *)btn{
    if (btn.selected==YES) {
        btn.selected=NO;
        [btn setTitle:@"暂停" forState:UIControlStateNormal];
    }else{
        btn.selected=YES;
          [btn setTitle:@"开始" forState:UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
+(instancetype)CellWithTableView:(UITableView *)tabView{
   static NSString *acell=@"cell";
    id  cell=[tabView dequeueReusableCellWithIdentifier:acell];
    if (cell==nil) {
        cell=[[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:acell];
     }
    return cell;
    
}
@end
