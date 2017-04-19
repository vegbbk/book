//
//  BBSTableController.h
//  BOOK
//
//  Created by wangyang on 16/6/23.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BBSModel;
@protocol jumpDelegate <NSObject>

-(void)jumpToVideo:(BBSModel *)model;

@end
@interface BBSTableController : UITableViewController
@property(strong,nonatomic)NSMutableArray *dataSorce;
@property(assign,nonatomic)NSInteger dateIndex;
@property(assign,nonatomic)id<jumpDelegate>delegate;

@end
