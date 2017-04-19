//
//  DetailViewController.h
//  BOOK
//
//  Created by wangyang on 16/5/19.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property(nonatomic,copy)NSString *term_id;
@property (nonatomic, strong) UIView *panelView;
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;
@property(nonatomic,copy)NSString *termAll_id;
@property(nonatomic,strong)NSMutableArray *magaArray;
@property(nonatomic,assign)NSInteger page;

@end
