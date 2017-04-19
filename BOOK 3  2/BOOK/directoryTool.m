//
//  directoryTool.m
//  BOOK
//
//  Created by wangyang on 16/3/17.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "directoryTool.h"
#import "ReviewModel.h"
@implementation directoryTool

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

    NSLog(@"%@",urlString);
    
    [CZHttpTool GET:urlString parameters:dic success:^(id responseObject) {
        
        NSLog(@"%@",[responseObject objectForKey:@"data"]);
        NSArray *array1=[DirectoryModel objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
        if(success){
            success(array1);
        }
    } failure:^(NSError *error) {
        if(failure){
            failure(error);
            
        }
    }];
    
    
}
//评测标题
+(void)getPcName:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSString *urlString=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=Magazine&a=getpcName"];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    NSInteger lang=0;
     if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);

    [CZHttpTool GET:urlString parameters:dic success:^(id responseObject) {
        NSArray *array1=[responseObject objectForKey:@"data"];
        NSLog(@"%@",array1);
        
        if(success){
            success(array1);
            
        }
    } failure:^(NSError *error) {
        
    }];
    

}
@end
