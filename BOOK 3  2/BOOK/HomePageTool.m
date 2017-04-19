


//
//  HomePageTool.m
//  BOOK
//
//  Created by liujianji on 16/3/14.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "HomePageTool.h"
#import "CZHttpTool.h"
#import "MJExtension.h"
#import "homeModel.h"
#import "conModel.h"
#import "DirectoryModel.h"
#import "magazinContentModel.h"
@implementation HomePageTool
+(void)HomePage:(void (^)(id))success failure:(void(^) (NSError *))failure{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=Magazine&a=newIndex"];
      NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    NSInteger lang=0;
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);
    [CZHttpTool Post:urlString parameters:dic success:^(id responseObject) {
        NSArray *array=[homeModel objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
        NSLog(@"%@",[responseObject objectForKey:@"data"]);
        
        if(success){
            success(array);
            
        }
        
    } failure:^(NSError *error) {
        //        NSLog(@"%@",error);
        if(failure){
            failure(error);
            
        }
    }];
}
+(void)Magazine:(NSString *)term_id success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic[@"term_id"]=term_id;
    NSInteger lang=0;
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    NSLog(@"%@",term_id);
    dic[@"language"]=@(lang);
    NSString *urlString=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=Magazine&a=magazineIndex"];
    [CZHttpTool GET:urlString parameters:dic success:^(id responseObject) {
        NSArray *array=[homeModel objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
       NSLog(@"halshflasjfalsjfpwfawjflasfa  阿福无法发觉请我出去玩 iu 去年为 i 请我次噢%@",responseObject);
        
        if(success){
            success(array);
        }
    } failure:^(NSError *error) {
        
        if(failure){
            failure(error);
            
        }
    }];
    
}
+(void)ShowtextContent:(NSString *)BookId success:(void (^)(magazinContentModel *))success failure:(void (^)(NSError *))failure{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic[@"id"]=BookId;
    NSInteger lang=0;
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);
    NSString *urlString=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=Magazine&a=show"];
    [CZHttpTool GET:urlString parameters:dic success:^(id responseObject) {
        
        magazinContentModel *dic=[magazinContentModel objectWithKeyValues:[responseObject objectForKey:@"data"]];
        
        //        NSLog(@"%@",responseObject);
        
        if(success){
            success(dic);
        }
    } failure:^(NSError *error) {
        if(failure){
            failure(error);
            
        }
    }];
    
}
//杂志目录
+(void)ShowTExtList:(NSString *)term_id success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    NSInteger lang=0;
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);
    dic[@"term_id"]=term_id;
//    dic[@"p"]=@(1);
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=Magazine&a=getzzList"];
    
    
    [CZHttpTool GET:urlString parameters:dic success:^(id responseObject) {
        NSArray *array1=[DirectoryModel objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
//        NSArray *dic=[array1 objectAtIndex:0];
//        NSArray *array2=[DirectoryModel objectArrayWithKeyValuesArray:dic];
        if(success){
            success(array1);
            
        }
        
    } failure:^(NSError *error) {
        if(failure){
            failure(error);
            
        }
    }];
    
}
@end
