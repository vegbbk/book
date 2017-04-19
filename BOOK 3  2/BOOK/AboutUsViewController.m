//
//  AboutUsViewController.m
//  BOOK
//
//  Created by wangyang on 16/3/31.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()<UIWebViewDelegate>{
    UIWebView *wbView;
    
}

@end

@implementation AboutUsViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden=NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=NSLocalizedString(@"About us", @"About us");
    
     self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"返回"] highImage:[UIImage imageNamed:@"返回"] target:self action:@selector(BackHome) forControlEvents:UIControlEventTouchUpInside];
    [self CreateFrame];
    
    // Do any additional setup after loading the view.

}
-(void)CreateFrame{
    wbView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, CZScreenW, CZScreenH)];
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

    [self.view addSubview:wbView];
    wbView.delegate=self;
    NSString *urlStr;
    
//    NSString *imgurl=nil;
    
    if([language isEqualToString:@"en"]){
        urlStr=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=portal&m=article&a=index&id=6"];
        
        
    }else{
        //        [bookImage sd_setImageWithURL:[NSURL URLWithString:home.type_img1] placeholderImage:nil];
        urlStr=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=portal&m=article&a=index&id=7"];
    }
    NSURL *url=[NSURL URLWithString:urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [wbView loadRequest:request];
    
    
    
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}
-(void)BackHome{
    AppDelegate  *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [tempAppDelegate.LeftSlideVC openLeftView];
    //    [self.navigationController popViewControllerAnimated:NO];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    //    [self.navigationController popViewControllerAnimated:YES];
    
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
