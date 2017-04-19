//
//  magazineViewController.m
//  BOOK
//
//  Created by liujianji on 16/3/3.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "magazineViewController.h"
#import "UIBarButtonItem+Item.h"
#import "magazineViewCell.h"
#import "homeModel.h"
#import "magazineModel.h"
#import "HomePageTool.h"
#import "magazineTool.h"
#import "adverModel.h"
#import "advertController.h"
#import "DownloadController.h"
#import "ZFDownloadManager.h"
#import "DownBookController.h"
//#import "ContentDetailController.h"
//#import "DownPDFController.h"
#import "DirectoryController.h"
#import "bookInfoLJJViewController.h"
@interface magazineViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    UIView *headView;//头部试图;
    UIImageView *coverView;
    UIButton *Btnreading;
    UIButton *Btndownload;
    UILabel *labTime;
    UICollectionView *collecView;//集合试图
    NSMutableArray *dataSource;
    NSMutableArray *magazineArray;
    NSString *term_id;
    NSURL  * videoUrl;
    
}

@end

@implementation magazineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self createFrame];
    [self createViewLJJ];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSLocalizedString(@"Magazine details", @"Magazine details");
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"返回"] highImage:[UIImage imageNamed:@"返回"] target:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    //self.tabBarController.tabBar.hidden=NO;
    self.navigationController.navigationBar.translucent=NO;
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
    [magazineTool Getad:^(id responseObject) {
        NSString *status=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"status"]];
        if([status isEqualToString:@"1"]){
            NSString *urtStr=[NSString stringWithFormat:@"%@%@",LOCAL,[responseObject objectForKey:@"adUrl"]];
            videoUrl=[NSURL URLWithString:urtStr];
            
        }
    } failure:^(NSError *error) {
        
    }];


  
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];

    if (dataSource==nil) {
            dataSource=[NSMutableArray array];
    }
    if (magazineArray==nil) {
          magazineArray =[NSMutableArray array];
      
    }
    [self initDate];
    NSLog(@"asdfasfasdfas%@",[ud objectForKey:@"term_id"]);
  //刷新数据
//    [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    
//    [HomePageTool Magazine:self.IDstr success:^(id responseObject) {
//        NSArray *array=responseObject;
//        [dataSource removeAllObjects];
//        
//        for ( homeModel *homemodel in array ) {
//            
//            [dataSource addObject:homemodel];
//        }
////        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        
//        if (dataSource.count!=0) {
//            
//        }
//    } failure:^(NSError *error) {
//        
//    }];
//   
//    [magazineTool advertising:^(id responseObject) {
//        NSArray *array1=responseObject;
//        [magazineArray removeAllObjects];
//        
//        for (adverModel *avder in array1) {
//            [magazineArray addObject: avder];
//            
//        }
//        [collecView reloadData];
//    } failure:^(NSError *error) {
//        
//    }];

}

//实现通知的方法
-(void)notice:(NSNotification *)notifice{
    term_id=[notifice.userInfo objectForKey:@"term_id"];
}
-(void)initDate{
//    if (dataSource.count!=0) {
//        homeModel *home=[dataSource objectAtIndex:0];
        NSString *imgurl=nil;
        imgurl=[NSString stringWithFormat:@"%@%@",LOCAL,self.postImagName];
        [coverView sd_setImageWithURL:[NSURL URLWithString:imgurl] placeholderImage:[UIImage imageNamed:@"杂志大图"]];
//        labTime.text=home.post_title;
//    }
    

}

- (void) openOrCloseLeftList
{
//    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    
//    if (tempAppDelegate.LeftSlideVC.closed)
//    {
//        [tempAppDelegate.LeftSlideVC openLeftView];
//    }
//    else
//    {
//        [tempAppDelegate.LeftSlideVC closeLeftView];
//    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ------------------------------------------------新杂志页面开始-------------------------------------------------------------

-(void)createViewLJJ{

    coverView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CZScreenW, CZScreenH-64-40)];
    coverView.userInteractionEnabled=YES;
    [self.view addSubview:coverView];

    UIButton * readButton = [UIButton buttonWithType:UIButtonTypeCustom];
    readButton.frame = CGRectMake(0, CZScreenH-40-64, CZScreenW/2.0, 40);
    readButton.backgroundColor = RGBACOLOR(0, 0, 0, 1);
    [readButton setTitle:NSLocalizedString(@"reading", @"reading") forState:UIControlStateNormal];
    [readButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [readButton addTarget:self action:@selector(clikeReading) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:readButton];
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor whiteColor];
    lineView.frame = CGRectMake(CZScreenW/2.0, CZScreenH-40-64, 1, 40);
    [self.view addSubview:lineView];
    
    Btndownload=[[UIButton alloc]initWithFrame:CGRectMake(CZScreenW/2.0+1, CZScreenH-40-64, CZScreenW/2.0, 40)];
     Btndownload.backgroundColor = RGBACOLOR(0, 0, 0, 1);
    Btndownload.titleLabel.font=[UIFont systemFontOfSize:14];
    
    [Btndownload setTitle:NSLocalizedString(@"download", @"download") forState:UIControlStateNormal];
    Btndownload.titleLabel.textColor=WhiteColor;
    //下载文件
    [Btndownload addTarget:self action:@selector(clikeDownload) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btndownload];

}

#pragma mark ------------------------------------------------新杂志页面结束-------------------------------------------------------------

//创建视图
-(void)createFrame{
    headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, CZScreenW,CZScreenH*0.55 )];
    [self.view addSubview:headView];
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
//    headView.backgroundColor=[UIColor redColor];
    
    collecView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, CZScreenH*0.53, CZScreenW, CZScreenH*0.27) collectionViewLayout:layout];
    collecView.scrollEnabled=NO;
    
    [self.view addSubview:collecView];
    collecView.backgroundColor=[UIColor whiteColor];
    collecView.delegate=self;
    collecView.dataSource=self;
    [collecView registerClass :[ magazineViewCell class ] forCellWithReuseIdentifier : @"cell" ];
    coverView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 15, CZScreenW*0.6, headView.height*0.85)];
//    coverView.image=[UIImage imageNamed:@"杂志大图"];
    coverView.userInteractionEnabled=YES;
   //添加手势
    UITapGestureRecognizer *tapGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clikeReading)];
    tapGes.numberOfTapsRequired=1;
    [coverView addGestureRecognizer:tapGes];

    [headView addSubview:coverView];
    labTime=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(coverView.frame)+10,coverView.height*0.5 , CZScreenW*0.35, 20)];
    labTime.font=[UIFont systemFontOfSize:15];
    labTime.textColor=[UIColor grayColor];
    
    [headView addSubview:labTime];
    Btnreading=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(coverView.frame)+10,coverView.height*0.8,CZScreenW*0.3,30)];
    Btnreading.backgroundColor=[UIColor redColor];
    [Btnreading setTitle:NSLocalizedString(@"reading", @"reading") forState:UIControlStateNormal];
    Btnreading.titleLabel.textColor=WhiteColor;
       Btnreading.titleLabel.font=[UIFont systemFontOfSize:14];
  //添加事件
    [Btnreading addTarget:self action:@selector(clikeReading) forControlEvents:UIControlEventTouchUpInside];
    
    [headView addSubview:Btnreading];
    
    Btndownload=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(coverView.frame)+10, CGRectGetMaxY(coverView.frame)-30, CZScreenW*0.3, 30)];
    [Btndownload setBackgroundImage:[UIImage imageNamed:@"下载"] forState:UIControlStateNormal];
    Btndownload.titleLabel.font=[UIFont systemFontOfSize:14];
    
    [Btndownload setTitle:NSLocalizedString(@"download", @"download") forState:UIControlStateNormal];
    Btndownload.titleLabel.textColor=WhiteColor;
    //下载文件
    [Btndownload addTarget:self action:@selector(clikeDownload) forControlEvents:UIControlEventTouchUpInside];
    
    [headView addSubview:Btndownload];
    
    
}
//阅读
-(void)clikeReading{
    
    
        bookInfoLJJViewController * info = [[bookInfoLJJViewController alloc]init];
        info.hidesBottomBarWhenPushed=YES;
        info.videoUrl = videoUrl;
        info.postIDStr = self.postIDStr;
        info.IDstr = self.IDstr;
        info.comment_count = self.comment_count;
        info.post_hits = self.post_hits;
        [self.navigationController pushViewController:info animated:YES];
       // [self.navigationController pushViewController:detail animated:NO];
    
 // 获取视频地址
//    [magazineTool Getad:^(id responseObject) {
//        NSString *status=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"status"]];
//        if([status isEqualToString:@"1"]){
//            NSString *urtStr=[NSString stringWithFormat:@"%@%@",LOCAL,[responseObject objectForKey:@"adUrl"]];
//            detail.videoUrl=[NSURL URLWithString:urtStr];
//            
//        }
//   } failure:^(NSError *error) {
//       
//   }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [magazineArray count];
    
    
}
#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 的大小



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    magazineViewCell *cell=[magazineViewCell cellCollectionWith:collecView :indexPath];
    adverModel *model=magazineArray[indexPath.row];
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",LOCAL,model.slide_pic];
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"图层 2"]];
      cell.labName.text=[NSString stringWithFormat:@"%@",model.slide_name];
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    adverModel *model=magazineArray[indexPath.row];
    if (model.slide_url.length!=0) {
        advertController *avder=[[advertController alloc]init];
        avder.hidesBottomBarWhenPushed=YES;
        
        avder.urlStr=model.slide_url;
        [self.navigationController pushViewController:avder animated:YES];
    }
   
  
    
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
    
}
- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath

{
    
    return CGSizeMake ( CZScreenW/3-20 ,CZScreenH*0.21 );
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 5, 5, 10);
    
}
//下载文件
-(void)clikeDownload{

    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *phoneAccount=[ud objectForKey:@"userid"];
//    dic[@"user_id"]=phoneAccount;
    if (phoneAccount==nil) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Notlogged", @"Notlogged")];
        
    }else{
       // if (dataSource.count!=0) {
          //  homeModel *model=[dataSource objectAtIndex:0];
            if ([self.POsturl isEqualToString:@""]) {
                 [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Download address is empty", @"Download address is empty")];
            }else{
                [[ZFDownloadManager sharedInstance]download:self.POsturl andBookName:self.name andImage:coverView.image progress:^(CGFloat progress, NSString *speed, NSString *remainingTime, NSString *writtenSize, NSString *totalSize) {
                    
                } state:^(DownloadState state) {
                    
                }];
                DownBookController *down=[[DownBookController alloc]init];
                down.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:down animated:YES];
            }
      //  }
        
    }
}

@end
