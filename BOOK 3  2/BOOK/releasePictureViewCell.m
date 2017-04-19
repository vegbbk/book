//
//  releasePictureViewCell.m
//  BOOK
//
//  Created by liujianji on 16/3/9.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "releasePictureViewCell.h"
#import "pictureViewCell.h"
#import "registeredViewController.h"

@interface releasePictureViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>{
    NSInteger page;
    UIImagePickerController *pickerImage;
    UIActionSheet *myActionSheet;
    NSMutableArray *imgArray;
    UIImage *image;
    
}
@end

@implementation releasePictureViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
       
        
        [self createFrame];
        
    }
    return self;
    
}
-(void)createFrame{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
//    _collecView.collectionViewLayout=layout;
    _collecView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, CZScreenW, 200) collectionViewLayout:layout];
    imgArray=[NSMutableArray array];
    
    _collecView.showsHorizontalScrollIndicator=NO;
    _collecView.showsVerticalScrollIndicator=NO;
    
    _collecView.dataSource=self;
    _collecView.delegate=self;
    [_collecView registerClass:[pictureViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    
    _collecView.backgroundColor=[UIColor whiteColor];
    
//    _collecView.backgroundColor=[UIColor redColor];
    
    [self addSubview:_collecView];
    
    
    
//    layout.itemSize=CGSizeMake(CZScreenW/4-50, CZScreenW/4-50);
//    layout.
//    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}
-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return imgArray.count+1;
    
}

- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath

{
    
    return CGSizeMake ( (CZScreenW-50)/4 ,(CZScreenW-50)/4 );
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    pictureViewCell *cell=[pictureViewCell cellCollectionWith:collectionView :indexPath];
    if(indexPath.row==[imgArray count]){
        cell.imgView.image=[UIImage imageNamed:@"添加1"];

        cell.imgView.contentMode=UIViewContentModeScaleAspectFit;
        
    }else{
        if(imgArray.count==0){
        
        }else{
            cell.imgView.image=[imgArray objectAtIndex:indexPath.row];
            ;
        }
        
    }
    cell.layer.cornerRadius=10.0;
    cell.layer.masksToBounds=YES;
   cell.imgView.contentMode=UIViewContentModeScaleAspectFill;
    return cell;
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==[imgArray count]){

        
        [self.delegate closeKeyBord];
        
        [self openMenu];
        
    
    }else {
        if(imgArray.count==0){
            
        }else{

            [self longPressToDo];
            
        }

    }
    
}
-(void)openMenu

{
    //在这里呼出下方菜单按钮项
  
    myActionSheet = [[UIActionSheet alloc]
                     
                     initWithTitle:nil
                     
                     delegate:self
                     
                     cancelButtonTitle:NSLocalizedString(@"cancel", @"cancel")
                     
                     destructiveButtonTitle:nil
                     
                     otherButtonTitles: NSLocalizedString(@"Open the camera",@"Open the camera"), NSLocalizedString(@"Open the photo album", @"Open the photo album"),nil];
    
    [myActionSheet showInView:self];
    
    [myActionSheet reloadInputViews];

    
}
//弹出提示框
-(void)longPressToDo{
UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"是否删除图片" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alertView show];
    
}
//是否删除图片
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        return;
    }else{
        [imgArray removeLastObject];
        [_collecView reloadData];
        
        [self.delegate deleteImage];
        
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==myActionSheet.cancelButtonIndex){
        NSLog(@"取消");
        
    }
    switch (buttonIndex) {
        case 0:
            [self takePhoto];
            
            break;
        case 1:
            [self LocalPhoto];
            
        default:
            break;
    }
}
//开始拍照
-(void)takePhoto{
    //调用相机
    UIImagePickerControllerSourceType souceType=UIImagePickerControllerSourceTypeCamera;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        pickerImage=[[UIImagePickerController alloc]init];
        pickerImage.delegate=self;
        pickerImage.sourceType=souceType;
        pickerImage.allowsEditing=YES;
        [self.delegate picture:pickerImage];

        [pickerImage reloadInputViews];
    }else {
     NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    
    }
}
//打开本地相册
-(void)LocalPhoto{
    pickerImage=[[UIImagePickerController alloc]init];
    //打开相册
    pickerImage.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    pickerImage.delegate=self;
    pickerImage.allowsEditing=YES;
    [self.delegate picture:pickerImage];
    


    [pickerImage reloadInputViews];
    
    
    
}
//取消选择
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"您取消了选择图片");
    [pickerImage dismissViewControllerAnimated:YES completion:nil];
    
}
//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *type=[info objectForKey:UIImagePickerControllerMediaType];
    if([type isEqualToString:@"public.image"]){
        image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data;
        if(UIImagePNGRepresentation(image)==nil){
            data=UIImageJPEGRepresentation(image, 0.2);
            
        }else{
            data=UIImagePNGRepresentation(image);
        }
        image=[UIImage imageWithData:data];
        image=[UIImage fixOrientation:image];
        
        image=[UIImage imageWithImageSimple:image scaledToSize:  CGSizeMake(300, 300)];
        
        [imgArray addObject:image];
          [_collecView reloadData];
    }
    [self.delegate pictureString:image];
    
    [pickerImage dismissViewControllerAnimated:YES completion:nil];
    
}
+(instancetype)CellWithTableView:(UITableView *)tabView{
    static NSString *ID=@"cell";
    
    id cell=[tabView dequeueReusableCellWithIdentifier:ID ];
    if(cell==nil){
        cell =[[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
