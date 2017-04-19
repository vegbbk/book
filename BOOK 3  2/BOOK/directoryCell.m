

//
//  directoryCell.m
//  BOOK
//
//  Created by wangyang on 16/3/24.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "directoryCell.h"

@implementation directoryCell

-(instancetype)initWithFrame:(CGRect)frame{
    if(self =[super initWithFrame:frame]){
        [self createFrame];
        
    }
    return self;
    
}
-(void)createFrame{
    _imgView=[[UIImageView alloc]init];
    [self addSubview:_imgView];
    _labName=[[UILabel alloc]init];
//    _labName.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.8];
    _labName.textColor=[UIColor whiteColor];
    _labName.font=[UIFont systemFontOfSize:13];
    
    _labName.textAlignment=NSTextAlignmentCenter;
    _labName.frame=CGRectMake(0, self.height-20, self.width, 20);
    //    _labName.backgroundColor=[UIColor redColor];
    
    _imgView.frame=CGRectMake(0, 0, self.width, CZScreenH*0.25);
    [self addSubview:_labName];
    
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
