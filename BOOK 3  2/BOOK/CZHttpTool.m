//
//  CZHttpTool.m
//  传智微博
//
//  Created by apple on 15-3-10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZHttpTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "SVProgressHUD.h"
//#import "MKNetworkKit.h"
@implementation CZHttpTool

+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    // 设置超时时间
    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    
    mgr.requestSerializer.timeoutInterval = 12;
    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
//   [SVProgressHUD showErrorWithStatus:@"正在加载数据" duration:2.0];
    
    [mgr GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // AFN请求成功时候调用block
        // 先把请求成功要做的事情，保存到这个代码块
        if (success) {
            success(responseObject);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
//            [SVProgressHUD showErrorWithStatus:@"链接网络失败"];
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"服务区开小猜了" duration:2.0];
            //                      [SVProgressHUD showErrorWithStatus:@"服务器开小差了"];
            //                      [SVProgressHUD dismiss];
        }
        if(failure){
            failure(error);
            
        }
    }];
}

+ (void)Post:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 创建请求管理者
//    AFHTTPSessionManager *mgr=[AFHTTPSessionManager manager];
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    mgr.requestSerializer.timeoutInterval = 12;
    [mgr.requestSerializer
     didChangeValueForKey:@"timeoutInterval"];
    [mgr POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        if (success) {
            success(responseObject);
//           NSLog(@"sdfasdfasdfasdfasdfasdfasdfas%@",responseObject);
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
            [SVProgressHUD showErrorWithStatus:@"链接网络失败"];
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"服务区开小猜了" duration:2.0];
        }

        if (failure) {
            failure(error);
        }
    }];
}
//上传多张图片
+(void)postImage:(NSString *)URLString parameters:(id)parameters imageFile:(UIImage *)file fileKey:(NSString *)fileKey success:(void (^)( NSDictionary*))success failure:(void (^)(NSError *))failure{
    
    //创建请求管理者
    AFHTTPSessionManager *mgr=[AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    
    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    mgr.requestSerializer.timeoutInterval = 12;
    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
 
    [mgr POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            NSData *imageData = UIImageJPEGRepresentation(file, 0.005);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss:SSS";
            
            NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
            
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"%@",fileKey] fileName:fileName mimeType:@"image/png"];

    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            [SVProgressHUD dismiss];
            NSDictionary  *json=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            NSMutableArray *array=[json objectForKey:@"files"];
            NSDictionary *dic=[array objectAtIndex:0];
            NSLog(@"%@",json);
            
            success(dic);
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
            [SVProgressHUD showErrorWithStatus:@"链接网络失败"];
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"服务区开小猜了" duration:2.0];
        }
        
        if (failure) {
            //            [SVProgressHUD revealErrorWithStatus:@"请求失败"];
            failure(error);
        }

    }];
    
}
+(void)PostHeadImage:(NSString *)URLString parameters:(id)parameters imageFile:(UIImage *)file fileKey:(NSString *)fileKey success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    AFHTTPSessionManager *mgr=[AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    
    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    mgr.requestSerializer.timeoutInterval = 12;
    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [mgr POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *imageData = UIImageJPEGRepresentation(file, 0.005);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss:SSS";
        
        NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
        
        [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"%@",fileKey] fileName:fileName mimeType:@"image/png"];
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            [SVProgressHUD dismiss];
            NSDictionary  *json=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//            NSMutableArray *array=[json objectForKey:@"files"];
//            NSDictionary *dic=[array objectAtIndex:0];
//            NSLog(@"%@",json);
            
            success(json);
            NSLog(@"%@",responseObject);
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
            [SVProgressHUD showErrorWithStatus:@"链接网络失败"];
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"服务区开小猜了" duration:2.0];
        }
        
        if (failure) {
            //            [SVProgressHUD revealErrorWithStatus:@"请求失败"];
            failure(error);
        }
        
    }];

}
//+(void)postImage:(NSString *)URLString parameters:(id)parameters imageFile:(UIImage *)file fileKey:(NSString *)fileKey success:(void (^)( NSDictionary*))success failure:(void (^)(NSError *))failure{
//    
//};


@end
