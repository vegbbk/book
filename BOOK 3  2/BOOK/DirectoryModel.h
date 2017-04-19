//
//  DirectoryModel.h
//  BOOK
//
//  Created by wangyang on 16/3/17.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DirectoryModel : NSObject
/**ID**/
@property(copy,nonatomic)NSString *post_id;
/**ID**/
@property(copy,nonatomic)NSString *ID;
/**名称**/
@property(copy,nonatomic)NSString *title;
/**日期**/
@property(copy,nonatomic)NSString *post_date;
/**推荐**/
@property(copy,nonatomic)NSString *recommended;
/**压缩图**/
@property(copy,nonatomic)NSString *thumb;
@property(copy,nonatomic)NSString *post_title;
@property(copy,nonatomic)NSString *term_id;
@property(copy,nonatomic)NSString *wlurl;
@property(copy,nonatomic)NSString *comment;
@property(copy,nonatomic)NSString *tid;
@property(copy,nonatomic)NSString *isMagazine;
@property(copy,nonatomic)NSString *post_keywords;
@property(copy,nonatomic)NSString *post_hits;
@property(copy,nonatomic)NSString *showid;
@end
