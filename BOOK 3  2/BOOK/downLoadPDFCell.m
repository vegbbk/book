//
//  downLoadPDFCell.m
//  BOOK
//
//  Created by wangyang on 16/4/11.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "downLoadPDFCell.h"
//#import "AFHTTPRequestOperation.h"
@implementation downLoadPDFCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
      
        
        [self createFrame];
        
    }
    return self;
    
}
//创建视图
-(void)createFrame{
  
    _imgView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, CZScreenW*0.3, 120)];
    [self addSubview:_imgView];
    _imgView.userInteractionEnabled=YES;
    _imgView.image=[UIImage imageNamed:@"图层 3"];
//    _btnDownUp=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, CZScreenW*0.3, 120)];
    //下载方法
//    _btnDownUp.titleLabel.textAlignment=NSTextAlignmentCenter;
//    _btnDownUp.selected=NO;
//    
//    [_btnDownUp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_btnDownUp setTitle:@"下载中" forState:UIControlStateNormal];
//    _btnDownUp.titleLabel.font=[UIFont systemFontOfSize:13];
//    _btnDownUp.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.3];
//    
//    [_btnDownUp addTarget:self action:@selector(downloadClike:) forControlEvents:UIControlEventTouchUpInside];
//    _btnDownUp.titleEdgeInsets = UIEdgeInsetsMake(40, -_btnDownUp.titleLabel.bounds.size.width-50, 0, 0);
//    [_imgView addSubview:_btnDownUp];
    
    //名称
    _labName=[[UILabel alloc]initWithFrame:CGRectMake(CZScreenW*0.4, 50, 150, 20)];
    _labName.textColor=[UIColor lightGrayColor];
    _labName.font=[UIFont systemFontOfSize:13];
    _labName.text=@"哈哈";
    [self addSubview:_labName];
  //进度条
//    _proGress=[[UIProgressView alloc]initWithFrame:CGRectMake(CZScreenW*0.4, 120*0.5, CZScreenW*0.5, 5)];
////    _proGress.progress=0;
//    _proGress.trackTintColor=[UIColor whiteColor];
//    //设置进度默认值，这个相当于百分比，范围在0~1之间，不可以设置最大最小值
//    _proGress.progress=0.2;
//    //设置进度条上进度的颜色
//    _proGress.progressTintColor=[UIColor blueColor];
//     [self addSubview:_proGress];
    //速度
//    _speedlab=[[UILabel alloc]initWithFrame:CGRectMake(CZScreenW-40, 100, 40, 20)];
//    _speedlab.tintColor=[UIColor lightGrayColor];
//    _speedlab.font=[UIFont systemFontOfSize:13];
//    _speedlab.text=@"2.1";
//    
//    [self addSubview:_speedlab];
    //大小
//    _sizeLab=[[UILabel alloc]initWithFrame:CGRectMake(CZScreenW*0.4, 100, 100, 20)];
//    _sizeLab.textColor=[UIColor grayColor];
//    _sizeLab.font=[UIFont systemFontOfSize:13];
//    [self addSubview:_sizeLab];
//    _sizeLab.text=@"321/850";
    
}
+(instancetype)CellWithTableView:(UITableView *)tableView{
    static NSString *ID=@"cell";
    
    id cell=[tableView dequeueReusableCellWithIdentifier:ID ];
    if(cell==nil){
        cell =[[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
    
}
-(void)downloadClike:(UIButton *)btn{
   
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
