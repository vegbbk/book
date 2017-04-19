//
//  BBSViewCell.m
//  BOOK
//
//  Created by liujianji on 16/3/4.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "BBSViewCell.h"
#import "AFNetworking.h"
@implementation BBSViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        [self setUpAllChildView];
        [self setViewFrame];
    }
    
    return self;
    
}
-(void)setViewFrame{
   
    
    
}
//创建视图
-(void)setUpAllChildView{
    _imgView=[[UIImageView alloc]init];
    [self addSubview:_imgView];
    _lblbrowse=[[UILabel alloc]init];
    [self addSubview:_lblbrowse];
    _lblReplies=[[UILabel alloc]init];
    [self addSubview:_lblReplies];
    _lblTime=[[UILabel alloc]init];
    [self addSubview:_lblTime];
    _lblTitle=[[UILabel alloc]init];
    [self addSubview:_lblTitle];
    _imgView.frame=CGRectMake(10, 10, 70, 70);
    _lblTitle.frame=CGRectMake(90,10 , CZScreenW-115, 20);
    _lblTime.frame=CGRectMake(90, 36, 200, 20);
    _lblbrowse.frame=CGRectMake(90, 60, 150, 20);
    _lblReplies.frame=CGRectMake(self.width-80, 60, 80, 20);
    
    _lblTitle.font=[UIFont systemFontOfSize:15];
    _lblTitle.textColor=[UIColor blackColor];
    
      _lblTitle.lineBreakMode = NSLineBreakByCharWrapping;
    _lblTime.font=[UIFont systemFontOfSize:13];
    _lblTime.textColor=[UIColor grayColor];
    _lblbrowse.font=[UIFont systemFontOfSize:13];
    _lblbrowse.textColor=[UIColor grayColor];
    _lblReplies.font=[UIFont systemFontOfSize:13];
    _lblReplies.textColor=[UIColor grayColor];

    
}
-(void)setModel:(BBSModel *)model{
    _model=model;
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",LOCAL,model.thumb];
//    [self.imgView sd_setImageWithURL:[NSURL URLWithString:urlstr]];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    self.lblTitle.text=[NSString stringWithFormat:@"%@",model.title];
    
    self.lblTime.text=[NSString stringWithFormat:@"%@",model.post_date];
    
    self.lblbrowse.text=[NSString stringWithFormat:@" 浏览次数:%@",model.showid];
    
    self.lblReplies.text=[NSString stringWithFormat:@" 回复次数:%@",model.comment];
    UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlstr];
    if (originalImage) { // 如果内存\沙盒缓存有原图，那么就直接显示原图（不管现在是什么网络状态）
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:urlstr] ];
    } else { // 内存\沙盒缓存没有原图
        AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
        if (mgr.isReachableViaWiFi) { // 在使用Wifi, 下载原图
            [self.imgView sd_setImageWithURL:[NSURL URLWithString:urlstr] ];
        } else if (mgr.isReachableViaWWAN) { // 在使用手机自带网络
          
            BOOL alwaysDownloadOriginalImage = [[NSUserDefaults standardUserDefaults] boolForKey:@"alwaysDownloadOriginalImage"];
            if (alwaysDownloadOriginalImage) { // 下载原图
                [self.imgView sd_setImageWithURL:[NSURL URLWithString:urlstr]];
            } else { // 下载小图
                [self.imgView sd_setImageWithURL:[NSURL URLWithString:urlstr]];
            }
        } else { // 没有网络
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlstr];
            if (thumbnailImage) { // 内存\沙盒缓存中有小图
                [self.imgView sd_setImageWithURL:[NSURL URLWithString:urlstr]];
            } else {
                [self.imgView sd_setImageWithURL:nil];
            }
        }
    }
}
+(instancetype)CellWithTableView:(UITableView *)tableView{
    static NSString *ID=@"cell";
    
    id cell=[tableView dequeueReusableCellWithIdentifier:ID ];
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
