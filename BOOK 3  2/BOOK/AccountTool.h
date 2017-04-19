//
//  AccountTool.h
//  BOOK
//
//  Created by wangyang on 16/3/22.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CZHttpTool.h"
#import "AccountModel.h"
@interface AccountTool : NSObject

/**
 *获取手机验证码
 */
+(void)GetPhoneVerification:(NSString *)PhoneNum success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
/**
 *用户登录
 */
+(void)LoginUser:(NSString *)PhoneNum PassWord:(NSString *) PassWord success:(void(^)(AccountModel  *model))success failure:(void(^)(NSError *error))failure;
/**
 *用户注册
 */
+(void)registUser:(NSString *)PhoneNum PassWord:(NSString *)PassWord vcode:(NSString *)vcode success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure;
/**
 *重置密码
 */
+(void)UpdatePad:(NSString *)PhoneNum PassWord:(NSString *)PassWord vcode:(NSString *)vcode success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+(void)ModifyPwd:(NSString *)PhoneNum PassWord:(NSString *)PassWord vcode:(NSString *)vcode success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
/**
 *修改密码
 */
+(void)ModifyPwd:(NSMutableDictionary *)dic success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 *用户退出
 */
+(void)exitLoginOut:(void(^)(NSString * status))success failure:(void(^)(NSError *error))failure;
/**
 *用户收藏
 */
//+(void)MyFav:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

//服务反馈

+(void)AddMssage:(NSString *)Msg eamil:(NSString *)eamil success:(void(^)(id responseObject))success
         failure:(void(^)(NSError *error))failure;
/**
 *  删除收藏
 *
 *  @param userId  <#userId description#>
 *  @param favId   <#favId description#>
 *  @param success <#success description#>
 */
+(void)deleteFav:(NSString *)userId andfavId:(NSString *)favId andsuccess:(void(^)(id responseObject))success  andfailure:(void(^)(NSError *error))failure;;

@end
