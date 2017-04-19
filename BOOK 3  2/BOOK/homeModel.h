//
//  homeModel.h
//  BOOK
//
//  Created by liujianji on 16/3/15.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "magazineModel.h"
@interface homeModel : NSObject
/**
 *杂志Id
 */
@property(nonatomic,copy)NSString *term_id;
/**
 *杂志标题
 */
@property(nonatomic,copy)NSString *post_title;
/**
 *杂志中文图片
 */
@property(nonatomic,copy)NSString *type_img1;

@property(nonatomic,copy)NSString *smeta;//不知道什么玩意
/**
 *杂志英文图片
 */
@property(nonatomic,copy)NSString *type_img2;
/**
 *杂志类型
 */
@property(nonatomic,assign)NSInteger term_type;
/**
 *杂志类型
 */
@property(nonatomic,copy)NSArray * list;
/*
 *杂志ID
 */
@property(nonatomic,copy)NSString *ID;
/*
 *下载地址
 */
@property(nonatomic,copy)NSString *downurl;
@property(nonatomic,copy)NSString *pdf_url;
@property(nonatomic,copy)NSString *post_keywords;
@property(nonatomic,copy)NSString *comment_count;
@property(nonatomic,copy)NSString *post_hits;
@property(nonatomic,copy)NSString *post_id;
@end
