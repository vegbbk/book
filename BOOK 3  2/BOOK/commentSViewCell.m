//
//  commentSViewCell.m
//  BOOK
//
//  Created by liujianji on 16/3/10.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "commentSViewCell.h"
#import "Masonry.h"
@implementation commentSViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self createFrame];
        
    }
    return self;
    
}
-(void)createFrame{
    _headImage=[[UIImageView alloc]init];
    [self addSubview:_headImage];
    _LabName=[[UILabel alloc]init];
    [self addSubview:_LabName];
    _textView=[[UITextView alloc]init];
    [self addSubview:_textView];
    _LabTime=[[UILabel alloc]init];
    [self addSubview:_LabTime];
    
   
//  _LabTime.text=[NSString stringWithFormat:@"刚刚"];
//   _textView.text=[NSString stringWithFormat:@"昨天"];
    
}
-(void)layoutSubviews{
    _headImage.frame=CGRectMake(10, 5, 45, 45);
    CGFloat nickx=CGRectGetMaxX(_headImage.frame)+10;
    _headImage.layer.cornerRadius=22.5;
    _headImage.layer.masksToBounds=YES;
    
    _LabName.frame=CGRectMake(nickx, 15, 150, 20);
    _LabName.font=[UIFont systemFontOfSize:14];
    
    _LabTime.frame=CGRectMake(CZScreenW-100, 15, 100, 20);
    _LabTime.textColor=[UIColor lightGrayColor];
    _LabTime.font=[UIFont systemFontOfSize:13];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(35);
        make.left.equalTo(self.mas_left).offset(nickx);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.right.equalTo(self.mas_right).offset(-5);
    }];
   // _textView.frame=CGRectMake(nickx, 35, CZScreenW-nickx-10, 30);
    _textView.textColor=[UIColor lightGrayColor];
    _textView.font=[UIFont systemFontOfSize:14];
    
    [_textView resignFirstResponder];
    _textView.userInteractionEnabled=NO;
    
}
+(instancetype)cellWithTableView:(UITableView *)tabView{
    static NSString *ID=@"acell";
    
    id cell=[tabView dequeueReusableCellWithIdentifier:ID ];
    if(cell==nil){
        cell =[[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
