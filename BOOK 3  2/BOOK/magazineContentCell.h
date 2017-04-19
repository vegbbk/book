//
//  magazineContentCell.h
//  BOOK
//
//  Created by wangyang on 16/3/16.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "conModel.h"

@interface magazineContentCell : UITableViewCell{

//    ConFrameModel *_confrmaes;
    
}
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UIImageView *videoView;
@property(nonatomic,strong)UILabel *contentLab;
//@property(nonatomic,strong)conModel *con;

//@property(nonatomic,assign)CGFloat cellHeight;
//@property(nonatomic,strong) conModel *conData;

//算cell的高度
-(void)setIntroductionText:(id )model;



+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
