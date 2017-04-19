//
//  bookInfoCommentLJJTableViewCell.h
//  BOOK
//
//  Created by liujianji on 17/2/13.
//  Copyright © 2017年 liujianji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "bookInfoCommentsModel.h"
@interface bookInfoCommentLJJTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoContLabel;//评论详情

- (void)loadDataWith:(bookInfoCommentsModel*)model;
@end
