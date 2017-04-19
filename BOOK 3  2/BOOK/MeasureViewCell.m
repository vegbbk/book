//
//  MeasureViewCell.m
//  BOOK
//
//  Created by liujianji on 16/3/4.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "MeasureViewCell.h"

@implementation MeasureViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setUpAllChildView];
        [self setViewFrame];
        
    }
    return self;
}
//创建视图
-(void)setUpAllChildView{
    _imgView=[[UIImageView alloc]init];
    _lblTitle=[[ljjLabel alloc]init];
    _lblTime=[[UILabel alloc]init];
    
    _lblTitle.numberOfLines=2;
    _lblTitle.lineBreakMode = NSLineBreakByCharWrapping;
    [self addSubview:_imgView];
    [self addSubview:_lblTime];
    [self addSubview:_lblTitle];
}

-(void)setViewFrame{
    _imgView.frame=CGRectMake(15, 15, 70, 70);
    _lblTitle.frame=CGRectMake(90, 15, CZScreenW-115, 45);
    _lblTime.frame=CGRectMake(90, CGRectGetMaxY(_lblTitle.frame)+10, CZScreenW-100, 15);
    _lblTitle.font=[UIFont systemFontOfSize:15];
    _lblTime.font=[UIFont systemFontOfSize:13];
    _lblTime.textColor=[UIColor grayColor];
    _lblTitle.textColor=[UIColor blackColor];
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView{
   static NSString *acell=@"aCell";
    id cell=[tableView dequeueReusableCellWithIdentifier:acell];
    if(cell==nil){
        cell=[[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:acell];
        
    }
    return cell;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
