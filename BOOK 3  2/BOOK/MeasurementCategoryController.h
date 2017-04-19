//
//  MeasurementCategoryController.h
//  BOOK
//
//  Created by wangyang on 16/6/23.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DirectoryModel.h"
#import "adverModel.h"

@protocol jumpMeasureDelegate <NSObject>

-(void)jumpMesure:(DirectoryModel *)model;

-(void)jumpWebView:(adverModel *)model;

@end
@interface MeasurementCategoryController : UITableViewController

@property(nonatomic,assign)NSUInteger dateNum;
@property(nonatomic,strong)NSMutableArray *dataSrouce;
@property(nonatomic,strong)NSMutableArray *urlArray;
@property(nonatomic,assign)id <jumpMeasureDelegate>delegate;

@end
