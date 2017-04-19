//
//  InternationalControl.m
//  切换语言
//
//  Created by zonelue004 on 16/1/15.
//  Copyright © 2016年 ZB_Xiao. All rights reserved.
//

#import "InternationalControl.h"

@implementation InternationalControl

static NSBundle *bundle = nil;

+ ( NSBundle * )bundle
{
    return bundle;
}
+(void)initUserLanguage{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSString *string = [def valueForKey:@"userLanguage"];
   
    if(string.length == 0)
    {
        //获取系统当前语言版本(中文zh-Hans,英文en)
        NSArray* languages = [def objectForKey:@"AppleLanguages"];
        NSString *current = [languages objectAtIndex:0];
        
        string = current;
        
        [def setValue:current forKey:@"userLanguage"];
        
        [def synchronize];//持久化，不加的话不会保存
    }
    
    //获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:string ofType:@"lproj"];
    NSLog(@"%@",path);
    
    bundle = [NSBundle bundleWithPath:path];//生成bundle
}
+(NSString *)userLanguage
{
    NSArray *curLocs = [[NSBundle mainBundle] preferredLocalizations];
    
    return curLocs[0];
}
+(void)setUserlanguage:(NSString *)languages{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    //1.第一步改变bundle的值
    NSString *path = [[NSBundle mainBundle] pathForResource:languages ofType:@"lproj" ];
    
    bundle = [NSBundle bundleWithPath:path];
    
    //2.持久化
    [def setValue:languages forKey:@"userLanguage"];
    
    [def synchronize];
}



@end
