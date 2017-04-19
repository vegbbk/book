//
//  CZTabBarController.m
//  传智微博
//
//  Created by apple on 15-3-4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZTabBarController.h"
#import "UIImage+Image.h"
#import "BBSViewController.h"
#import "MeasurementController.h"
#import "magazineViewController.h"
#import "HomeViewController.h"
#import "InternationalControl.h"
#import "BBSPagerController.h"
#import "measurementTypeController.h"
#import "BBSTableController.h"
@interface CZTabBarController ()

@property (nonatomic, strong) NSMutableArray *items;



@end

@implementation CZTabBarController

- (NSMutableArray *)items
{
    if (_items == nil) {
        
        _items = [NSMutableArray array];
        
    }
    return _items;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
  
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = [UIColor redColor];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleHighlightedColor,NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    self.navigationController.navigationBarHidden=YES;
    self.navigationController.navigationBar.translucent=YES;
    self.navigationController.navigationBar.barTintColor =[UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor=[UIColor whiteColor];
    NSLog(@"viewWillAppear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
    self.view.backgroundColor=[UIColor whiteColor];
//    self.tabBarController.tabBar.backgroundColor=[UIColor whiteColor];
    
    
}
//-(void)viewDidAppear:(BOOL)animated{
//  self.navigationController.navigationBarHidden=NO;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加所有子控制器
    [self setUpAllChildViewController];
    
    
    // 自定义tabBar
    [self setUpTabBar];
    
}
#pragma mark - 设置tabBar
- (void)setUpTabBar
{
    // 自定义tabBar
//    self.tabBar.backgroundImage=[UIImage imageNamed:@"矩形 1 副本 3"];
    
//    CZTabBar *tabBar = [[CZTabBar alloc] initWithFrame:self.tabBar.frame];
//    tabBar.backgroundColor = [UIColor whiteColor];
//    
//    // 设置代理
//    tabBar.delegate = self;
//    
//    // 给tabBar传递tabBarItem模型
//    tabBar.items = self.items;
//    
//    // 添加自定义tabBar
//    [self.view addSubview:tabBar];
//    
//    // 移除系统的tabBar
//    [self.tabBar removeFromSuperview];
}

#pragma mark - 当点击tabBar上的按钮调用
//- (void)tabBar:(CZTabBar *)tabBar didClickButton:(NSInteger)index
//{
//    self.selectedIndex = index;
//}
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
////    NSLog(@"%@",self.tabBar.items);
//    
//    
//}


#pragma mark - 添加所有的子控制器
- (void)setUpAllChildViewController
{
//    self.view.backgroundColor=[UIColor grayColor];
    
    // 首页
    HomeViewController *home = [[HomeViewController alloc] init];
    
    [self setUpOneChildViewController:home image:[UIImage imageNamed:@"首页"] selectedImage:[UIImage imageNamed:@"首页（选中）"] title:NSLocalizedString(@"home page", @"Home Page")];
  
//    
//    
//
//  NSString *str=KLOCALIZED_String(@"home page");
//     [self setUpOneChildViewController:home image:[UIImage imageNamed:@"首页"] selectedImage:[UIImage imageNamed:@"首页（选中）"] title:str];
    home.view.backgroundColor=[UIColor whiteColor];
    
    
//    _home = home;
    
    
    // 消息
//    magazineViewController *message = [[magazineViewController alloc] init];
//    [self setUpOneChildViewController:message image:[UIImage imageNamed:@"杂志"] selectedImage:[UIImage imageNamed:@"杂志（选中）"] title:NSLocalizedString(@"magazine", @"magazine")];
//     message.view.backgroundColor=[UIColor whiteColor];
    
    // 发现
    measurementTypeController *discover = [[measurementTypeController alloc] init];
    [self setUpOneChildViewController:discover image:[UIImage imageNamed:@"测评"] selectedImage:[UIImage imageNamed:@"测评（选中）"] title:NSLocalizedString(@"measurement", @"measurement")];

     discover.view.backgroundColor=[UIColor whiteColor];

    // 我
//    BBSViewController *profile = [[BBSViewController alloc] init];
    BBSTableController *profile=[[BBSTableController alloc]init];
    
    [self setUpOneChildViewController:profile image:[UIImage imageNamed:@"论坛"] selectedImage: [UIImage imageNamed:@"论坛（选中）"] title:NSLocalizedString(@"product", @"product")];
    profile.view.backgroundColor=[UIColor whiteColor];
   

}
// navigationItem决定导航条上的内容
// 导航条上的内容由栈顶控制器的navigationItem决定

#pragma mark - 添加一个子控制器
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
//    // navigationItem模型
//    vc.navigationItem.title = title;
//    
//    // 设置子控件对应tabBarItem的模型属性
//    vc.tabBarItem.title = title;
    vc.title = title;
    vc.tabBarItem.image = image;
//    vc.tabBarItem.selectedImage = selectedImage;
//    vc.tabBarController.tabBar.backgroundColor=[UIColor redColor];
    
    selectedImage =  [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [vc.tabBarItem setFinishedSelectedImage:selectedImage
//             withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_home"]];
    vc.tabBarItem.selectedImage=selectedImage;
    
    // 保存tabBarItem模型到数组
    [self.items addObject:vc.tabBarItem];
    
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
    
//    CZNavigationController *nav = [[CZNavigationController alloc] initWithRootViewController:vc];
   
    [self addChildViewController:nav];
}


@end
