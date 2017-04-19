//
//  magazineViewCell.m
//  BOOK
//
//  Created by liujianji on 16/3/4.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "magazineViewCell.h"

@implementation magazineViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if(self ==[super initWithFrame:frame]){
        [self createFrame];
        
    }
    return self;
    
}
-(void)createFrame{
    _imgView=[[UIImageView alloc]init];
    [self addSubview:_imgView];
    _labName=[[UILabel alloc]init];
//    _labName.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.8];
    _labName.textColor=[UIColor lightGrayColor];
    _labName.textAlignment=NSTextAlignmentCenter;
    _labName.font=[UIFont systemFontOfSize:12];
    
    [self addSubview:_labName];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
 
    _labName.frame=CGRectMake(0, self.height-20, CZScreenW/3-20, 20);
     _imgView.frame=CGRectMake(0, 0, self.width, self.height-20);
}
+(instancetype)cellCollectionWith:(UICollectionView *)collectionView :(NSIndexPath *)indexPath{
    static NSString *ID=@"cell";
    id cell=[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath ];
    
    if(cell==nil){
        cell=[collectionView dequeueReusableCellWithReuseIdentifier :ID forIndexPath :indexPath];

    }
    
    return cell;

}
@end
