//
//  bookInfoCommentLJJTableViewCell.m
//  BOOK
//
//  Created by liujianji on 17/2/13.
//  Copyright © 2017年 liujianji. All rights reserved.
//

#import "bookInfoCommentLJJTableViewCell.h"

@implementation bookInfoCommentLJJTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImage.layer.cornerRadius = 20;
    self.headImage.clipsToBounds = YES;
    // Initialization code
}

-(void)loadDataWith:(bookInfoCommentsModel *)model{

    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"头像"]];
    self.nameLabel.text = model.mobile;
    NSString *dateStrimng=[ZBTime intervalSinceNow:model.createtime];
    self.timeLabel.text = dateStrimng;
    self.infoContLabel.text = model.content;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
