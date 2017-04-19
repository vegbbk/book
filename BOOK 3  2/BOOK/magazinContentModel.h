//
//  magazinContentModel.h
//  BOOK
//
//  Created by wangyang on 16/3/16.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface magazinContentModel : NSObject
@property(copy,nonatomic)NSString *term_id;
@property(copy,nonatomic)NSString *title;
@property(copy,nonatomic)NSString *post_date;
@property(copy,nonatomic)NSString *comment_status;
@property(strong,nonatomic)NSArray *con;

@end
