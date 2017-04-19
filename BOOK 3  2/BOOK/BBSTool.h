//
//  BBSTool.h
//  BOOK
//
//  Created by wangyang on 16/3/18.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CZHttpTool.h"
#import "detailsIDModel.h"
@interface BBSTool : NSObject
//论坛首页数据
+(void)BBSSource:(NSInteger )Type andPage:(NSInteger )PageNO success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
//发布论坛
+(void)releaseBBS:(NSDictionary *)dic andsuccess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
//评论列表
+(void)releaseList:(NSString *)post_id andsuccess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
//发表评论
+(void)publishedcomment:(NSString *)post_id content:(NSString *)content success:(void(^)(id responseObject ))success failure:(void(^)(NSError *error))failure;
//评论详情ID
+(void)detailSID:(NSString *)post_id success:(void(^)( id responseObject))success failure:(void(^)(NSError *error))failure;
//用户评论
+(void)post_sc:(NSString *)post_id success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
//我的发布
+(void)myBBS:(NSInteger )type success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

@end
