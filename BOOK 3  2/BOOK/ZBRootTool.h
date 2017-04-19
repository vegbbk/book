//
//  ZBRootTool.h
//  ZBWeiBo
//
//  Created by teacher on 15-12-7.
//  Copyright (c) 2015年 Cycle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LeftSlideViewController.h"
#import "LeftSortsViewController.h"
#import "CZTabBarController.h"
#import "AppDelegate.h"
#import <UIKit/UIKit.h>



@interface ZBRootTool : NSObject
//@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;
//@property (strong, nonatomic) CZTabBarController *main;
//@property(strong,nonatomic)UINavigationController *navc;
+ (void)chooseRootViewController:(UIWindow *)window;
@end
