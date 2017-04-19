//
//  advertController.m
//  BOOK
//
//  Created by wangyang on 16/4/8.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "advertController.h"

@interface advertController ()<UIWebViewDelegate>{
    UIWebView *wbView;
    
}

@end

@implementation advertController

- (void)viewDidLoad {
    [super viewDidLoad];
    wbView=[[UIWebView alloc]initWithFrame:self.view.bounds];
    NSURL *url=[NSURL URLWithString:_urlStr];
    wbView.delegate=self;
      self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"返回"] highImage:[UIImage imageNamed:@"返回"] target:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [wbView loadRequest:request];
    
    [self.view addSubview:wbView];
    
    // Do any additional setup after loading the view.
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
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
