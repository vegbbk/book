//
//  magazineContentCell.m
//  BOOK
//
//  Created by wangyang on 16/3/16.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "magazineContentCell.h"
@interface magazineContentCell(){

}


@end
@implementation magazineContentCell

//@dynamic confrmaes;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor=[UIColor clearColor];
        //添加所有的控件
        [self setUpAllChildView];
    }
    return self;
    
}
//添加所有的控件
-(void)setUpAllChildView{
  //图片
    _imgView=[[UIImageView alloc]init];
    [self addSubview:_imgView];
    //视频
    _videoView=[[UIImageView alloc]init];
    [self addSubview:_videoView];
    //内容
    _contentLab=[[UILabel alloc]init];
    [self addSubview:_contentLab];
    _contentLab.textColor=[UIColor grayColor];
    _contentLab.font=[UIFont systemFontOfSize:15];
    
    
}

//设置cell的高度
-(void)setIntroductionText:(id)model{
    
    CGRect frame=[self frame];

    NSDictionary *dic=[NSDictionary dictionaryWithDictionary:model];
        CGFloat  imageH=0;

    
    if (![dic[@"imgUrl"] isEqualToString:@""]) {
        [_imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"imgUrl"]]] placeholderImage:nil];
//    NSLog(@"%@",dic[@"imgUrl"]);
    
        imageH=150;
        
    }
    CGFloat imagex=CZStatusCellMargin;
    CGFloat imagey=imagex;
    CGFloat imagew=CZScreenW-imagex*2;
    _imgView.frame=CGRectMake(imagex, imagey, imagew, imageH);
    // 视频的位置
    CGFloat  videoH=0;
    if(![dic[@"video"] isEqualToString:@""]){
        [_videoView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic[@"video"]]] placeholderImage:nil];
        
        videoH=150;
        
        
    }
    CGFloat videox=CZStatusCellMargin;
    CGFloat videoy=CGRectGetMaxY(_imgView.frame)+CZStatusCellMargin;
    CGFloat videow=CZScreenW-videox*2;
    _videoView.frame=CGRectMake(videox, videoy, videow, videoH);
    //    CGSize textSize;
    //文字的位置
    
    CGFloat textW=CZScreenW-10;
    //    NSLog(@"%@",_contentLab.text);
    CGSize textSize=CGSizeZero;
    
    if(![dic[@"content"] isEqualToString:@""]){
        self.contentLab.text=dic[@"content"];
        textSize =  [_contentLab.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : ZBTextFont} context:nil].size;
    }
    self.contentLab.numberOfLines=MAXFLOAT;
    
    CGFloat textX=CZStatusCellMargin;
    CGFloat textY=CZStatusCellMargin+CGRectGetMaxY(_videoView.frame);
    _contentLab.frame=(CGRect){{textX,textY},textSize};
    frame.size.height=CGRectGetMaxY(_contentLab.frame);
    self.frame=frame;
    
}

- (void)awakeFromNib {
    // Initialization code
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
        
    }
    
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
