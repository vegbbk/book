//
//  AppDelegate.h
//  BOOK
//
//  Created by liujianji on 16/3/3.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"
#import "CZTabBarController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;
@property (strong, nonatomic) CZTabBarController *main;
@property(strong,nonatomic)UINavigationController *navc;
@end

