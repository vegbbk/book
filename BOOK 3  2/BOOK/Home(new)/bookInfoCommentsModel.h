//
//  bookInfoCommentsModel.h
//  BOOK
//
//  Created by liujianji on 17/2/22.
//  Copyright © 2017年 liujianji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface bookInfoCommentsModel : NSObject

@property(nonatomic,copy)NSString *content;
//评论时间
@property(nonatomic,copy)NSString *createtime;
//手机号码
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *avatar;

@end
