//
//  ZBRootTool.m
//  ZBWeiBo
//
//  Created by teacher on 15-12-7.
//  Copyright (c) 2015年 Cycle. All rights reserved.
//

#import "ZBRootTool.h"
//得到上一次版本号
#define ZBVersionKey @"version"
#import "AppDelegate.h"

#import "ZBNewFeatureController.h"




@implementation ZBRootTool
//选择根控制器
+(void)chooseRootViewController:(UIWindow *)window
{
      
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults]objectForKey:ZBVersionKey];
    AppDelegate *tempAppDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        
        tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        tempAppDelegate.main  =[[CZTabBarController alloc]init];
        LeftSortsViewController   *leftVC=[[LeftSortsViewController alloc]init];
        tempAppDelegate.navc=[[UINavigationController alloc]initWithRootViewController:tempAppDelegate.main];
        tempAppDelegate.navc.navigationController.navigationBarHidden=NO;
        
        
        tempAppDelegate.LeftSlideVC=[[LeftSlideViewController alloc]initWithLeftView:leftVC andMainView:tempAppDelegate.navc ];
        
        ZBKeyWindow.rootViewController=tempAppDelegate.LeftSlideVC;
    }else{
        ZBNewFeatureController *new = [[ZBNewFeatureController alloc]init];
        window.rootViewController = new;
        //储存当前的
        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:ZBVersionKey];
    }
    
    
    
    
    
    
    
//    //1.获取当前的版本号
//    NSString *currentVersion=[NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
//      //2.获取上一次版本号
//    NSString *lastVersion=[[NSUserDefaults standardUserDefaults]objectForKey:ZBVersionKey];
////判断当前是否有新的版本
//    if ([currentVersion isEqualToString:lastVersion]) {
//        //没有新版本
//        //创建tabBarViewController
//        ZBTabBarController *tabBar=[[ZBTabBarController alloc]init];
//        //设置窗口的根控制器
//        window.rootViewController =tabBar;
//    }
//    else{
//        //有新版本
//        //进入新特性
//        //如果有新特性，进入新特性界面
//        ZBNewFeatureController *cz=[[ZBNewFeatureController alloc]init];
//        window.rootViewController=cz;
//        //保存当前的版本,用偏好设置
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//        [ud setObject:currentVersion forKey:ZBVersionKey];
//    }
}
@end
