//
//  AccountTool.m
//  BOOK
//
//  Created by wangyang on 16/3/22.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "AccountTool.h"
#import "AccountModel.h"
@implementation AccountTool
+(void)GetPhoneVerification:(NSString *)PhoneNum success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic[@"phone"]=PhoneNum;
    NSInteger lang=0;
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);

    NSString *urlString=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=send&a=sendPhoneVcode"];
        [CZHttpTool GET:urlString parameters:dic success:^(id responseObject) {
            NSLog(@"asdgasgasgasdg%@",responseObject);
            if(success){
                success([responseObject objectForKey:@"status"]);
            }
        } failure:^(NSError *error) {
            if(failure){
                failure(error);
    
            }
        }];
    
}
+(void)registUser:(NSString *)PhoneNum PassWord:(NSString *)PassWord vcode:(NSString *)vcode success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    //注册用户
    dic[@"phone"]=PhoneNum;
    dic[@"password"]=PassWord;
    dic[@"vcode"]=vcode;
    NSString *urlString=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=user&a=doReg"];
    NSInteger lang=0;
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);

    [CZHttpTool Post:urlString parameters:dic success:^(id responseObject) {

        if(success){
            
            success(responseObject);
            
        }
    } failure:^(NSError *error) {
        
    }];
    
    
}
/**
 *登录
 */
+(void)LoginUser:(NSString *)PhoneNum PassWord:(NSString *)PassWord success:(void (^)(AccountModel *))success failure:(void (^)(NSError *))failure{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    
    dic[@"phone"]=PhoneNum;
    dic[@"password"]=PassWord;
    NSInteger lang=0;
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);

    NSString *urlString=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=user&a=doLogoin"];
   

    [CZHttpTool Post:urlString parameters:dic success:^(id responseObject) {

        AccountModel *model=[AccountModel objectWithKeyValues:responseObject];
//        [MBProgressHUD showMessage:@""];

               if(success){
            success(model);
            
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            
        }
    }];
    
}
/**
 *重置密码
 */
+(void)UpdatePad:(NSString *)PhoneNum PassWord:(NSString *)PassWord vcode:(NSString *)vcode success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic[@"phone"]=PhoneNum;
    dic[@"password"]=PassWord;
    dic[@"vcode"]=vcode;
    NSInteger lang=0;
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);

    NSString *urlString=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=user&a=doPassRest"];
    [CZHttpTool Post:urlString parameters:dic success:^(id responseObject) {
//        NSString *status=[responseObject objectForKey:@"status"];
        if(success){
            success(responseObject);
            
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            
        }
    }];
}
//修改密码
+(void)ModifyPwd:(NSString *)PhoneNum PassWord:(NSString *)PassWord vcode:(NSString *)vcode success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *phoneAccount=[ud objectForKey:@"userid"];
    
    dic[@"user_id"]=phoneAccount;
    dic[@"oldpassword"]=PhoneNum;
    dic[@"password"]=PassWord;
    dic[@"repassword"]=vcode;
    NSInteger lang=0;
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);

    NSString *urlString=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=User&a=restPass"];
    [CZHttpTool Post:urlString parameters:dic success:^(id responseObject) {
//        NSString *status=[responseObject objectForKey:@"status"];
        if(success){
            success(responseObject);
            
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            
        }
    }];

}

+(void)exitLoginOut:(void (^)(NSString *))success failure:(void (^)(NSError *))failure{
  NSString *urlString=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=user&a=loginOut"];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    NSInteger lang=0;
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);
 [CZHttpTool Post:urlString parameters:nil success:^(id responseObject) {
      NSString *status=[responseObject objectForKey:@"status"];
      if(success){
          success(status);
          
      }
   
     
  } failure:^(NSError *error) {
      if(failure){
          failure(error);
          
      }
  }];
    
}

+(void)AddMssage:(NSString *)Msg eamil:(NSString *)eamil success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *phoneAccount=[ud objectForKey:@"userid"];
    dic[@"user_id"]=phoneAccount;
    dic[@"msg"]=Msg;
    dic[@"email"]=eamil;
    NSInteger lang=0;
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);
    NSString *urlString=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=User&a=addmsg"];
    
    [CZHttpTool Post:urlString parameters:dic success:^(id responseObject) {
        if(success){
            success(responseObject);
            
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            
        }
    }];

}
/**
 *  删除服务
 *
 *  @param userId  <#userId description#>
 *  @param favId   <#favId description#>
 *  @param success <#success description#>
 */
+(void)deleteFav:(NSString *)userId andfavId:(NSString *)favId andsuccess:(void (^)(id))success andfailure:(void (^)(NSError *))failure{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic[@"user_id"]=userId;
    dic[@"id"]=favId;
    NSInteger lang=0;
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=Magazine&a=post_del"];
    [CZHttpTool GET:urlStr parameters:dic  success:^(id responseObject) {
        if (success) {
            success(responseObject);
            
        }
    } failure:^(NSError *error) {
        
    }];
    

}
@end
