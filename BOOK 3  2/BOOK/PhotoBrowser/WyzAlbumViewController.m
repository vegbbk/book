//
//  WyzAlbumViewController.m
//
//  Created by wyz on 15/10/18.
//  Copyright (c) 2015年 wyz. All rights reserved.
//

#import "WyzAlbumViewController.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "PhotoView.h"
#define SDPhotoBrowserSaveImageSuccessText @" ^_^ 保存成功 "

// 图片保存失败提示文字
#define SDPhotoBrowserSaveImageFailText @" >_< 保存失败 "
@interface WyzAlbumViewController ()<UIScrollViewDelegate,PhotoViewDelegate>
{
    CGFloat lastScale;
    MBProgressHUD *HUD;
    NSMutableArray *_subViewList;
    CGFloat screen_width;
    CGFloat screen_height;
    UILabel *_indexLabel;
    UIButton *_saveButton;
    UIActivityIndicatorView *_indicatorView;
}

@end

@implementation WyzAlbumViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //
        _subViewList = [[NSMutableArray alloc] init];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden=YES;
    
    self.navigationController.navigationBar.translucent=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    lastScale = 1.0;
    self.view.backgroundColor = [UIColor blackColor];
   
    
    screen_height=[UIScreen mainScreen].bounds.size.height;
    screen_width=[UIScreen mainScreen].bounds.size.width;
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapView)];
    //    [self.view addGestureRecognizer:tap];
    
    [self initScrollView];
    [self addLabels];
    [self addNameLabels];
    [self setupToolbars];
    
    
    [self setPicCurrentIndex:self.currentIndex];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initScrollView{
    //    [[SDImageCache sharedImageCache] cleanDisk];
    //    [[SDImageCache sharedImageCache] clearMemory];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    self.scrollView.contentSize = CGSizeMake(self.imgArr.count*screen_width, screen_height);
    self.scrollView.delegate = self;
    self.scrollView.contentOffset = CGPointMake(0, 0);
    //设置放大缩小的最大，最小倍数
    self.scrollView.minimumZoomScale = 1;
    self.scrollView.maximumZoomScale = 2;
    [self.view addSubview:self.scrollView];
    
    for (int i = 0; i < self.imgArr.count; i++) {
        [_subViewList addObject:[NSNull class]];
    }
    for (int i=0; i<self.imageNameArray.count; i++) {
        [_subViewList addObject:[NSNull class]];
    }
    
}
- (void)setupToolbars
{
    // 1. 序标
    //    UILabel *indexLabel = [[UILabel alloc] init];
    //    indexLabel.bounds = CGRectMake(0, 0, 80, 30);
    //    indexLabel.textAlignment = NSTextAlignmentCenter;
    //    indexLabel.textColor = [UIColor whiteColor];
    //    indexLabel.font = [UIFont boldSystemFontOfSize:20];
    //    indexLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    //    indexLabel.layer.cornerRadius = indexLabel.bounds.size.height * 0.5;
    //    indexLabel.clipsToBounds = YES;
    //    if (_subViewList.count > 1) {
    //        indexLabel.text = [NSString stringWithFormat:@"1/%ld", _subViewList.count];
    //    }
    //    _indexLabel = indexLabel;
    //    [self.view addSubview:indexLabel];
    
    //
    //返回
    UIButton *backHome=[[UIButton alloc]initWithFrame:CGRectMake(10, CZScreenH-45, 45, 45)];
    [self.view addSubview:backHome];
    [backHome addTarget:self action:@selector(TapHiddenPhotoView) forControlEvents:UIControlEventTouchUpInside];
    //    [backHome setTitle:@"返回" forState:UIControlStateNormal];
    [backHome setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backHome setImage:[UIImage imageNamed:@"comment_back"] forState:UIControlStateNormal];
    [backHome setImage:[UIImage imageNamed:@"comment_back"] forState:UIControlStateSelected];
    backHome.backgroundColor=[UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.90f];
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(CZScreenW-45, CZScreenH-45, 45, 45)];
    
    //    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
   //2.保存按钮
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveButton.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.90f];
    [saveButton setImage:[UIImage imageNamed:@"comment_down"] forState:UIControlStateSelected];
    [saveButton setImage:[UIImage imageNamed:@"comment_down"] forState:UIControlStateNormal];
    //    saveButton.layer.cornerRadius = 5;
    saveButton.clipsToBounds = YES;
    [saveButton addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    _saveButton = saveButton;
    [self.view addSubview:saveButton];
}

- (void)saveImage
{
//    int index = self.scrollView.contentOffset.x / self.scrollView.bounds.size.width;
    
    PhotoView *currentImageView =self.scrollView.subviews[0];
    //    currentImageView.frame=CGRectMake(0, 0, 300, 300);
    //    [self.view addSubview:currentImageView];
    
    //    [currentImageView sizeToFit];
    //    [self.view addSubview:currentImageView];
    
    //   UIImageWriteToSavedPhotosAlbum(currentImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
    UIImageWriteToSavedPhotosAlbum(currentImageView.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] init];
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    indicator.center = self.view.center;
    _indicatorView = indicator;
    [[UIApplication sharedApplication].keyWindow addSubview:indicator];
    [indicator startAnimating];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    [_indicatorView removeFromSuperview];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.90f];
    label.layer.cornerRadius = 5;
    label.clipsToBounds = YES;
    label.bounds = CGRectMake(0, 0, 150, 30);
    label.center = self.view.center;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:17];
    [[UIApplication sharedApplication].keyWindow addSubview:label];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:label];
    
      if (error) {
            label.text = SDPhotoBrowserSaveImageFailText;
        }   else {
            label.text = SDPhotoBrowserSaveImageSuccessText;
        }
    [label performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
}

-(void)addLabels{
    self.sliderLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width/2-20, 44, 60, 30)];
    self.sliderLabel.backgroundColor = [UIColor clearColor];
    self.sliderLabel.textColor = [UIColor whiteColor];
    self.sliderLabel.text = [NSString stringWithFormat:@"%ld/%lu",self.currentIndex+1,(unsigned long)self.imgArr.count];
    [self.view addSubview:self.sliderLabel];
}

-(void)addNameLabels{
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width/2-40, screen_height/2+240, 200, 60)];
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.nameLabel.textColor = [UIColor whiteColor];
    if(self.imageNameArray.count>0){
        
        self.nameLabel.text =self.imageNameArray[self.currentIndex];
    }else{
        self.nameLabel.text =@"";
    }
    [self.view addSubview:self.nameLabel];
}

-(void)setPicCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    self.scrollView.contentOffset = CGPointMake(screen_width*currentIndex, 0);
    [self loadPhote:_currentIndex];
    [self loadPhote:_currentIndex+1];
    [self loadPhote:_currentIndex-1];
}

-(void)loadPhote:(NSInteger)index{
    if (index<0 || index >=self.imgArr.count) {
        return;
    }
    
    id currentPhotoView = [_subViewList objectAtIndex:index];
    if (![currentPhotoView isKindOfClass:[PhotoView class]]) {
        //url数组
        CGRect frame = CGRectMake(index*_scrollView.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
        PhotoView *photoV = [[PhotoView alloc] initWithFrame:frame withPhotoUrl:[self.imgArr objectAtIndex:index]];
        photoV.delegate = self;
        [self.scrollView insertSubview:photoV atIndex:0];
        [_subViewList replaceObjectAtIndex:index withObject:photoV];
    }else{
        PhotoView *photoV = (PhotoView *)currentPhotoView;
    }
    
}

#pragma mark - PhotoViewDelegate
-(void)TapHiddenPhotoView{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)OnTapView{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}
//手势
-(void)pinGes:(UIPinchGestureRecognizer *)sender{
    if ([sender state] == UIGestureRecognizerStateBegan) {
        lastScale = 1.0;
    }
    CGFloat scale = 1.0 - (lastScale -[sender scale]);
    lastScale = [sender scale];
    self.scrollView.contentSize = CGSizeMake(self.imgArr.count*screen_width, screen_height*lastScale);
    NSLog(@"scale:%f   lastScale:%f",scale,lastScale);
    CATransform3D newTransform = CATransform3DScale(sender.view.layer.transform, scale, scale, 1);
    
    sender.view.layer.transform = newTransform;
    if ([sender state] == UIGestureRecognizerStateEnded) {
        //
    }
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int i = scrollView.contentOffset.x/screen_width+1;
    //判断是否为第一张
    if(i>=1){
        
        [self loadPhote:i-1];
        self.sliderLabel.text = [NSString stringWithFormat:@"%d/%lu",i,(unsigned long)self.imgArr.count];
        self.nameLabel.text=self.imageNameArray[i-1];
        
    }
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
