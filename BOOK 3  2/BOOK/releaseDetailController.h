//
//  releaseDetailController.h
//  BOOK
//
//  Created by liujianji on 16/3/10.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface releaseDetailController : UIViewController
@property(copy,nonatomic)NSString *postId;
@property(copy,nonatomic)NSString *ID;
@property(copy,nonatomic)NSString *typeSearch;
@property(copy,nonatomic)NSString *favarticle;
@property(copy,nonatomic)NSString *term_id;
@property(nonatomic,copy)NSString *post_hits;
@property (nonatomic, strong) UIView *panelView;
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;
////
//@property(strong,nonatomic)detailsIDModel *details;

@end
