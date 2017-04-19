//
//  magazineTool.h
//  BOOK
//
//  Created by wangyang on 16/3/28.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "detailsIDModel.h"
@interface magazineTool : NSObject

+(void)Getad:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
//获取用户评论列表
+(void)magazineShow:(NSString *)postId success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
//搜索文章
+(void)Searcharticle:(NSString *)keyWords success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
//获取首页广告
+(void)advertising:(void(^)(id responseObject ))success failure:(void(^)(NSError *error))failure;
//获取目录广告
+(void)directoryAvder:(void(^)(id responseObject))success
             failure :(void(^)(NSError *error))failire;
//获取测评广告
+(void)PicListAvder:(void(^)(id responseObject))success
           failure :(void(^)(NSError *error))failire;
+(void)MagineDirectryDetail:(NSString *)term_id success:(void (^)(id responseObject))success andfailure:(void (^)(NSError * error))failure;
//详情的目录
+(void)detailAvder:(NSString *)term_id andsuccess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
//获取全部的文章
+(void)getAllcontent:(NSString *)term_id andsuccess:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

//杂志评论
+(void)magazineComment:(NSString *)post_id content:(NSString *)content success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+(void)magazineCommentsList:(NSString *)post_id andsuccess:(void (^)(id))success failure:(void (^)(NSError *))failure;
@end
