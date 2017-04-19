//
//  commentsModel.h
//  BOOK
//
//  Created by wangyang on 16/3/25.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface commentsModel : NSObject
//
@property(nonatomic,copy)NSString *content;
//评论时间
@property(nonatomic,copy)NSString *createtime;
//手机号码
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *avatar;

@end
