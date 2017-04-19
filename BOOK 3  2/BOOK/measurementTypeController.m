//
//  measurementTypeController.m
//  BOOK
//
//  Created by wangyang on 16/6/23.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "measurementTypeController.h"
#import "directoryTool.h"
#import "ReviewModel.h"
#import "releaseDetailController.h"
#import "advertController.h"
#import "MeasureSearchController.h"
@interface measurementTypeController ()<ViewPagerDataSource,ViewPagerDelegate,jumpMeasureDelegate>
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)NSMutableArray *measureArray;
@property(nonatomic,strong)NSMutableArray *urlArray;

@end

@implementation measurementTypeController
-(void)viewWillAppear:(BOOL)animated{
       [super viewWillAppear:YES];
    


  

}
- (void)viewDidLoad {
//    self.title=@"测评";
    self.dataSource=self;
    self.delegate=self;
    
    
//    _titleArray=[NSMutableArray arrayWithObjects:@"跑车",@"越野",@"劲动力", nil];
   
      NSArray *array1   =[NSArray arrayWithArray:measeureArray];
    
    _titleArray =[ReviewModel objectArrayWithKeyValuesArray:array1];
    
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"我的"] highImage:[UIImage imageNamed:@"我的"] target:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];

    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
    self.tabBarController.tabBar.hidden=NO;
    self.navigationController.navigationBar.translucent=YES;
    self.automaticallyAdjustsScrollViewInsets=NO;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.edgesForExtendedLayout = UIRectEdgeBottom;
  //  self.navigationItem.rightBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"搜索"] highImage:[UIImage imageNamed:@"搜索"] target:self action:@selector(searchface) forControlEvents:UIControlEventTouchUpInside];

    [super viewDidLoad];
   
}
//打开左侧页面
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
//搜索界面
-(void)searchface{
    
    MeasureSearchController *searchview = [[MeasureSearchController alloc] init];
    searchview.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchview animated:YES];
    
}
-(NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager{
    return _titleArray.count;
    
}
-(UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index{
    UILabel *label = nil;
    
    for (NSInteger i = 0; i < _titleArray.count; i++) {
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, label.frame.size.width * i, label.frame.size.width , label.frame.size.height)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:15.0];
        ReviewModel *model=_titleArray[index];
        
        label.text=model.name;

        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
        [label sizeToFit];
    }
    
    return label;
}
//返回的表格
-(UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index{
      ReviewModel *model=_titleArray[index];
    _meaCategory=[[MeasurementCategoryController alloc]init];
    _meaCategory.dataSrouce=_measureArray;
    _meaCategory.urlArray=_urlArray;
    _meaCategory.dateNum=[model.term_id integerValue];

    
    _meaCategory.delegate=self;
    return _meaCategory;
    
}
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
            
        case ViewPagerIndicator:
            
            return [UIColor redColor];
            
            break;
        default:
            break;
    }
    
    return color;
}
#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    
    switch (option) {
        case ViewPagerOptionCenterCurrentTab:
            return 1.0;
            break;
        case ViewPagerOptionStartFromSecondTab:
            return 1.0;
            break;
        case ViewPagerOptionTabLocation:
            return 1.0;
            break;
        default:
            break;
    }
    
    return value;
}
-(void)jumpMesure:(DirectoryModel *)model{
   
    if(model.wlurl==nil){
        releaseDetailController *detail=[[releaseDetailController alloc]init];
        detail.navigationItem.title=NSLocalizedString(@"Assessment details", @"Assessment details");
        detail.postId=model.post_id;
        detail.ID=model.ID;
        detail.post_hits = model.showid;
        detail.hidesBottomBarWhenPushed=YES;
        
        [self.navigationController pushViewController:detail animated:YES];
    }else{
        
        advertController *avder=[[advertController alloc]init];
        avder.urlStr=model.wlurl;
        [self.navigationController pushViewController:avder animated:YES];
        
    }

}
-(void)jumpWebView:(adverModel *)model{
    if (model.slide_url.length!=0) {
        advertController *avder=[[advertController alloc]init];
        avder.hidesBottomBarWhenPushed=YES;
        
        avder.urlStr=model.slide_url;
        [self.navigationController pushViewController:avder animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
