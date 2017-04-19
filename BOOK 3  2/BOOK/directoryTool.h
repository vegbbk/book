//
//  directoryTool.h
//  BOOK
//
//  Created by wangyang on 16/3/17.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DirectoryModel.h"
@interface directoryTool : NSObject
//测评数据
+(void)MagineDirectory:(NSInteger )type andPageNO:(NSInteger)pageNO success:(void(^)(id responseObject))success andfailure:(void(^)(NSError *error))failure;
//获取评测标题
+(void)getPcName:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;




@end
