//
//  BooKFavTableViewCell.m
//  BOOK
//
//  Created by liujianji on 16/3/7.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "BooKFavTableViewCell.h"

@implementation BooKFavTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
    [self setUpAllChildView];
    }
    return self;
    
}
//加载试图
-(void)setUpAllChildView{
    _imgView=[[UIImageView alloc]init];
    [self addSubview:_imgView];
    _bookName=[[UILabel alloc]init];
    _bookName.font = [UIFont systemFontOfSize:15];
    _bookName.numberOfLines = 0;
    [self addSubview:_bookName];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    _imgView.frame=CGRectMake(10, CZScreenW*0.05, CZScreenW*0.3, CZScreenW*0.2);
//    _imgView.contentMode=UIViewContentModeScaleAspectFill;
    
    _bookName.frame=CGRectMake(CGRectGetMaxX(_imgView.frame)+6, 10, CZScreenW-CGRectGetMaxX(_imgView.frame)-10-6, self.frame.size.height-20);
    
}
+(instancetype)CellWithTableView:(UITableView *)tableView{
    static NSString *ID=@"cell";
    
    id cell=[tableView dequeueReusableCellWithIdentifier:ID ];
    if(cell==nil){
        cell =[[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
   
    }
    
    return cell;
    
}
@end
