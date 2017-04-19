//
//  ZBNewFeatureController.m
//  ZBWeiBo
//
//  Created by teacher on 15-12-14.
//  Copyright (c) 2015年 Cycle. All rights reserved.
//

#import "ZBNewFeatureController.h"
#import "ZBNewFeatureCell.h"

@interface ZBNewFeatureController ()
@property(nonatomic,weak)UIPageControl *pagecontrol;
@end

@implementation ZBNewFeatureController

static NSString *ID= @"Cell";


- (instancetype)init
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    
//    设置cell尺寸
    layout.itemSize=[UIScreen mainScreen].bounds.size;

    //清空行距
    layout.minimumLineSpacing=0;
    //设置滚动方向
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:layout];
}
// self.collectionView != self.view
// 注意： self.collectionView 是 self.view的子控件

// 使用UICollectionViewController
// 1.初始化的时候设置布局参数
// 2.必须collectionView要注册cell
// 3.自定义cell
- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self.collectionView registerClass:[ZBNewFeatureCell class] forCellWithReuseIdentifier:ID];
    //分页
    self.collectionView.pagingEnabled=YES;
    self.collectionView.bounces=NO;
    self.collectionView.showsHorizontalScrollIndicator=NO;
    // 添加pageController
//    [self setUpPageControl];
}
//-(void)setUpPageControl
//{
//     // 添加pageController,只需要设置位置，不需要管理尺寸
//    UIPageControl *pagecontrol=[[UIPageControl alloc]init];
//    pagecontrol.numberOfPages=3;
//    pagecontrol.pageIndicatorTintColor=[UIColor grayColor]
//    ;
//    pagecontrol.currentPageIndicatorTintColor=[UIColor blackColor];
//    //设置center
////    pagecontrol.center=CGPointMake(self.view.width*0.5, self.view.height);
//    pagecontrol.center=CGPointMake(self.view.frame.size.width*0.5, self.view.frame.size.height * 0.9);
//    
//    _pagecontrol=pagecontrol;
//    [self.view addSubview:pagecontrol];
//    
//
//
//}
//#pragma mark - UIScrollView代理
//// 只要一滚动就会调用
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    // 获取当前的偏移量，计算当前第几页
//    int page=scrollView.contentOffset.x/scrollView.bounds.size.width+0.5;
//    if (_pagecontrol.currentPage == 3) {
//        _pagecontrol.hidden = YES;
//    }
//    //设置页数
//    _pagecontrol.currentPage=page;
//    NSLog(@"%ld",(long)page);
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 5;
}
// 返回cell长什么样子
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // dequeueReusableCellWithReuseIdentifier
    // 1.首先从缓存池里取cell
    // 2.看下当前是否有注册Cell,如果注册了cell，就会帮你创建cell
    // 3.没有注册，报错
    
    ZBNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if(!cell){
        cell=[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
        
    }
//    ZBNewFeatureCell *cell=[ZBNewFeatureCell cellCollectionWith:self.collectionView :indexPath ];
    
//    cell.backgroundColor=[UIColor redColor];
    
    //拼接图片名称 3.5  320  480
//    CGFloat ScreenH=[UIScreen mainScreen].bounds.size.height;
//    NSString *imageName=[NSString stringWithFormat:@"new_feature_%ld",indexPath.row + 1];
//    
//    if (ScreenH >480) {
//        imageName= [NSString stringWithFormat:@"new_feature_%ld-568h",indexPath.row + 1];
//    }
    NSArray *array1=[NSArray arrayWithObjects:@"启动页1.png",@"启动页2.png",@"启动页3.png",@"启动页4.png",@"启动页5.png", nil];
    
   
    
    cell.imageView.image=[UIImage imageNamed:[array1 objectAtIndex:indexPath.row]];
    
//    [cell.contentView addSubview:[[UIImageView alloc]initWithImage:[UIImage imageNamed:[array1 objectAtIndex:indexPath.row]]]];
    
//    cell.contentView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"启动页%li",indexPath.row]]];
    
    
    
    [cell setIndexPath:indexPath count:5];
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
