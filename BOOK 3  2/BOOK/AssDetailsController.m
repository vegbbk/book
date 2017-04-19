//
//  AssDetailsController.m
//  BOOK
//
//  Created by liujianji on 16/3/9.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "AssDetailsController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "BBSTool.h"
#import "detailsIDModel.h"
@interface AssDetailsController ()<UIWebViewDelegate>{
    UIScrollView *scrollView;
    UILabel *nickName;
    UILabel *LabTime;
    UIImageView *imgView;
    UITextView *detailView;
    UIButton *playBtn;
    MPMoviePlayerViewController *mvp;
    UIWebView *wbView;
    detailsIDModel *detailModel;
    
    
}

@end

@implementation AssDetailsController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden=YES;
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self createFrame];
    self.navigationItem.title=NSLocalizedString(@"assessmentdetails", @"AssessmentDetails");
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"返回"] highImage:[UIImage imageNamed:@"返回"] target:self action:@selector(BackHome) forControlEvents:UIControlEventTouchUpInside];
    
    wbView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, CZScreenW, CZScreenH)];
    wbView.delegate=self;
    wbView.scalesPageToFit=NO;
    [self.view addSubview:wbView];
    wbView.dataDetectorTypes = UIDataDetectorTypeLink;
    //取消右侧，下侧滚动条，去处上下滚动边界的黑色背景
    wbView.backgroundColor=[UIColor clearColor];
    for (UIView *_aView in [wbView subviews])
    {
        if ([wbView isKindOfClass:[UIScrollView class]])
        {
            [(UIScrollView *)_aView setShowsVerticalScrollIndicator:NO];
            //右侧的滚动条
            
            [(UIScrollView *)_aView setShowsHorizontalScrollIndicator:NO];
            //下侧的滚动条
            
            for (UIView *_inScrollview in _aView.subviews)
            {
                if ([_inScrollview isKindOfClass:[UIImageView class]])
                {
                    _inScrollview.hidden = YES;  //上下滚动出边界时的黑色的图片
                }
            }
        }
    }
    [BBSTool detailSID:_post_id success:^(detailsIDModel *responseObject) {
        if([responseObject isEqual:nil]){
            [SVProgressHUD showSuccessWithStatus:@"内容不存在"];
            
        }
        detailModel=responseObject;
        [self initDate];
        
    } failure:^(NSError *error) {
        
    }];
    
    // Do any additional setup after loading the view.
}
-(void)BackHome{
// if()
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
-(void)initDate{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *urlstr1=[NSString stringWithFormat:@"index.php?g=portal&m=article&a=index&id=%@",detailModel.ID];
    
    NSString *urlStr2=[NSString stringWithFormat:@"%@%@",LOCAL,urlstr1];
    NSURL *url=[NSURL URLWithString:urlStr2];
    NSLog(@"%@",urlStr2);
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    [wbView loadRequest:request];
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES ];
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
}
//-(void)viewWillAppear:(BOOL)animated{
//    self.tabBarController.tabBar.hidden=YES;
//    
//}
-(void)createFrame{
//    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CZScreenW, CZScreenH)];
//    scrollView.showsHorizontalScrollIndicator=NO;
//    scrollView.showsVerticalScrollIndicator=NO;
//    
//    scrollView.contentSize=CGSizeMake(CZScreenW, CZScreenH*1.2);
//    [self.view addSubview:scrollView];
//    
//    nickName=[[UILabel alloc]initWithFrame:CGRectMake(0, 15, CZScreenW, 20)];
//    nickName.text=@"四大顶级跑车测评";
//    nickName.textColor=[UIColor blackColor];
//    nickName.textAlignment=NSTextAlignmentCenter;
//    [scrollView addSubview:nickName];
//    CGFloat timey=CGRectGetMaxY(nickName.frame)+10;
//    
//    LabTime=[[UILabel alloc]initWithFrame:CGRectMake(0, timey, CZScreenW, 20)];
//    LabTime.text=@"2016年3月12日09:22:06";
//    LabTime.textColor=[UIColor grayColor];
//    LabTime.textAlignment=NSTextAlignmentCenter;
//    LabTime.font=[UIFont systemFontOfSize:14];
//    [scrollView addSubview:LabTime];
//    CGFloat imgy=CGRectGetMaxY(LabTime.frame)+15;
//    
//    imgView=[[UIImageView alloc]initWithFrame:CGRectMake(15,imgy , CZScreenW-30, 130)];
//    imgView.image=[UIImage imageNamed:@"图层 1"];
//    playBtn=[[UIButton alloc]initWithFrame:CGRectMake(imgView.width*0.35, 40, imgView.width*0.3, 50)];
//    imgView.userInteractionEnabled=YES;
//    
//    [playBtn addTarget:self action:@selector(clikePlay) forControlEvents:UIControlEventTouchUpInside];
//    playBtn.userInteractionEnabled=YES;
//    
//    [imgView addSubview:playBtn];
//    [playBtn setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
//    
//    [scrollView addSubview:imgView];
//      detailView=[[UITextView alloc]init];
//    
//    detailView.text=@"爱莎克里斯的合法阿里山的返回家阿里的还是阿里山的减肥阿里山的发生阿斯兰的风景啊发来手机打发阿里附近啊 发生了分解 拉双方就阿里上飞机的说法就是拉萨到了房间as 可怜的飞洒水电费四大发生了分解阿斯顿阿里的快速分解按国家老公还要给啊爱哦问题要求 公司都能改善他大奖送发哦儿童打算幸福安全阀怡as打款发货是对方即可爱谁谁快递费爱莎克里斯的合法阿里山的返回家阿里的还是阿里山的减肥阿里山的发生阿斯兰的风景啊发来手机打发阿里附近啊 发生了分解 拉双方就阿里上飞机的说法就是拉萨到了房间as 可怜的飞洒水电费四大发生了分解阿斯顿阿里的快速分解按国家老公还要给啊爱哦问题要求 公司都能改善他大奖送发哦儿童打算幸福安全阀怡as打款发货是对方即可爱谁谁快递费";
//    detailView.showsVerticalScrollIndicator=NO;
//    detailView.showsHorizontalScrollIndicator=NO;
//    detailView.scrollEnabled=NO;
//    CGFloat detailW=CZScreenW-30;
//    
//    CGFloat detaily=CGRectGetMaxY(imgView.frame)+15;
//   
//    CGRect tmpRect = [detailView.text boundingRectWithSize:CGSizeMake(detailW, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil] context:nil];
//    NSLog(@"%.2f",tmpRect.size.height);
//    
//    detailView.frame=CGRectMake(15, detaily, detailW, tmpRect.size.height);
//    CGFloat contenty=detaily+tmpRect.size.height;
//    detailView.font=[UIFont systemFontOfSize:17];
//    detailView.userInteractionEnabled=NO;
//   
//    scrollView.contentSize=CGSizeMake(CZScreenW, contenty);
//    scrollView.scrollEnabled=YES;
//    [detailView resignFirstResponder];
//    
//
//    detailView.textColor=[UIColor grayColor];
//    [scrollView addSubview:detailView];
////    detailView.font=[UIFont systemFontOfSize:17];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//播放视屏
-(void)clikePlay{
//    NSLog(@"asfasfsaosghaskgh");
//    
//    mvp=[[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:@"http://v.youku.com/v_show/id_XODY1NDc1MjY0.html"]];
//    [self presentMoviePlayerViewControllerAnimated:mvp];
//    [mvp.moviePlayer play];
    
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
