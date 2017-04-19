//
//  MeasurementController.m
//  BOOK
//
//  Created by liujianji on 16/3/3.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "MeasurementController.h"
#import "UIBarButtonItem+Item.h"
#import "MeasureViewCell.h"
#import "AssDetailsController.h"
#import "directoryTool.h"
#import "releaseDetailController.h"
#import <MediaPlayer/MPMoviePlayerViewController.h>
#import "SearchViewController.h"
#import "MeasureSearchController.h"
#import "SDCycleScrollView/SDCycleScrollView.h"
#import "magazineTool.h"
#import "adverModel.h"
#import "advertController.h"
#import"directoryTool.h"
#import "ReviewModel.h"

@interface MeasurementController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,SDCycleScrollViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
//定义控件
{
    UIView *headerView;
    UIButton  *tempBtn;
    UIView *tempView;
    //    UITableView *tabView;
    UIScrollView *tableScorllView;
    NSInteger page;
    CGFloat tempX;
    NSMutableArray *CarArray;
    NSMutableArray *countryArray;
    NSMutableArray *sportsArray;
    NSInteger car;
    NSInteger count;
    NSInteger sport;
    MPMoviePlayerViewController *movie;
    UIScrollView *scrollview;
    UIPageControl *pagecontrol;
    UIImageView *imageview;
    NSMutableArray *recommendedArray;
   
    NSMutableArray *dataSource;
    NSMutableArray * titleArray;
    
    //    int page;
    int pageNo;//页数
    NSString *type;//类型
    
}
@end

@implementation MeasurementController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=NO;
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"我的"] highImage:[UIImage imageNamed:@"我的"] target:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    //轿车
    titleArray=[NSMutableArray array];
    
    recommendedArray=[NSMutableArray array];
    dataSource=[NSMutableArray array];
    
    CarArray=[[NSMutableArray alloc]init];
    car=1;
    //越野
    countryArray=[[NSMutableArray alloc]init];
    count=1;
    //跑车
    sportsArray=[[NSMutableArray alloc]init];
    
    sport=1;
    pageNo=1;
   [directoryTool getPcName:^(id responseObject) {
       NSArray *array1=responseObject;
       for (ReviewModel *model  in array1) {
           [titleArray addObject:model];
           
       }
       
       NSLog(@"%@",array1);
       [self createFrame];
       [self initDate];

   } failure:^(NSError *error) {
       
   }];
    
  
          // Do any additional setup after loading the view.
}
//加载广告
-(void)initBookImageDate:(SDCycleScrollView *)scorView{
    
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        scorView.imageURLStringsGroup = recommendedArray;
        ;
    });


}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
   }
//关闭左侧页面
-(void)openOrCloseLeftList{
    
    AppDelegate *tempDelegate=(AppDelegate *)[[UIApplication sharedApplication  ] delegate];
    if(tempDelegate.LeftSlideVC.closed){
        [tempDelegate.LeftSlideVC openLeftView];
        
    }else{
        [tempDelegate.LeftSlideVC closeLeftView];
        
    }
}
//加载页面
-(void)createFrame{
    
 
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"搜索"] highImage:[UIImage imageNamed:@"搜索"] target:self action:@selector(searchface) forControlEvents:UIControlEventTouchUpInside];
    //创建头部试图
    headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, 44)];
    [self.view addSubview:headerView];

    for (int i=0; i<3; i++) {
        CGFloat width=self.view.width/3;
        CGFloat height=44;
        CGFloat x=i*width;
        CGFloat y=0;
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(x , y , width , height)];
        btn.tag=i+10;
        [headerView addSubview:btn];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
        btn.titleLabel.textAlignment=NSTextAlignmentCenter;
        ReviewModel *model=[titleArray objectAtIndex:i];
        
        [btn setTitle:model.name forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(checkcycle:) forControlEvents:UIControlEventTouchUpInside];
        if(i==0){
            //跟踪按钮
           tempBtn=btn;
//            [tempBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            tempView=[[UIView alloc]initWithFrame:CGRectMake(0, height-3, width, 3)];
            tempView.backgroundColor=RedColor;
            [headerView addSubview:tempView];
        }
        
    }
    
    CGFloat y=CGRectGetMaxY(headerView.frame);
    CGFloat scHight = scrollview.size.height;
    tableScorllView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, y+scHight, self.view.width, self.view.height-y-scHight-44)];
    tableScorllView.contentSize=CGSizeMake(CZScreenW*3, tableScorllView.height);
    [self.view addSubview:tableScorllView];
    tableScorllView.delegate=self;
//    tableScorllView.scrollEnabled=YES;
    tableScorllView.scrollEnabled=NO;
    tableScorllView.pagingEnabled=YES;
       //循环创建表格
    for (int i=0; i<3; i++) {
        CGFloat  tableX=i*CZScreenW;
        CGFloat tableH=tableScorllView.height;
        
        UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(tableX,0, CZScreenW,tableH )];
        tableView.tag=100+i;
        tableView.delegate=self;
        tableView.dataSource=self;
        tableView.sectionFooterHeight=5;
        tableView.emptyDataSetSource = self;
        tableView.emptyDataSetDelegate = self;

        [tableScorllView addSubview:tableView];
        [tableView headerBeginRefreshing];
        tableView.separatorStyle=UITableViewCellSelectionStyleNone;
        
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CZScreenW, 150) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        //    tableView.tableHeaderView=cycleScrollView2;
        cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        //    cycleScrollView2.titlesGroup = titles;
        cycleScrollView2.currentPageDotColor = [UIColor whiteColor];
        [magazineTool PicListAvder:^(id responseObject) {
            NSArray *array1=responseObject;
              [recommendedArray removeAllObjects];
            for (adverModel *avder in array1) {
                NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LOCAL,avder.slide_pic]];
                NSLog(@"%@",[NSString stringWithFormat:@"%@%@",LOCAL,avder.slide_pic]);
                //           NSLog(@"%@")
                [dataSource addObject:avder];
                
                
                [recommendedArray addObject: url];
                
            }
            [self initBookImageDate:cycleScrollView2];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        } failure:^(NSError *error) {
            
        }];
        tableView.tableHeaderView=cycleScrollView2;
        
        //添加上拉刷新
        if(tableView.tag==100){
//            [tableView addLegendHeaderWithRefreshingTarget:self  refreshingAction:@selector(refreshCar)];
            [tableView addHeaderWithTarget:self action:@selector(refreshCar)];
            
        }else if (tableView.tag==101){
//            [tableView addLegendHeaderWithRefreshingTarget:self  refreshingAction:@selector(refreshCount)];
            [tableView addHeaderWithTarget:self action:@selector(refreshCount)];
        }else{
//            [tableView addLegendHeaderWithRefreshingTarget:self  refreshingAction:@selector(refreshSport)];
            [tableView addHeaderWithTarget:self action:@selector(refreshSport)];

        }
        
    }
}

//刷新汽车
-(void)refreshCar{
    car++;
    ReviewModel *model=[titleArray objectAtIndex:0];
    
    [directoryTool MagineDirectory:[model.term_id integerValue] andPageNO:car success:^(id responseObject) {
        NSArray *array=responseObject;
        if(array.count==0){
            [MBProgressHUD showError:@"最新数据" toView:self.view];
        }else{
            for (DirectoryModel * model in array) {
                [CarArray addObject:model];
            }
        }
        UITableView *tableView = [self.view viewWithTag:100];

        [tableView headerEndRefreshing];
        
    } andfailure:^(NSError *error) {
        UITableView *tableView = [self.view viewWithTag:100];
        [tableView footerEndRefreshing];
        [MBProgressHUD showError:@"网络不给力" toView:self.view];
        NSLog(@"%@",error);
    }];
    
}
//刷新越野
-(void)refreshCount{
    count++;
      ReviewModel *model=[titleArray objectAtIndex:1];
    [directoryTool MagineDirectory:[model.term_id integerValue] andPageNO:count success:^(id responseObject) {
        NSArray *array=responseObject;
        if(array.count==0){
            [MBProgressHUD showError:@"最新数据" toView:self.view];
            
        }else{
            for (DirectoryModel * model in array) {
                [countryArray addObject:model];
            }
        }
        UITableView *tableView = [self.view viewWithTag:101];
       [tableView headerEndRefreshing];
    } andfailure:^(NSError *error) {
        UITableView *tableView = [self.view viewWithTag:101];
        [tableView footerEndRefreshing];

        [MBProgressHUD showError:@"网络不给力" toView:self.view];
        NSLog(@"%@",error);
    }];
    
}
//刷新跑车
-(void)refreshSport{
    sport++;
      ReviewModel *model=[titleArray objectAtIndex:2];
    [directoryTool MagineDirectory:[model.term_id integerValue] andPageNO:sport success:^(id responseObject) {
        NSArray *array=responseObject;
        if(array.count==0){
            [MBProgressHUD showError:@"最新数据" toView:self.view];
        }else{
            for (DirectoryModel * model in array) {
                [sportsArray addObject:model];
            }
        }
        UITableView *tableView = [self.view viewWithTag:102];
      [tableView headerEndRefreshing];
        
    } andfailure:^(NSError *error) {
        UITableView *tableView = [self.view viewWithTag:102];
        [tableView footerEndRefreshing];

        [MBProgressHUD showError:@"网络不给力" toView:self.view];
        NSLog(@"%@",error);
    }];
    
}
//点击跳转页面
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    adverModel *model=dataSource[index];
    
    if (model.slide_url.length!=0) {
        advertController *avder=[[advertController alloc]init];
        avder.hidesBottomBarWhenPushed=YES;
        
        avder.urlStr=model.slide_url;
        [self.navigationController pushViewController:avder animated:YES];
    }

    
}

//加载数据
-(void)initDate{
    //轿车
     ReviewModel *model=[titleArray objectAtIndex:0];
    [directoryTool MagineDirectory:[model.term_id integerValue] andPageNO:car success:^(id responseObject) {
//        [CarArray removeAllObjects];
        

        CarArray=responseObject;
        UITableView *tabView=[self.view viewWithTag:100];
        [tabView reloadData];
//        tabView.tableHeaderView=cycleScrollView2;
        
        
    } andfailure:^(NSError *error) {
        
    }];
    //越野
    
    ReviewModel *model1=[titleArray objectAtIndex:1];
    [directoryTool MagineDirectory:[model1.term_id integerValue] andPageNO:count success:^(id responseObject) {
//        [countryArray removeAllObjects];
        
        countryArray=responseObject;
        UITableView *tabView=[self.view viewWithTag:101];
        [tabView reloadData];
//         tabView.tableHeaderView=cycleScrollView2;
    } andfailure:^(NSError *error) {
        
    }];
    //跑车
     ReviewModel *model2=[titleArray objectAtIndex:2];
    [directoryTool MagineDirectory:[model2.term_id integerValue] andPageNO:sport success:^(id responseObject) {
//        [sportsArray removeAllObjects];
        
        
        sportsArray=responseObject;
        
        UITableView *tabView=[self.view viewWithTag:102];
        [tabView reloadData];
//         tabView.tableHeaderView=cycleScrollView2;
    } andfailure:^(NSError *error) {
        
    }];
    
}

//点击事件
-(void)checkcycle:(UIButton *)btn{
    CGFloat x=btn.x;
    CGFloat y=btn.height;
    page=btn.tag-10;
    tempView.frame=CGRectMake(x, y-3 , self.view.width/3, 3);
    if(btn.tag==tempBtn.tag){
        return;
        
    }else{
        [tempBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        tempBtn=btn;
        CGPoint point=tableScorllView.contentOffset;
        point.x=CZScreenW*(btn.tag-10);
        tableScorllView.contentOffset=point;
//        [tempBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    for (int i=0; i<3; i++) {
        UITableView *tabView=[self.view viewWithTag:100+i];
        [tabView headerEndRefreshing];
        
    }
//    [self initDate];
    
}


//加载数据
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MeasureViewCell *cell=[MeasureViewCell cellWithTableView:tableView];
    DirectoryModel *model;
    switch (tableView.tag) {
        case 100:
            model=CarArray[indexPath.row];
            break;
        case 101:
            model=countryArray[indexPath.row];
            break;
        case 102:
            model=sportsArray[indexPath.row];
            break;
            
        default:
            break;
    }
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",LOCAL,model.thumb];
    //设置类容
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:urlstr]];
    cell.lblTitle.text=[NSString stringWithFormat:@"%@",model.title];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.lblTime.text=[NSString stringWithFormat:@"%@",model.post_date];
    return cell;
    
}
//表格点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

   
    DirectoryModel *model;

      switch (tableView.tag) {
        case 100:
            model=CarArray[indexPath.row];
            break;
        case 101:
            model=countryArray[indexPath.row];
            break;
        case 102:
            model=sportsArray[indexPath.row];
            break;
            
        default:
            break;
    }
    if(model.wlurl==nil){
        releaseDetailController *detail=[[releaseDetailController alloc]init];
        detail.navigationItem.title=NSLocalizedString(@"Assessment details", @"Assessment details");
        detail.postId=model.post_id;
        detail.ID=model.ID;
        
        detail.hidesBottomBarWhenPushed=YES;
        
        [self.navigationController pushViewController:detail animated:YES];
    }else{
       
        advertController *avder=[[advertController alloc]init];
        avder.urlStr=model.wlurl;
        [self.navigationController pushViewController:avder animated:YES];
        
    }
  
    
//    detail.postId
}
//返回高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
//返回表格行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (tableView.tag) {
        case 100:
            return    [CarArray count];
            break;
        case 101:
            
            return    [countryArray count];
            break;
        case 102:
            return    [sportsArray count];
            break;
        default:
            return 0;
            
            break;
    }
    
}
//返回表格组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//搜索
-(void)searchface{
 
    MeasureSearchController *searchview = [[MeasureSearchController alloc] init];
    searchview.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchview animated:YES];

}
#pragma mark ---------DZNEmptyDataSetSource------

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString * string = NSLocalizedString(@"Oh, oh, there is no data!", @"Oh, oh, there is no data!");
    return [[NSAttributedString alloc]initWithString:string attributes:nil];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}



//返回标题文字
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"blankpage_image_Sleep"];
}

@end
