//
//  BBSPagerController.m
//  BOOK
//
//  Created by wangyang on 16/6/23.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "BBSPagerController.h"
#import "releaseDetailController.h"
#import "BBSModel.h"
#import "ReleaseInfomationController.h"
@interface BBSPagerController ()<ViewPagerDataSource,ViewPagerDelegate,jumpDelegate>
@property(strong,nonatomic)NSArray *titleArray;
@property(strong,nonatomic)NSMutableArray *BBsSource;

@end

@implementation BBSPagerController

- (void)viewDidLoad {
//    self.title=@"论坛";
    self.delegate=self;
    self.dataSource=self;
    
     _titleArray=[NSArray arrayWithObjects:NSLocalizedString(@"today", @"today"),NSLocalizedString(@"week", @"week"),NSLocalizedString(@"month", @"month"), nil];
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"我的"] highImage:[UIImage imageNamed:@"我的"] target:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem= [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"我的发布"] highImage:[UIImage imageNamed:@"我的发布"] target:self action:@selector(clikerelease) forControlEvents:UIControlEventTouchUpInside];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
    self.tabBarController.tabBar.hidden=NO;
    self.navigationController.navigationBar.translucent=YES;
    self.automaticallyAdjustsScrollViewInsets=NO;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    [super viewDidLoad];

    
    // Do any additional setup after loading the view.
}
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
//我的发布
-(void)clikerelease{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *phoneAccount=[ud objectForKey:@"userid"];
    if (phoneAccount==nil) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Notlogged", @"Notlogged")];
        
    }else{
        ReleaseInfomationController *release=[[ReleaseInfomationController alloc]init];
        release.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:release animated:NO];
    }
    
    
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
        label.text = _titleArray[index];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
       [label sizeToFit];
    }

    return label;
    
    
}

-(UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color{
    switch (component) {
        case ViewPagerIndicator:
            return [UIColor redColor];
            
            break;
            
        default:
            break;
    }
    return color;
    
}
-(UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index{
    _BBSTable=[[BBSTableController alloc]init];
    _BBSTable.dataSorce=_BBsSource;
    _BBSTable.dateIndex=index+1;
    _BBSTable.delegate=self;
   
    return _BBSTable;
    
}
-(CGFloat )viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value{
    switch (option) {
        case ViewPagerOptionCenterCurrentTab:
            return 1.0;
            break;
            case ViewPagerOptionStartFromSecondTab :
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
-(void)jumpToVideo:(BBSModel *)model{
    releaseDetailController *detail=[[releaseDetailController alloc]init];
    detail.hidesBottomBarWhenPushed = YES;
    detail.postId=model.post_id;
    detail.ID=model.ID;
    detail.post_hits = model.showid;
    detail.navigationItem.title=NSLocalizedString(@"BBS details", @"BBS details");
    [self.navigationController pushViewController:detail animated:NO];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
