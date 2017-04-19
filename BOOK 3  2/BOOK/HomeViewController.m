//
//  HomeViewController.m
//  BOOK
//
//  Created by liujianji on 16/3/3.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "HomeViewController.h"
#import "UIBarButtonItem+Item.h"
#import "CZHttpTool.h"
#import "HomePageTool.h"
#import "iCarousel.h"
#import "homeModel.h"
#import "magazineModel.h"
#import "UIImageView+WebCache.h"
#import "magazineViewCell.h"
#import "bookInfoLJJViewController.h"
#import "magazineViewController.h"
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
#define Width [UIScreen mainScreen].bounds.size.width
@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>{
    UIScrollView *scroView;
    //    UICollectionView *colleView;
    UIScrollView *colleScrolView;
    NSInteger page;
    //    NSMutableArray *dataSource;
    //    NSMutableArray *magazineArray;
    NSMutableArray *freeArray;//免费数组
    NSMutableArray *issueArray;//特刊数组
    NSMutableArray *yearArray;//年份数组
    NSMutableArray *recommendedArray;//推荐数组
    NSMutableArray *dataSource;//数据数组
    NSMutableArray *allArray;
    UIImageView *bookImage;
    UIImageView *bookImageLeft;
    UIImageView *bookImageRight;
    UIView *headView;
    UILabel *bookName;
    UIButton *tempBtn;
    UIView *tempView;
    UIView *middleView;//中间试图
    NSInteger tempX;
    UICollectionView  *colleView;//集合视图
    NewPagedFlowView *pageFlowView;
}
/**
 *  无限轮播要使用的数组
 */
@property (nonatomic, strong) NSMutableArray *bannerImageArray;

/**
 *  真实数量的图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    self.tabBarController.tabBar.hidden=NO;
    if (recommendedArray==nil) {
        recommendedArray=[NSMutableArray array];

    }
    if (issueArray==nil) {
        issueArray=[NSMutableArray array];
        
    }
    if (freeArray==nil) {
          freeArray=[NSMutableArray array];
    }
    if (yearArray==nil) {
        yearArray= [NSMutableArray array];

    }
    if(allArray==nil){
    
        allArray = [NSMutableArray array];
    }
    if (dataSource==nil) {
        dataSource=[NSMutableArray array];

    }
    if (dataSource.count==0) {
        [self LoadData];
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"我的"] highImage:[UIImage imageNamed:@"我的"] target:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    [self createFrame];
    
    self.view.userInteractionEnabled=YES;
    self.navigationController.navigationBar.translucent=NO;
 
}

- (void)setupUI {
    
    pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, (CZScreenH*0.50*0.07)/2.0, Width,CZScreenH*0.50*0.93+40) ];
    pageFlowView.backgroundColor = [UIColor whiteColor];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.7;
    pageFlowView.minimumPageScale = 0.85;
    pageFlowView.orginPageCount = self.imageArray.count;
    [pageFlowView stopTimer];
   // pageFlowView.hidden = YES;
    //初始化pageControl
    [self.view addSubview:pageFlowView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(Width*0.6, CZScreenH*0.50*0.93);
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return [self.bannerImageArray count];
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 20, Width*0.6, CZScreenH*0.50*0.93)];
        bannerView.layer.cornerRadius = 4;
        bannerView.mainImageView.layer.shadowColor = [UIColor greenColor].CGColor;//阴影颜色
        bannerView.mainImageView.layer.shadowOffset = CGSizeMake(0, 4);//偏移距离
        bannerView.mainImageView.layer.shadowOpacity = 0.5;//不透明度
        bannerView.mainImageView.layer.shadowRadius = 3;//半径

        bannerView.layer.masksToBounds = YES;
    }
    
    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.bannerImageArray[index]] placeholderImage:[UIImage imageNamed:@"图层 3"]];
    bannerView.allCoverButton.tag = index;
    [bannerView.allCoverButton addTarget:self action:@selector(didSelectBannerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return bannerView;
}

#pragma mark --点击轮播图
- (void)didSelectBannerButtonClick:(UIButton *) sender {
    
    NSInteger index = sender.tag % self.imageArray.count;
     homeModel *home =[dataSource objectAtIndex:index];
    magazineViewController * info = [[magazineViewController alloc]init];
    info.hidesBottomBarWhenPushed=YES;
    info.IDstr = home.post_keywords;
    info.comment_count = home.comment_count;
    info.post_hits = home.post_hits;
    info.postIDStr = home.post_keywords;
    [self.navigationController pushViewController:info animated:YES];
    
}

- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (NSMutableArray *)bannerImageArray {
    if (_bannerImageArray == nil) {
        _bannerImageArray = [NSMutableArray array];
    }
    return _bannerImageArray;
}


-(void)LoadData{
    [HomePageTool HomePage:^(id responseObject) {
        bookImage.userInteractionEnabled=NO;
        NSArray *array=responseObject;
        [recommendedArray removeAllObjects];
        [issueArray removeAllObjects];
        [freeArray removeAllObjects];
        [yearArray removeAllObjects];
        allArray = [NSMutableArray arrayWithArray:array];
        for ( homeModel *homemodel in array ) {
            switch (homemodel.term_type) {
                case 1:
                    [recommendedArray addObject:homemodel];
                    break;
                case 2:
                    [freeArray addObject:homemodel];
                    break;
                case 3:
                    [issueArray addObject:homemodel];
                    break;
                case 4:
                    [yearArray addObject:homemodel];
                default:
                    break;
            }
        }
        [dataSource removeAllObjects];
        
        [dataSource addObjectsFromArray:allArray];
        [colleView reloadData];
        [self initDate];
//        if(dataSource.count>0) {
//            
//            for (int index = 0; index < dataSource.count; index++) {
//                homeModel *home=dataSource[index];
//                //判断当前是中文还是英文
//                NSString * imgurl=[NSString stringWithFormat:@"%@%@",LOCAL,home.type_img1];
//                
//                [self.imageArray addObject:imgurl];
//            }
//            
//            for (NSInteger imageIndex = 0; imageIndex < 3; imageIndex ++) {
//                [self.bannerImageArray addObjectsFromArray:self.imageArray];
//            }
//            [self setupUI];
//        }

    } failure:^(NSError *error) {
     }];
}

//刷新头部的数据
-(void)initDate{
    //添加手势
    if (dataSource.count==0) {
        
    }else{
        homeModel *home=[dataSource objectAtIndex:0];
        
        NSString *imgurl=nil;

        imgurl=[NSString stringWithFormat:@"%@%@",LOCAL,home.smeta];

        [bookImage sd_setImageWithURL:[NSURL URLWithString:imgurl] placeholderImage:nil];
        [bookImageLeft sd_setImageWithURL:[NSURL URLWithString:imgurl] placeholderImage:nil];
        [bookImageRight sd_setImageWithURL:[NSURL URLWithString:imgurl] placeholderImage:nil];
        bookName.text=home.post_title;
        bookName.font=[UIFont systemFontOfSize:14];
    }
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cliketerm_id)];
    tapGesture.numberOfTapsRequired=1;
    [bookImage addGestureRecognizer:tapGesture];
    bookImage.userInteractionEnabled=YES;

    
}

#pragma mark -- 对图片进行滤镜处理

//点击头部图片的方法
-(void)cliketerm_id{
    if(dataSource.count==0){
       [self updateSelectIndex:@""];
    }else{
        homeModel *home=[dataSource objectAtIndex:0];
       // [self updateSelectIndex:home.term_id];
        magazineViewController * info = [[magazineViewController alloc]init];
        info.hidesBottomBarWhenPushed=YES;
        info.IDstr = home.post_keywords;
        info.comment_count = home.comment_count;
        info.post_hits = home.post_hits;
        info.postIDStr = home.post_id;
        info.postImagName = home.smeta;
        info.POsturl = home.pdf_url;
        info.name = home.post_title;
        [self.navigationController pushViewController:info animated:YES];

    }
  
    
}
//切换tabBar的位置并传值
-(void)updateSelectIndex:(NSString *)term_id{
//    AppDelegate  *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    
//    UITabBarController *tababr=(UITabBarController *) [tempAppDelegate.navc.viewControllers objectAtIndex:0];
//    tababr.selectedIndex=1;
    if (![term_id isEqualToString:@""]) {
        NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
        [ud setObject:term_id forKey:@"term_id"];
    }
//    magazineViewController * info = [[magazineViewController alloc]init];
//    info.hidesBottomBarWhenPushed=YES;
//    
//    [self.navigationController pushViewController:info animated:YES];

}
//打开或者关闭左侧视图
- (void) openOrCloseLeftList
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}
//创建控件
-(void)createFrame{

    
    headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CZScreenH, CZScreenH*0.50)];

    bookImage=[[UIImageView alloc]initWithFrame:CGRectMake(CZScreenW*0.2, 40, CZScreenW*0.56, headView.height*0.93)];
    
    bookImageLeft = [[UIImageView alloc]initWithFrame:CGRectMake(-CZScreenW*0.45, 40, CZScreenW*0.6, headView.height*0.93)];
    bookImageLeft.alpha = 0.6;
    bookImageRight = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(bookImage.frame)+CZScreenW*0.05, 40, CZScreenW*0.6, headView.height*0.93)];
    bookImageRight.alpha = 0.6;
    //设置可以与用户交互
    bookImage.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
    bookImage.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
    bookImage.layer.shadowOpacity = 1;//不透明度
    bookImage.layer.shadowRadius = 16;//半径

    [headView addSubview:bookImage];
    [headView addSubview:bookImageLeft];
    [headView addSubview:bookImageRight];
    bookName=[[UILabel alloc]initWithFrame:CGRectMake(0, bookImage.height-30, bookImage.width, 30)];
    bookName.text=NSLocalizedString(@"No recommendation", @"No recommendation");
    
    bookName.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.9];
    bookName.textAlignment=NSTextAlignmentCenter;
    bookImage.image=[UIImage imageNamed:@"图层 3"];
    
    bookName.textColor=[UIColor whiteColor];
    [bookImage addSubview:bookName];

    
    [self.view addSubview:headView];
    middleView=[[UIView alloc]initWithFrame:CGRectMake(0, headView.height, CZScreenW, 44)];
    middleView.hidden = YES;
    [self.view addSubview:middleView];
    
    middleView.layer.borderColor=[[UIColor grayColor]CGColor];
    middleView.layer.borderWidth=1.0;
    NSArray *array=[NSArray arrayWithObjects:@"2016", NSLocalizedString(@"free" ,@"free"),NSLocalizedString(@"Aspecialissue", @"ASpecialIssue"), nil];
    
    for (int i=0; i<3; i++) {
        CGFloat width=self.view.width/3;
        CGFloat height=44;
        CGFloat x=i*width;
        CGFloat y=0;
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(x , y , width , height)];
        btn.hidden = YES;
        btn.tag=i+10;
        [middleView addSubview:btn];
      
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
        btn.titleLabel.textAlignment=NSTextAlignmentCenter;
        
        [btn setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(checkcycle:) forControlEvents:UIControlEventTouchUpInside];
        
        if(i==0){
            tempBtn=btn;
            tempView=[[UIView alloc]initWithFrame:CGRectMake(0, height-3, width, 3)];
            tempView.backgroundColor=RedColor;
            tempView.hidden = YES;
            [middleView addSubview:tempView];
            
        }
    }
   
    CGFloat colleH=CGRectGetMaxY(middleView.frame);
    
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
     colleView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, colleH, CZScreenW, CZScreenH*0.21) collectionViewLayout:layout];
    
        colleView.backgroundColor=[UIColor redColor];
        colleView.scrollEnabled=YES;
        colleView.backgroundColor=[UIColor whiteColor];
        colleView.delegate=self;
        colleView.dataSource=self;
        [colleView registerClass :[ magazineViewCell class ] forCellWithReuseIdentifier : @"cell" ];
        colleView.showsHorizontalScrollIndicator = FALSE;
        [self.view addSubview:colleView];

}


//点击事件
-(void)checkcycle:(UIButton *)btn{
    CGFloat x=btn.x;
    CGFloat y=btn.height;
    
    tempView.frame=CGRectMake(x, y-3 , self.view.width/3, 3);
    if(btn.tag==tempBtn.tag){
        return;
    }else{
        [tempBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        tempBtn=btn;
        //设置坐标
        NSInteger index=tempBtn.tag-10;
        [dataSource removeAllObjects];
        if (index==0) {
            [dataSource addObjectsFromArray:allArray];
        }else if(index==1){
            [dataSource addObjectsFromArray:freeArray];
            
        }else{
            [dataSource addObjectsFromArray:issueArray];
            
        }
        [colleView reloadData];
        
    }
}

-(NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataSource.count-1;
    
}
#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 的大小

//加载数据
//
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    magazineViewCell *cell=[magazineViewCell cellCollectionWith:collectionView :indexPath];
    NSString *imgurl=nil;
    homeModel *home=dataSource[indexPath.row+1];
    
    //判断当前是中文还是英文
    imgurl=[NSString stringWithFormat:@"%@%@",LOCAL,home.smeta];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:imgurl] placeholderImage:[UIImage imageNamed:@"杂志大图"]];
    cell.labName.text=home.post_title;
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    homeModel *home =[dataSource objectAtIndex:indexPath.row+1];
       [recommendedArray removeAllObjects];
    [recommendedArray addObject:home];
   // [self updateHeadImage:home];
    [pageFlowView scrollToPage:indexPath.row+dataSource.count];
    //magazineViewController  if (![term_id isEqualToString:@""]) {
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    [ud setObject:home.term_id forKey:@"term_id"];

    magazineViewController * info = [[magazineViewController alloc]init];
    info.hidesBottomBarWhenPushed=YES;
    info.IDstr = home.post_keywords;
    info.comment_count = home.comment_count;
    info.post_hits = home.post_hits;
    info.postIDStr = home.post_id;
    info.postImagName = home.smeta;
    info.POsturl = home.pdf_url;
    info.name = home.post_title;
    [self.navigationController pushViewController:info animated:YES];
}
//修改大图标的链接
-(void)updateHeadImage:(homeModel *)model{
    
    NSString *imgurl=nil;
    imgurl=[NSString stringWithFormat:@"%@%@",LOCAL,model.type_img1];

    [bookImage sd_setImageWithURL:[NSURL URLWithString:imgurl] placeholderImage:nil];
    
    bookName.text=model.post_title;

}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
    
}
//返回大小
- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath

{
    
    return CGSizeMake(CZScreenW/3-20 ,CZScreenH*0.21);
    
}
//返回间隔
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 15, 0, 15);
    
}
@end


