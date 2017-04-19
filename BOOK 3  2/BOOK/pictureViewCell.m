//
//  pictureViewCell.m
//  BOOK
//
//  Created by liujianji on 16/3/9.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "pictureViewCell.h"

@implementation pictureViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if(self ==[super initWithFrame:frame]){
        [self createFrame];
        
    }
    return self;
    
}
-(void)createFrame{
    _imgView=[[UIImageView alloc]init];
    [self addSubview:_imgView];
    _imgView.frame=self.bounds;
   
    
    
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
