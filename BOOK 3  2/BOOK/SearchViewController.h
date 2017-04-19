//
//  SearchViewController.h
//  BOOK
//
//  Created by DariusZhu on 16/4/3.
//  Copyright © 2016年 liujianji. All rights reserved.
//
#import "DirectoryModel.h"

@protocol  SearchViewControllerDelegate <NSObject>

-(void)SearChtext:(DirectoryModel *)direModel;


@end
#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property(assign,nonatomic)id <SearchViewControllerDelegate>delegate;

@end
