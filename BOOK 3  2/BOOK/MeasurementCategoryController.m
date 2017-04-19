//
//  MeasurementCategoryController.m
//  BOOK
//
//  Created by wangyang on 16/6/23.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "MeasurementCategoryController.h"
#import "MeasureViewCell.h"
#import "SDCycleScrollView.h"
#import "magazineTool.h"
#import "adverModel.h"
#import "directoryTool.h"
#import "advertController.h"

@interface MeasurementCategoryController ()<SDCycleScrollViewDelegate>{
    SDCycleScrollView *cycleScrollView2;
    
}
@property(nonatomic,assign)NSUInteger pageNum;
@property(nonatomic,assign)BOOL isRemoveAll;

@property(nonatomic,strong)NSMutableArray *slide_picArray;

@end

@implementation MeasurementCategoryController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if (_slide_picArray==nil) {
        _slide_picArray=[NSMutableArray array];
        
    }
    if (_slide_picArray.count==0) {
        [self loadUIview];
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    
    [self.tableView addHeaderWithTarget:self action:@selector(pushDones)];
    [self.tableView addFooterWithTarget:self action:@selector(pushUps)];
    self.tableView.headerPullToRefreshText = @"下拉刷新";
    self.tableView.headerReleaseToRefreshText = @"松开即可刷新";
    self.tableView.headerRefreshingText = @"加载中";
    
    self.tableView.footerPullToRefreshText = @"上拉加载更多";
    self.tableView.footerReleaseToRefreshText = @"松开即可加载更多数据";
    self.tableView.footerRefreshingText = @"加载中";
    cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CZScreenW, 150) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor];
    self.tableView.tableHeaderView=cycleScrollView2;
    _pageNum=1;
    if (_urlArray==nil) {
        _urlArray=[NSMutableArray array];
        
    }
    if (_dataSrouce==nil) {
        _dataSrouce=[NSMutableArray array];
        [self LoadData];
    }
 }
//加载视图
-(void)loadUIview{
  
    [magazineTool PicListAvder:^(id responseObject) {
        NSArray *array1=responseObject;
        [_urlArray removeAllObjects];
        [_slide_picArray removeAllObjects];
        
        for (adverModel *avder in array1) {
            NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LOCAL,avder.slide_pic]];
            NSLog(@"%@",[NSString stringWithFormat:@"%@%@",LOCAL,avder.slide_pic]);
            [_urlArray addObject:avder];
            [_slide_picArray addObject:url];
            
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cycleScrollView2.imageURLStringsGroup = _slide_picArray;
            ;
        });
        
    } failure:^(NSError *error) {
        
    }];
    
}
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    adverModel *model=_urlArray[index];
    [self.delegate jumpWebView:model];
    
}
//下拉刷新
-(void)pushDones{
    _isRemoveAll=YES;
    _pageNum=1;
    [self LoadData];
    
}
//上拉刷新
-(void)pushUps{
    _isRemoveAll=NO;
    _pageNum++;
    [self LoadData];
    
}
//加载数据
-(void)LoadData{
    [directoryTool MagineDirectory:_dateNum andPageNO:_pageNum success:^(id responseObject) {
       NSArray *array=responseObject;
        if (_isRemoveAll) {
            [_dataSrouce removeAllObjects];
            [_dataSrouce addObjectsFromArray:array];
            [self.tableView headerEndRefreshing];
            
        }else{
            [_dataSrouce addObjectsFromArray:array];
            [self.tableView footerEndRefreshing];
            
        }
        [self.tableView reloadData];

        
    } andfailure:^(NSError *error) {
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

    return _dataSrouce.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MeasureViewCell *cell=[MeasureViewCell cellWithTableView:tableView];
    DirectoryModel *model=_dataSrouce[indexPath.row];
  
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",LOCAL,model.thumb];
    //设置类容
//    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:urlstr]];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:urlstr] placeholderImage:[UIImage imageNamed:@"placeImage"]];
    
    cell.lblTitle.text=[NSString stringWithFormat:@"%@",model.title];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.lblTime.text=[NSString stringWithFormat:@"%@",model.post_date];
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     DirectoryModel *model=_dataSrouce[indexPath.row];
    [self.delegate jumpMesure:model];
    
}
@end
