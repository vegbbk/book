//
//  DownloadController.m
//  BOOK
//
//  Created by liujianji on 16/3/7.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "DownloadController.h"
#import "magazineViewCell.h"
//#import "AFHTTPRequestOperation.h"
#import "ReaderViewController.h"
@interface DownloadController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,ReaderViewControllerDelegate>
{
    UICollectionView *collecView;
    UILabel *headerLab;//头部试图
    UILabel *promptLabt;
    NSString *filePath;
//    AFHTTPRequestOperation *operation;
    
    
    
}

@end

@implementation DownloadController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden=NO;
   self.navigationController.navigationBar.translucent=NO;
//    self.automaticallyAdjustsScrollViewInsets=YES;
    
    
}
//-(void)viewWillDisappear:(BOOL)animated{
//  self.navigationController.navigationBar.translucent=YES;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"返回"] highImage:[UIImage imageNamed:@"返回"] target:self action:@selector(BackHome) forControlEvents:UIControlEventTouchUpInside];
    [self createFrame];
//    UIProgressView  *downProgressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
//    downProgressView.center = CGPointMake(self.view.center.x, 220);
//    downProgressView.progress = 0;
//    downProgressView.progressTintColor = [UIColor blueColor];
//    downProgressView.trackTintColor = [UIColor grayColor];
//    [self.view addSubview:downProgressView];
//    
//    //设置存放文件的位置（此Demo把文件保存在iPhone沙盒中的Documents文件夹中。关于如何获取文件路径，请自行搜索相关资料）
//    //方法一
//    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    //    NSString *cachesDirectory = [paths objectAtIndex:0];
//    //    NSString *filePath = [cachesDirectory stringByAppendingPathComponent:@"文件名"];
//    //方法二
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *cachesDirectory = [paths objectAtIndex:0];
//     NSString *filePath = [cachesDirectory stringByAppendingPathComponent:@"文件名"];
//    //打印文件保存的路径
//    NSLog(@"%@",filePath);
//    
//    //创建请求管理
//    operation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"下载地址"]]];
//    
//    //添加下载请求（获取服务器的输出流）
//    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:NO];
//    
//    //设置下载进度条
//    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
//        
//        //显示下载进度
//        CGFloat progress = ((float)totalBytesRead) / totalBytesExpectedToRead;
//        [downProgressView setProgress:progress animated:YES];
//    }];
//    
//    //请求管理判断请求结果
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        //请求成功
//        NSLog(@"Finish and Download to: %@", filePath);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        //请求失败
//        NSLog(@"Error: %@",error);
//    }];

}

//创建控件
-(void)createFrame{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    self.view.backgroundColor=[UIColor whiteColor];
    headerLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, CZScreenW, 40)];
   
   

    [self.view addSubview:headerLab];
    headerLab.text=@"已下载3本 占用大小500M(长按可删除)";
    headerLab.textColor=[UIColor grayColor];
    headerLab.textAlignment=NSTextAlignmentCenter;
    headerLab.font=[UIFont systemFontOfSize:13];
    
    collecView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, CZScreenW, CZScreenH-40) collectionViewLayout:layout];
    collecView.delegate=self;
    collecView.dataSource=self;
    collecView.backgroundColor=[UIColor whiteColor];
    
    [collecView registerClass:[magazineViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:collecView];

}
//返回
-(void)BackHome{
//    AppDelegate  *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    
//    [tempAppDelegate.LeftSlideVC openLeftView];
  [self.navigationController popToRootViewControllerAnimated:YES];

//    [self.navigationController popViewControllerAnimated:NO];
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
    
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    magazineViewCell *cell=[magazineViewCell cellCollectionWith:collectionView :indexPath];
    cell.imgView.image=[UIImage imageNamed:@"图层 2"];
    cell.labName.text=@"哈哈";
    return cell;
    
}
- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath

{
    
    return CGSizeMake ( CZScreenW/3-20 ,CZScreenH*0.21 );
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *phrase = nil; // Document password (for unlocking most encrypted PDF files)
    
//    NSString* plistfile1 = [[NSBundle mainBundle]pathForResource:@Property List ofType:@plist];
//    NSMutableDictionary* data = [[NSMutableDictionary alloc]initWithContentsOfFile:plistfile1];
    NSMutableArray  *dicArray=[[NSMutableArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"downPDF" ofType:@"plist"]];
    NSDictionary *dic=[dicArray objectAtIndex:0];
    
//    NSArray *pdfs = [[NSBundle mainBundle] pathsForResourcesOfType:@"pdf" inDirectory:nil];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:[dic objectForKey:@"OpenCV"]ofType:@"pdf"];
    //    NSArray *pdf=[[NSBundle mainBundle]pathForResource:@"OpenCV" ofType:@"pdf"];
    
    
//    NSString *filePath = [pdfs firstObject]; assert(filePath != nil); // Path to first PDF file
//    NSString *filePath=nil;
//    
//   filePath=[pdfs firstObject];assert(filePath!=nil);
    
    
    ReaderDocument *document = [ReaderDocument withDocumentFilePath:imagePath password:phrase];
    
    if (document != nil) // Must have a valid ReaderDocument object in order to proceed with things
    {
        ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
        
        readerViewController.delegate = self; // Set the ReaderViewController delegate to self
        
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
        
        
     
                [self.navigationController pushViewController:readerViewController animated:YES];
        
        
#else // present in a modal view controller
        
        		readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        		readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        
        [self presentViewController:readerViewController animated:YES completion:NULL];
        
#endif // DEMO_VIEW_CONTROLLER_PUSH
    }
    else // Log an error so that we know that something went wrong
    {
        NSLog(@"%s [ReaderDocument withDocumentFilePath:'%@' password:'%@'] failed.", __FUNCTION__, filePath, phrase);
    }

}
- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
    
    [self.navigationController popViewControllerAnimated:YES];
    
#else // dismiss the modal view controller
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
#endif // DEMO_VIEW_CONTROLLER_PUSH
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 5, 5, 10);
    
}
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

@end
