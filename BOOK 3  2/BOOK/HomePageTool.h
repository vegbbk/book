//
//  HomePageTool.h
//  BOOK
//
//  Created by liujianji on 16/3/14.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "magazinContentModel.h"
@interface HomePageTool : NSObject

//请求首页数据
+(void)HomePage :(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
//杂志首页数据
+(void)Magazine :(NSString *)term_id  success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
//查看杂志
+(void)ShowtextContent:(NSString *)BookId success:(void(^)(magazinContentModel *responseObject))success failure:(void(^)(NSError *error))failure;
//杂志目录
+(void)ShowTExtList:(NSString *)term_id success:(void(^)(id responseObject ))success failure:(void(^)(NSError *error))failure;

@end
