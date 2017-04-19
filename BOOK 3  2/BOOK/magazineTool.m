//
//  magazineTool.m
//  BOOK
//
//  Created by wangyang on 16/3/28.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "magazineTool.h"
#import "DirectoryModel.h"
#import "adverModel.h"
#import "bookInfoCommentsModel.h"
@implementation magazineTool
//获取用户的ID
+(void)magazineShow:(NSString *)postId success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic[@"term_id"]=postId;
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=Magazine&a=show"];
    NSInteger lang=0;
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);

    
    [CZHttpTool GET:urlStr parameters:dic success:^(id responseObject) {
//        NSLog(@"%@",responseObject);
        NSLog(@"啊说肯定会发客服哈康师傅哈咖啡啥可说%@",responseObject);
        NSArray *array1=[detailsIDModel objectArrayWithKeyValuesArray:[responseObject objectForKey:@"list"]];
        if(success){
            success(array1);
            
        }
    } failure:^(NSError *error) {
        
    }];
    
}
//评论列表
+(void)magazineCommentsList:(NSString *)post_id andsuccess:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic[@"post_id"]=post_id;
    
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=Comment&a=getCommentList"];
    NSInteger lang=0;
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);
    [SVProgressHUD showWithStatus:@"正在加载评论列表..."];
    [CZHttpTool GET:urlStr parameters:dic success:^(id responseObject) {
        
        if([responseObject objectForKey:@"status"])
        
         [SVProgressHUD dismiss];
        
        
        NSArray *array1=[bookInfoCommentsModel objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
        NSLog(@"%@",responseObject);
        
        if(success){
            success(array1);
        }
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"评论列表加载失败"];
        if(failure){
            failure(error);
            
        }
    }];
}

//评论杂志
+(void)magazineComment:(NSString *)post_id content:(NSString *)content success:(void (^)(id))success failure:(void (^)(NSError *))failure{
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


//获取到一个视频地址
+(void)Getad:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=Magazine&a=Getad"];
   
    [CZHttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        //        NSLog(@"%@",responseObject);
//        NSArray *array1=[detailsIDModel objectArrayWithKeyValuesArray:[responseObject objectForKey:@"list"]];
        if(success){
            success(responseObject);
            
        }
    } failure:^(NSError *error) {
        
    }];
}
+(void)Searcharticle:(NSString *)keyWords success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic[@"keyword"]=keyWords;
    NSInteger lang=0;
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);

    NSString *urlStr=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=Magazine&a=search"];
    
    
    [CZHttpTool GET:urlStr parameters:dic success:^(id responseObject) {
        //        NSLog(@"%@",responseObject);
//        NSLog(@"啊说肯定会发客服哈康师傅哈咖啡啥可说%@",responseObject);
        NSArray *array1=[DirectoryModel objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
       
        if(success){
            success(array1);
            
        }
    } failure:^(NSError *error) {
        
    }];

}
//广告页面
+(void)advertising:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=ad&a=zzindex"];
    NSInteger lang=0;
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);
    [CZHttpTool GET:urlStr parameters:dic success:^(id responseObject) {
        
        NSArray *array1=[adverModel objectArrayWithKeyValuesArray:[responseObject objectForKey:@"adlist"]];
        
        if(success){
            success(array1);
            
        }
    } failure:^(NSError *error) {
        
    }];

}
//目录广告
+(void)directoryAvder:(void (^)(id))success failure:(void (^)(NSError *))failire{
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=ad&a=zzlist"];
    NSInteger lang=0;
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    if([language isEqualToString:@"en"]){
       
        lang=1;
    }
    dic[@"language"]=@(lang);
    
    [CZHttpTool GET:urlStr parameters:dic success:^(id responseObject) {
        
        NSArray *array1=[adverModel objectArrayWithKeyValuesArray:[responseObject objectForKey:@"adlist"]];
        
        if(success){
            success(array1);
            
        }
    } failure:^(NSError *error) {
        
    }];
}
//详情广告

//评测页广告
+(void)PicListAvder:(void (^)(id))success failure:(void (^)(NSError *))failire{
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=ad&a=pclist"];
     NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    NSInteger lang=0;
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);
    [CZHttpTool GET:urlStr parameters:dic success:^(id responseObject) {
        
        NSArray *array1=[adverModel objectArrayWithKeyValuesArray:[responseObject objectForKey:@"adlist"]];
        
        if(success){
            success(array1);
            
        }
    } failure:^(NSError *error) {
        
    }];

}
+(void)MagineDirectory:(NSInteger )type andPageNO:(NSInteger)pageNO success:(void (^)(id))success andfailure:(void (^)(NSError *))failure{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    NSInteger lang=0;
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);
    dic[@"term_id"]=@(type);
    dic[@"p"]=@(pageNO);
    NSString *urlString=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=Magazine&a=getlist"];
    [CZHttpTool GET:urlString parameters:dic success:^(id responseObject) {
        NSArray *array1=[DirectoryModel objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
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
+(void)MagineDirectryDetail:(NSString *)term_id success:(void (^)(id))success andfailure:(void (^)(NSError *))failure{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    NSInteger lang=0;
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);
    dic[@"term_id"]=term_id;
    
//    dic[@"p"]=@(pageNO);
    NSString *urlString=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=Magazine&a=getlist"];
    [CZHttpTool GET:urlString parameters:dic success:^(id responseObject) {
        NSArray *array1=[DirectoryModel objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
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
+(void)detailAvder:(NSString *)term_id andsuccess:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=Ad&a=zzshow"];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    NSInteger lang=0;
    dic[@"term_id"]=term_id;
    
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);
    [CZHttpTool GET:urlStr parameters:dic success:^(id responseObject) {
        
//        NSArray *array1=[adverModel objectArrayWithKeyValuesArray:];
        NSString *urlStr=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"cover_img"]];
        
        if(success){
            success(urlStr);
            
        }
    } failure:^(NSError *error) {
        
    }];

}
+(void)getAllcontent:(NSString *)term_id andsuccess:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=Magazine&a=getAllList"];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    NSInteger lang=0;
    dic[@"term_id"]=term_id;
    
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);
    
    [CZHttpTool GET:urlStr parameters:dic success:^(id responseObject) {
        
        NSArray *array1=[responseObject objectForKey:@"data"];
        //        NSLog(@"%@",responseObject);
//        NSLog(@"%@")
        NSArray *array2=[DirectoryModel objectArrayWithKeyValuesArray:[array1 objectAtIndex:0]];
//        NSArray *array3=[DirectoryModel objectArrayWithKeyValuesArray:[array1 objectAtIndex:0]];
        
        if(success){
            success(array2);
        }
    } failure:^(NSError *error) {
        if(failure){
            failure(error);
            
        }
    }];


}
@end
