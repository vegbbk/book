//
//  releasePictureViewCell.h
//  BOOK
//
//  Created by liujianji on 16/3/9.
//  Copyright © 2016年 liujianji. All rights reserved.
//

@protocol releasePictureViewDelegate <NSObject>

-(void)picture:(UIImagePickerController *)pickerCon;
-(void)pictureString:(UIImage *)image;
-(void)deleteImage;
-(void)closeKeyBord;

@end
#import <UIKit/UIKit.h>

@interface releasePictureViewCell : UITableViewCell
@property(strong,nonatomic)UICollectionView *collecView;
+(instancetype)CellWithTableView:(UITableView *)tabView;
@property(weak,nonatomic)id<releasePictureViewDelegate>delegate;

@end
