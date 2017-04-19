//
//  CZHttpTool.h
//  传智微博
//
//  Created by apple on 15-3-10.
//  Copyright (c) 2015年 apple. All rights reserved.
//  处理网络的请求

#import <Foundation/Foundation.h>

@interface CZHttpTool : NSObject

/**
 *  发送get请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;


/**
 *  发送post请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)Post:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

/**
 *上传多张图片
 */
+(void)postImage:(NSString *)URLString parameters:(id)parameters imageFile:(UIImage *)file fileKey:(NSString *)fileKey success:(void (^)(NSDictionary *responseObject))success failure:(void (^)(NSError *error))failure;
/**
 *上传头像
 *
 *  @param URLString  <#URLString description#>
 *  @param parameters <#parameters description#>
 *  @param file       <#file description#>
 *  @param fileKey    <#fileKey description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 */
+(void)PostHeadImage:(NSString *)URLString parameters:(id)parameters imageFile:(UIImage *)file fileKey:(NSString *)fileKey success:(void (^)(NSDictionary *responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  POST图片
 *
 *  @param suburl         子路径
 *  @param params         额外传的键值对
 *  @param imagePathArray 图片本地缓存路径数组
 *  @param imageKeyArray       图片对应的key数组
 *  @param success
 *  @param failure
 *  @param progressBlock  进度条
 */
+ (void)postWithURL:(NSString *)suburl params:(NSDictionary *)params formDataArray:(NSArray *)imagePathArray imageKeyArray:(NSArray *)imageKeyArray success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure progressBlock:(void (^)(double progress))progressBlock;

@end
