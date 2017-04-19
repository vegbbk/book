//
//  BBSTableController.m
//  BOOK
//
//  Created by wangyang on 16/6/23.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "BBSTableController.h"
#import "BBSViewCell.h"
#import "BBSModel.h"
#import "BBSTool.h"
@interface BBSTableController ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>{

    UILabel * notilabel;
}
@property(assign,nonatomic)BOOL isRemoveAll;
@property(assign,nonatomic)NSInteger numPage;

@end

@implementation BBSTableController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    _numPage=1;
      if (_dataSorce==nil) {
          _dataSorce=[NSMutableArray array];

    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"我的"] highImage:[UIImage imageNamed:@"我的"] target:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];

    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self loadData];
    [self.tableView addHeaderWithTarget:self action:@selector(pushDone)];

    [self.tableView addFooterWithTarget:self action:@selector(pushUp)];
    
    notilabel = [[UILabel alloc]init];
    notilabel.frame = CGRectMake(0, CZScreenH/2.0-100, CZScreenW, 20);
    notilabel.text = NSLocalizedString(@"Stay tuned for", @"Stay tuned for");
    notilabel.textColor = [UIColor lightGrayColor];
    notilabel.textAlignment = NSTextAlignmentCenter;
    notilabel.hidden = YES;
    notilabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:notilabel];
    
    self.tableView.headerPullToRefreshText = @"下拉刷新";
    self.tableView.headerReleaseToRefreshText = @"松开即可刷新";
    self.tableView.headerRefreshingText = @"加载中";
    
    self.tableView.footerPullToRefreshText = @"上拉加载更多";
    self.tableView.footerReleaseToRefreshText = @"松开即可加载更多数据";
    self.tableView.footerRefreshingText = @"加载中";

    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}
//打开或者关闭左侧视图
- (void) openOrCloseLeftList
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}

/**
 *  下拉刷新
 */
-(void)pushDone{
    _isRemoveAll=YES;
    _numPage=1;
    [self loadData];
    
}
//上拉刷新
-(void)pushUp{
    _isRemoveAll=NO;
    _numPage++;
    [self loadData];
    
}
//加载数据
-(void)loadData{
    [BBSTool BBSSource:_dateIndex andPage:_numPage success:^(id responseObject) {
        NSArray *array=responseObject;
        if (_isRemoveAll) {
            [_dataSorce removeAllObjects];
            [_dataSorce addObjectsFromArray:array];
            [self.tableView headerEndRefreshing];
            
        }else{
            [_dataSorce addObjectsFromArray:array];
            [self.tableView footerEndRefreshing];
            
        }
        
        if(_dataSorce.count>0){
        
            notilabel.hidden = YES;
        
        }else{
         notilabel.hidden = NO;
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [self.tableView footerEndRefreshing];
        [self.tableView headerEndRefreshing];

    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [_dataSorce count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BBSViewCell *cell=[BBSViewCell CellWithTableView:tableView];
    BBSModel *model=_dataSorce[indexPath.row];
    cell.model=model;
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",LOCAL,model.thumb];
//    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:urlstr]];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:urlstr] placeholderImage:[UIImage imageNamed:@"placeImage"]];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.lblTitle.text=[NSString stringWithFormat:@"%@",model.title];
    //    cell.lblTitle.backgroundColor=RedColor;
    
    cell.lblTime.text=[NSString stringWithFormat:@"%@",model.post_date];
    NSString * str1=NSLocalizedString(@"view count", @"view count");
    cell.lblbrowse.text=[NSString stringWithFormat:@" %@:%@",str1,model.showid];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CZScreenW, 100)];
    view.backgroundColor=[UIColor grayColor];
    
    cell.selectedBackgroundView=view;
    NSString * str2=NSLocalizedString(@"reply count", @"reply count");
    cell.lblReplies.text=[NSString stringWithFormat:@" %@:%@",str2,model.comment];
    
    
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BBSModel *model=_dataSorce[indexPath.row];
    
    [self.delegate jumpToVideo:model];
    
}
#pragma mark ---------DZNEmptyDataSetSource------

//- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
//    
//    NSString * string = NSLocalizedString(@"Oh, oh, there is no data!", @"Oh, oh, there is no data!");
//    return [[NSAttributedString alloc]initWithString:string attributes:nil];
//}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}



//返回标题文字
//- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return [UIImage imageNamed:@"blankpage_image_Sleep"];
//}
////返回详情文字
//- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
//    NSString *text = NSLocalizedString(@"Click refresh to refresh the data", @"Click refresh to refresh the data"); NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new]; paragraph.lineBreakMode = NSLineBreakByWordWrapping; paragraph.alignment = NSTextAlignmentCenter; NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f], NSForegroundColorAttributeName: [UIColor lightGrayColor], NSParagraphStyleAttributeName: paragraph}; return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//}
////返回可以点击的按钮 上面带文字
//- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{ NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
//    return [[NSAttributedString alloc] initWithString:NSLocalizedString(@"refresh", @"refresh") attributes:attributes];
//}
////点击button
//- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView{ // Do something
//    
//    _isRemoveAll=YES;
//    _numPage=1;
//    [self loadData];
//    
//}
//点击空白区域
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView{ // Do something
    
        _isRemoveAll=YES;
        _numPage=1;
        [self loadData];

}

@end
