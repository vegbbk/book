//
//  DirectoryController.h
//  BOOK
//
//  Created by wangyang on 16/4/1.
//  Copyright © 2016年 liujianji. All rights reserved.
//
//@protocol DirectoryControllerDelegate <NSObject>
//
//-(void)direPage:(NSInteger )pagetitle;
//
//@end

#import <UIKit/UIKit.h>

@interface DirectoryController : UIViewController

//@property(nonatomic,strong)NSMutableArray *magaArray;
//@property(nonatomic,strong)NSMutableArray *recommendedArray;
//@property(nonatomic,strong)NSMutableArray *dataSource;

//@property(assign,nonatomic)id <DirectoryControllerDelegate>Delegate;
@property(copy,nonatomic)NSString *term_id;
@property(nonatomic,strong)NSURL *videoUrl;

@end
