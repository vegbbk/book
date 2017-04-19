//
//  ZBNewFeatureCell.m
//  ZBWeiBo
//
//  Created by teacher on 15-12-14.
//  Copyright (c) 2015年 Cycle. All rights reserved.
//

#import "ZBNewFeatureCell.h"
//#import "ZBTabBarController.h"

@interface ZBNewFeatureCell ()



@property(nonatomic,weak)AppDelegate *tempAppDelegate;

@end

@implementation ZBNewFeatureCell
-(instancetype)initWithFrame:(CGRect)frame{
    if(self ==[super initWithFrame:frame]){
        [self createFrame];
        
    }
    return self;
    
}

-(void)createFrame{
    
//        UIImageView *imageV = [[UIImageView alloc] init];
    
        
    
}
-(UIButton *)shareButton
{
    if (_shareButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"分享给大家" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn sizeToFit];
        
        [self.contentView addSubview:btn];
        
        _shareButton = btn;
        
    }
    return _shareButton;
}
////开始
- (UIButton *)startButton
{
    if (_startButton == nil) {
        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [startBtn setTitle:@"开始妙玩" forState:UIControlStateNormal];
//        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
//        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
//        [startBtn sizeToFit];
        [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:startBtn];
        _startButton = startBtn;
        
    }
    return _startButton;
}

- (UIImageView *)imageView
{
    if(_imageView==nil){
        _imageView = [[UIImageView alloc]init];
        
    [self addSubview:_imageView];

    }
    return _imageView;
    
}
//布局子控件frame
-(void)layoutSubviews
{
    [super layoutSubviews];
//    self.imageView.frame=self.bounds;
    _imageView.frame=CGRectMake(0, 0, CZScreenW, CZScreenH);

    //分享按钮
//    self.shareButton.center=CGPointMake(self.width * 0.5, self.height * 0.8);
    //开始按钮
//    self.startButton.center=CGPointMake(self.width * 0.5, self.height * 0.799);
    self.startButton.frame=CGRectMake(CZScreenW*0.23, CZScreenH*0.38, CZScreenW*0.6, 120);
    
//    self.startButton.frame.size.width=150;
    
}
//-(void)setImage:(UIImage *)image
//{
//    _image=image;
//    self.imageView.image=image;
//}
//判断当前cell是否是最后一页
-(void)setIndexPath:(NSIndexPath *)indexPath count:(int)count
{
    if (indexPath.row == count -1) {
        self.startButton.hidden=NO;
        
        self.startButton.hidden=NO;
    }
    else{
        //不是最后一页就隐藏
        self.shareButton.hidden=YES;
        self.startButton.hidden=YES;
    }
}
+(instancetype)cellCollectionWith:(UICollectionView *)collectionView :(NSIndexPath *)indexPath{
    static NSString *ID=@"acell";
    id cell=[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath ];
    
    if(cell==nil){
        cell=[collectionView dequeueReusableCellWithReuseIdentifier :ID forIndexPath :indexPath];
        
    }
    return cell;
    
}
//点击开始微博
-(void)start
{
  
    _tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _tempAppDelegate.main  =[[CZTabBarController alloc]init];
    LeftSortsViewController   *leftVC=[[LeftSortsViewController alloc]init];
   _tempAppDelegate.navc=[[UINavigationController alloc]initWithRootViewController:_tempAppDelegate.main];
    _tempAppDelegate.navc.navigationController.navigationBarHidden=NO;
    
    
  _tempAppDelegate.LeftSlideVC=[[LeftSlideViewController alloc]initWithLeftView:leftVC andMainView:_tempAppDelegate.navc ];
    
    ZBKeyWindow.rootViewController=_tempAppDelegate.LeftSlideVC;
    
    
}




@end
