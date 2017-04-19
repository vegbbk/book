//
//  BBSTool.m
//  BOOK
//
//  Created by wangyang on 16/3/18.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "BBSTool.h"
#import "BBSModel.h"
#import "commentsModel.h"
#import "detailsIDModel.h"
@implementation BBSTool
+(void)BBSSource:(NSInteger)Type andPage:(NSInteger)PageNO success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
 
    dic[@"day"]=@(Type);
    dic[@"p"]=@(PageNO);
    NSInteger lang=0;
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);
  //  NSString *url=[NSString stringWithFormat:@"http://www.cnluwo.com/qichezz/index.php?g=server&m=Magazine&a=getbbsList&day=1&p=1"];
    NSString *urlString=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=Magazine&a=getbbsList"];
    [CZHttpTool GET:urlString parameters:dic success:^(id responseObject) {
        NSLog(@"asdfsadfasfasdf %@",responseObject);
        
        NSArray *array1=[BBSModel objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
        //        NSLog(@"%@",responseObject);
        
        if(success){
            success(array1);
        }
    } failure:^(NSError *error) {
        if(failure){
            failure(error);
            
        }
    }];
    
}
//发表论坛

+(void)releaseBBS:(NSDictionary *)dic andsuccess:(void (^)(id))success failure:(void (^)(NSError *))failure{
         NSString *urlStr=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=Magazine&a=doadd"];
//    NSMutableDictionary *dic=[NSMutableDictionary dictionary];

  
    [CZHttpTool Post:urlStr parameters:dic success:^(id responseObject) {
        //        NSLog(@"%@",responseObject);
        
        if (success) {
            success(responseObject);
            //            NSLog(@"awfawfasdfasdfadf%@",responseObject);
            
        }
    } failure:^(NSError *error) {
        if(failure){
            failure(error);
            
        }
    }];
    
}
//评论列表
+(void)releaseList:(NSString *)post_id andsuccess:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic[@"post_id"]=post_id;
  
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=Comment&a=getCommentList"];
    NSInteger lang=0;
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);
    
    [CZHttpTool GET:urlStr parameters:dic success:^(id responseObject) {
        
        NSArray *array1=[commentsModel objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
        NSLog(@"%@",responseObject);
        
        if(success){
            success(array1);
        }
    } failure:^(NSError *error) {
        if(failure){
            failure(error);
            
        }
    }];
}
//发表评论
+(void)publishedcomment:(NSString *)post_id content:(NSString *)content success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *phoneAccount=[ud objectForKey:@"userid"];
    dic[@"user_id"]=phoneAccount;
    
    dic[@"post_id"]=post_id;
    dic[@"content"]=content;
    NSInteger lang=0;
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=comment&a=addComment"];
    
      [CZHttpTool Post:urlStr parameters:dic success:^(id responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if(failure){
            failure(error);
            
        }
    }];
    
    
}


+(void)detailSID:(NSString *)post_id success:(void (^)(id  ))success failure:(void (^)(NSError *))failure{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic[@"id"]=post_id;
    //    dic[@"content"]=content;
    NSInteger lang=0;
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=Magazine&a=showBBs"];
    [CZHttpTool GET:urlStr parameters:dic success:^(id responseObject) {

        if(success){
         success(responseObject);
        }
       
        
        
    } failure:^(NSError *error) {
        if(failure){
            failure(error);
            
        }
    }];
}
+(void)post_sc:(NSString *)post_id success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic[@"post_id"]=post_id;
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *phoneAccount=[ud objectForKey:@"userid"];
    dic[@"user_id"]=phoneAccount;
    NSInteger lang=0;
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);
    
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=Magazine&a=add_collect"];
    [CZHttpTool Post:urlStr parameters:dic success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        if (success) {
            success(responseObject);
            
        }
    } failure:^(NSError *error) {
        
        if(failure){
            failure(error);
            
        }
    }];
    
}
+(void)myBBS:(NSInteger )type success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic[@"day"]=@(type);
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *phoneAccount=[ud objectForKey:@"userid"];
    dic[@"user_id"]=phoneAccount;
//    dic[@"p"]=@(PageNO);
    NSInteger lang=0;
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);
    NSString *urlString=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=Magazine&a=myBbs"];
    
    [CZHttpTool GET:urlString parameters:dic success:^(id responseObject) {
        NSLog(@"asdfsadfasfasdf %@",responseObject);
        
        NSArray *array1=[BBSModel objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
        //        NSLog(@"%@",responseObject);
        
        if(success){
            success(array1);
        }
    } failure:^(NSError *error) {
        if(failure){
            failure(error);
            [SVProgressHUD showSuccessWithStatus:@"撒发送"];
        }
    }];

}
@end
