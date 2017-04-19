//
//  bookInfoLJJViewController.h
//  BOOK
//
//  Created by liujianji on 17/2/13.
//  Copyright © 2017年 liujianji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bookInfoLJJViewController : UIViewController
@property(nonatomic,strong)NSURL *videoUrl;
@property(nonatomic,copy)NSString * postIDStr;
@property(nonatomic,copy)NSString * IDstr;//后期加的
@property(nonatomic,copy)NSString *comment_count;
@property(nonatomic,copy)NSString *post_hits;
@property(nonatomic,copy)NSString *where;
@end
