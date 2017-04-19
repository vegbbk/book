//
//  releaseViewController.m
//  BOOK
//
//  Created by liujianji on 16/3/8.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "releaseViewController.h"
#import "BBSViewCell.h"
#import "BBSTool.h"
#import "BBSModel.h"
#import "ReleaseInfomationController.h"
#import "releaseDetailController.h"
@interface releaseViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UIView *headerView;
//    UITableView *tabView;
    UIButton *tempBtn;
    UIView *tempView;
    UIScrollView *tableScorllView;
    NSInteger mounth;
    NSInteger today;
    NSInteger page;
    
    CGFloat tempX;
    NSMutableArray *weekArray;
    NSMutableArray *mounthArray;
    NSMutableArray *todayArray;
    
}

@end

@implementation releaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       [self createFrame];
    self.navigationItem.title=NSLocalizedString(@"I release", @"I release");
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"返回"] highImage:[UIImage imageNamed:@"返回"] target:self action:@selector(BackHome) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem= [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"我的发布"] highImage:[UIImage imageNamed:@"我的发布"] target:self action:@selector(clikerelease) forControlEvents:UIControlEventTouchUpInside];

       if (todayArray==nil) {
         todayArray=[[NSMutableArray alloc]init];
      
         }
       today=1;
    mounthArray=[[NSMutableArray alloc]init];
    if (mounthArray==nil) {
        mounthArray=[[NSMutableArray alloc]init];
        
    }
    mounth=1;
    
    [self initDate];

}
-(void)viewDidAppear:(BOOL)animated{

}
//我的发布
-(void)clikerelease{
    ReleaseInfomationController *release=[[ReleaseInfomationController alloc]init];
    release.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:release animated:NO];
    
}
-(void)initDate{

    [BBSTool myBBS:1 success:^(id responseObject) {
        todayArray=responseObject;
        NSLog(@"asdfasdfasdfas%@",responseObject);
        
        UITableView *tabView=[self.view viewWithTag:100];
        [tabView reloadData];
    } failure:^(NSError *error) {
        
    }];
    [BBSTool myBBS:3 success:^(id responseObject) {
        mounthArray=responseObject;
        UITableView *tabView=[self.view viewWithTag:101];
        [tabView reloadData];
    } failure:^(NSError *error) {
        
    }];

    
}


-(void)BackHome{
    AppDelegate  *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [tempAppDelegate.LeftSlideVC openLeftView];
//    [self.navigationController popViewControllerAnimated:NO];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
//    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated{
//    self.navigationController.navigationBar=NO;
    self.navigationController.navigationBarHidden=NO;
    
//    self.navigationController.navigationBar.translucent=NO;
    
}
//-(void)viewWillDisappear:(BOOL)animated{
//  self.navigationController.navigationBar.translucent=YES;
//}
-(void)createFrame{
    //创建头部试图
    headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, 44)];
    [self.view addSubview:headerView];
    headerView.backgroundColor=[UIColor redColor];
    
    headerView.backgroundColor=[UIColor whiteColor];
    NSArray *array=[NSArray arrayWithObjects:NSLocalizedString(@"today", @"today"),NSLocalizedString(@"month", @"month"), nil];
    for (int i=0; i<2; i++) {
        CGFloat width=self.view.width/2;
        CGFloat height=44;
        CGFloat x=i*width;
        CGFloat y=0;
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(x , y , width , height)];
        btn.tag=i+10;
        [headerView addSubview:btn];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        [btn setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(checkcycle:) forControlEvents:UIControlEventTouchUpInside];
        
        if(i==0){
            tempBtn=btn;
//            [tempBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            tempView=[[UIView alloc]initWithFrame:CGRectMake(0, height-3, width, 3)];
            tempView.backgroundColor=RedColor;
            
            [headerView addSubview:tempView];
            
        }
    }
    CGFloat y=CGRectGetMaxY(headerView.frame);
    tableScorllView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, y, self.view.width, self.view.height-y)];
    tableScorllView.contentSize=CGSizeMake(CZScreenW*3, tableScorllView.height);
    
    [self.view addSubview:tableScorllView];
    tableScorllView.delegate=self;
    tableScorllView.scrollEnabled=YES;
    tableScorllView.pagingEnabled=YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    for (int i=0; i<2; i++) {
        CGFloat  tableX=i*CZScreenW;
        CGFloat tableH=tableScorllView.height;
    
        UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(tableX, 0 , CZScreenW,tableH ) style:UITableViewStyleGrouped];
        tableView.delegate=self;
        tableView.dataSource=self;
        
//        tableView.sectionFooterHeight=5;
//        tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
    
        tableView.backgroundColor=[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
        [tableView headerBeginRefreshing];
        tableView.tag=100+i;
        
        [tableScorllView addSubview:tableView];
       //刷新界面
//        if(tableView.tag==100){
//            [tableView addLegendHeaderWithRefreshingTarget:self  refreshingAction:@selector(refreshToday)];
//        }else{
//            [tableView addLegendHeaderWithRefreshingTarget:self  refreshingAction:@selector(refreshMonth)];
//        }
    }
}
//刷新今天
-(void)refreshToday{

    [BBSTool myBBS:1 success:^(id responseObject) {
        NSArray *array=responseObject;
        if(array.count==0){
            [MBProgressHUD showError:@"最新数据" toView:self.view];
        }else{
            for (BBSModel * model in array) {
                [todayArray addObject:model];
            }
        }
        UITableView *tableView = [self.view viewWithTag:100];
        [tableView reloadData];
        
        [tableView headerEndRefreshing];
    } failure:^(NSError *error) {
        UITableView *tableView = [self.view viewWithTag:100];
        [tableView footerEndRefreshing];
        [MBProgressHUD showError:@"网络不给力" toView:self.view];

    }];
    
}
//刷新本月
-(void)refreshMonth{
    mounth++;

    [BBSTool myBBS:3 success:^(id responseObject) {
        NSArray *array=responseObject;
        if(array.count==0){
            [MBProgressHUD showError:@"最新数据" toView:self.view];
        }else{
            for (BBSModel * model in array) {
                [mounthArray addObject:model];

            }
        }
        UITableView *tableView = [self.view viewWithTag:101];
        [tableView headerEndRefreshing];
        
        [tableView reloadData];

    } failure:^(NSError *error) {
        UITableView *tableView = [self.view viewWithTag:101];
        [tableView footerEndRefreshing];
        [MBProgressHUD showError:@"网络不给力" toView:self.view];
        
    }];

    
}
//滑动时
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint point=scrollView.contentOffset;
    page =point.x/CZScreenW;
    if(tempX==point.x){
        return;
    }else{
        tempX=point.x;
        
        tableScorllView.contentOffset=CGPointMake(page*CZScreenW, 0);
        UIButton *btn=(UIButton *)[self.view viewWithTag:page+10];
        [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        tempBtn=btn;
        [UIView beginAnimations:@"" context:nil];
        
        tempView.frame=CGRectMake(tempBtn.frame.origin.x, tempBtn.frame.origin.y+tempBtn.frame.size.height-3, tempBtn.frame.size.width, 3);
        
//        [tempBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [UIView commitAnimations];
        
        //        [self checkcycle:btn];
    }
}
//点击按钮

-(void)checkcycle:(UIButton *)btn{
    
    CGFloat x=btn.x;
   
    CGFloat y=btn.height;
    tempView.frame=CGRectMake(x, y-3 , self.view.width/2, 3);
    if(btn.tag==tempBtn.tag){
        return;
    }else{
        
        [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        tempBtn=btn;
        page=tempBtn.tag-10;
        
        CGPoint point=tableScorllView.contentOffset;
        point.x=CZScreenW*(btn.tag-10);
        tableScorllView.contentOffset=point;
        
        
//        [tempBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (tableView.tag) {
        case 100:
            return    [todayArray count];
            break;
        case 101:
            
            return    [mounthArray count];
            break;
       
        default:
            return 0;
            
            break;
    }

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BBSViewCell *cell=[BBSViewCell CellWithTableView:tableView];
    BBSModel *model;
    NSLog(@"撒发送到发送到发疯似的发生的%@",mounthArray);
    
    switch (tableView.tag) {
        case 100:
            model=todayArray[indexPath.row];
            break;
        case 101:
            model=mounthArray[indexPath.row];
            break;
        
        default:
            break;
    }
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",LOCAL,model.thumb];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:urlstr]];
    
    cell.lblTitle.text=[NSString stringWithFormat:@"%@",model.title];
    //    cell.lblTitle.backgroundColor=RedColor;
    
    cell.lblTime.text=[NSString stringWithFormat:@"%@",model.post_date];
    
    cell.lblbrowse.text=[NSString stringWithFormat:@" 浏览次数:%@",model.showid];
    
    
    cell.lblReplies.text=[NSString stringWithFormat:@" 浏览次数:%@",model.comment];
    

    
    return cell;
    
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    releaseDetailController *detail=[[releaseDetailController alloc]init];
    detail.hidesBottomBarWhenPushed = YES;
    BBSModel *model;
    NSLog(@"%@",weekArray);
    
    switch (tableView.tag) {
        case 100:
            model=todayArray[indexPath.row];
            break;
        case 101:
            model=mounthArray[indexPath.row];
            break;
        default:
            break;
    }
    
    detail.postId=model.post_id;
    detail.ID=model.ID;

    
    detail.navigationItem.title=NSLocalizedString(@"BBS details", @"BBS details");
    [self.navigationController pushViewController:detail animated:NO];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
