//
//  DirectoryController.m
//  BOOK
//
//  Created by wangyang on 16/4/1.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "DirectoryController.h"
#import "magazineViewCell.h"
#import "DirectoryModel.h"
#import "magazineModel.h"
#import "SearchViewController.h"
#import "adverModel.h"
#import "advertController.h"
#import "SDCycleScrollView/SDCycleScrollView.h"
#import "magazineTool.h"
#import "HomePageTool.h"
#import "adverModel.h"
#import "directoryCell.h"
#import "MeasureSearchController.h"
//#import "DirectorydetailsViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "contentDetailController.h"
@interface DirectoryController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextFieldDelegate,SDCycleScrollViewDelegate>{
    UIImageView *imgView;
    UICollectionView *collecView1;
    UILabel *Labrecommended;
    UITextField *SearchFiled;
    NSMutableArray *dataSource;
    NSMutableArray *recommendedArray;
     MPMoviePlayerViewController *movie;
    NSMutableArray *magaArray;
    
}

@end

@implementation DirectoryController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
      self.navigationController.navigationBar.translucent=NO;
    recommendedArray=[NSMutableArray array];
       if (magaArray==nil) {
           magaArray=[NSMutableArray array];
    }
    if (dataSource==nil) {
         dataSource=[NSMutableArray array];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
        self.navigationItem.title=NSLocalizedString(@"directory", @"directory");
    self.view.backgroundColor=[UIColor whiteColor];
   
     [self playViode];
     [self initDate];
         self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"home"] highImage:[UIImage imageNamed:@"home"] target:self action:@selector(BackHome) forControlEvents:UIControlEventTouchUpInside];

}

-(void)initDate{
    [magazineTool directoryAvder:^(id responseObject) {
        NSArray *array1=responseObject;
        for (adverModel *avder in array1) {
            [dataSource addObject:avder];
            
            NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LOCAL,avder.slide_pic]];
            NSLog(@"%@",[NSString stringWithFormat:@"%@%@",LOCAL,avder.slide_pic]);
            [recommendedArray addObject: url];
            
        }
        [self initBookImageDate];

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        
    }];

    [HomePageTool ShowTExtList:_term_id
                       success:^(id responseObject) {
        NSArray *array1=responseObject;
        [magaArray removeAllObjects];
                           
        for (DirectoryModel *model in array1) {
            
            [magaArray addObject:model];
            
        }

        [collecView1 reloadData];
        
    } failure:^(NSError *error) {
        
    }];

}
//返回
-(void)BackHome{
   [self.navigationController popViewControllerAnimated:YES];
}
//播发视屏

-(void)playViode{
    
    movie=[[MPMoviePlayerViewController alloc]initWithContentURL:_videoUrl];
    
    
    movie.view.frame=self.view.bounds;
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(CZScreenH-60, 5, 60, 30)];
    [btn setTitle:@"exit" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    
    
//    btn.backgroundColor=[UIColor redColor];
    
    [movie.view addSubview:btn];
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(exit)];
   movie.view.transform =CGAffineTransformMakeRotation((M_PI / 2.0));
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft; //向右
    [movie.view addGestureRecognizer:swipeGesture];
    [self presentMoviePlayerViewControllerAnimated:movie];
    movie.moviePlayer.controlStyle = MPMovieControlStyleNone;
      [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:NO];
    [movie.moviePlayer play];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(exit) name:MPMoviePlayerDidExitFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exit) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}
//关闭电影
-(void)exit{
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
   

    [self createCollectVeFrame];

}

//创建目录页
-(void)createCollectVeFrame{
    UIView *v1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CZScreenW, 50)];
    [self.view addSubview:v1];
        Labrecommended=[[UILabel alloc]initWithFrame:CGRectMake(10, 15, CZScreenW*0.4, 20)];
        Labrecommended.textColor=[UIColor grayColor];
        Labrecommended.font=[UIFont systemFontOfSize:14];
    
    
        SearchFiled=[[UITextField alloc]initWithFrame:CGRectMake(CZScreenW*0.38, 10, CZScreenW*0.58, 30)];
//        SearchFiled.backgroundColor=[UIColor lightGrayColor];
//        SearchFiled.leftView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"搜索"]];
    UIImageView *leftView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 15, 15)];
    leftView.image=[UIImage imageNamed:@"搜索"];
    SearchFiled.leftView=leftView;
    //    [searchtext addSubview:leftView];
    SearchFiled.leftViewMode=UITextFieldViewModeAlways;
    
//        SearchFiled.leftViewMode=UITextFieldViewModeAlways;
    SearchFiled.delegate=self;
    SearchFiled.autocapitalizationType=UITextAutocapitalizationTypeWords;
//    SearchFiled.delegate=self;
    SearchFiled.layer.cornerRadius=7;
    SearchFiled.layer.masksToBounds=YES;
       SearchFiled.layer.borderColor=[[UIColor grayColor]CGColor];
    
    SearchFiled.layer.borderWidth=1.0;

        Labrecommended.text=@"SEARCH STYLE";
        [v1 addSubview:SearchFiled];
        [v1 addSubview:Labrecommended];
    

//    
    //创建集合时图
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    
    collecView1=[[UICollectionView alloc]initWithFrame:CGRectMake(0, CZScreenH*0.35, CZScreenW, CZScreenH*0.53) collectionViewLayout:layout];

    
        collecView1.delegate=self;
        collecView1.dataSource=self;
    collecView1.backgroundColor=[UIColor whiteColor];
    [collecView1 registerClass:[directoryCell class] forCellWithReuseIdentifier:@"cell"];
    collecView1.pagingEnabled=YES;

    [self.view addSubview:collecView1];
    UISwipeGestureRecognizer   *pan=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    pan.direction = UISwipeGestureRecognizerDirectionLeft; //向左
   
    [self.view addGestureRecognizer:pan];
//    self.view.userInteractionEnabled=YES;
    
}
-(void)panGesture:(UISwipeGestureRecognizer *)swipe{
//    UISwipeGestureRecognizer *swipe = swipe;
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        contentDetailController *direDetail=[[contentDetailController alloc]init];
        if (magaArray.count!=0) {
            DirectoryModel *maga=[magaArray objectAtIndex:0];
            direDetail.term_id=maga.term_id;
            direDetail.termAll_id=_term_id;

            [self.navigationController pushViewController:direDetail animated:YES];
        }
       

        //向左轻扫
    }
}
//刷新数据
-(void)initBookImageDate{
 
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 50, CZScreenW, 150) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    //    cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [self.view addSubview:cycleScrollView2];
    
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = recommendedArray;
    });
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if(magaArray.count<6){
        return magaArray.count;
        
    }else{
        return 6;

    }
    
}
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    adverModel *model=dataSource[index];
    if (model.slide_url.length!=0) {
        advertController *avder=[[advertController alloc]init];
        avder.hidesBottomBarWhenPushed=YES;
        
        avder.urlStr=model.slide_url;
        [self.navigationController pushViewController:avder animated:YES];
    }
    
    
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField==SearchFiled){
        [SearchFiled resignFirstResponder];
        MeasureSearchController *searchview = [[MeasureSearchController alloc] init];
        searchview.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:searchview animated:YES];
        
    }

}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 0, 0, 0);
    
}
- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath

{
    
    return CGSizeMake ( CZScreenW/3-10 ,CZScreenH*0.25 );
    
}

//点击查看文章内容
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (magaArray.count!=0) {
        contentDetailController *direDetail=[[contentDetailController alloc]init];
        DirectoryModel *maga=[magaArray objectAtIndex:indexPath.row];
        direDetail.term_id=maga.term_id;
//        eDetail.termAll_id=_te
        direDetail.termAll_id=_term_id;
        
        [self.navigationController pushViewController:direDetail animated:YES];

    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    directoryCell *cell=[directoryCell cellCollectionWith:collecView1 :indexPath];
    //        cell.backgroundColor=[UIColor redColor];
    NSString *imgurl;
  
    DirectoryModel *maga=[magaArray objectAtIndex:indexPath.row];

    imgurl=[NSString stringWithFormat:@"%@%@",LOCAL,maga.thumb];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:imgurl] placeholderImage:[UIImage imageNamed:@"图层 2"]];
//    cell.labName.text=[NSString stringWithFormat:@"%@",maga.title];
    
    cell.layer.borderColor=[[UIColor blackColor]CGColor];
    cell.layer.borderWidth=1.0;
    
    
    return cell;
    
}



@end
