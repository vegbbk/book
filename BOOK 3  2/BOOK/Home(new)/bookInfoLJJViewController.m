//
//  bookInfoLJJViewController.m
//  BOOK
//
//  Created by liujianji on 17/2/13.
//  Copyright © 2017年 liujianji. All rights reserved.
//

#import "bookInfoLJJViewController.h"
#import "PellTableViewSelect.h"
#import <MediaPlayer/MediaPlayer.h>
#import "bookInfoCommentLJJTableViewCell.h"
#import "bookInfoCommentsModel.h"
#import "magazineTool.h"
#import "BBSTool.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import <ShareSDKExtension/SSEShareHelper.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>
#import "GuideView.h"
#import "detailCollocViewController.h"
@interface bookInfoLJJViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIWebViewDelegate,UIGestureRecognizerDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>{

    UITextField *textFiled;
    UIView *view1;
    UIButton *sendBtn;
    MPMoviePlayerViewController *movie;
    GuideView *markView;
    UIView * bgView;
    UIView * bgViewTwo;
    UILabel * labeltishi;
    BOOL isSelect;
}
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)UIWebView * webView;
@property (nonatomic,copy)NSString * url;
@property (nonatomic,strong)NSMutableArray * dataArr;
@end

@implementation bookInfoLJJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:18],NSFontAttributeName,nil]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _dataArr = [NSMutableArray array];
    self.title = NSLocalizedString(@"Magazine details", @"Magazine details");
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"返回"] highImage:[UIImage imageNamed:@"返回"] target:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
   // [self createTable];
    
    if(self.videoUrl){
    [self playViode];
    }
    self.url = [NSString stringWithFormat:@"http://www.china2wheels.com/c2w/%@/mobile/index.html",self.IDstr];
    [self createLeftButton];
  //  [self loadCommentsList];
   [self createfooterFrame];
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"secondCouponBoard_iPhone"]){
    [self newUserGuide];
    }
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"firstCouponBoard_iPhone"]){
        [self nextLast];
    }
}

#pragma mark -------------------播放关闭电影--------------------------------------
-(void)playViode{
    
    movie=[[MPMoviePlayerViewController alloc]initWithContentURL:_videoUrl];
    movie.view.frame=self.view.bounds;
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(CZScreenH-60, 5, 60, 30)];
    [btn setTitle:@"exit" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    [movie.view addSubview:btn];
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(exit)];
    movie.view.transform =CGAffineTransformMakeRotation((M_PI / 2.0));
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft; //向右
    [movie.view addGestureRecognizer:swipeGesture];
    [self presentMoviePlayerViewControllerAnimated:movie];
    movie.moviePlayer.controlStyle = MPMovieControlStyleNone;
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:NO];
    [movie.moviePlayer play];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(exit) name:MPMoviePlayerDidExitFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exit) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}
//关闭电影
-(void)exit{
    [self dismissViewControllerAnimated:NO completion:nil];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
}
//返回
-(void)backHome{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark -----------------------------更多模块---------------------------------------
- (void)createLeftButton{
    
    CGSize size ;
    NSString * str= NSLocalizedString(@"browse", @"browse");
    NSString * string = [NSString stringWithFormat:@"%@%@",str,self.post_hits];
    size = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    UIView * view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0,30+size.width+2, 40);
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 9, 30, 22)];
    imageView.image = [UIImage imageNamed:@"eye_03"];
    [view addSubview:imageView];
    
    UILabel * label = [[UILabel alloc]init];
    label.frame = CGRectMake(30, 10, size.width+2, 20);
    label.font = [UIFont systemFontOfSize:14];
    label.text = string;
    label.textAlignment = NSTextAlignmentLeft;
    [view addSubview:label];
    
     UIBarButtonItem *releaseButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:view];
     NSArray * arr = @[releaseButtonItem2];
     self.navigationItem.rightBarButtonItems = arr;
}
-(void)releaseInfo{

    [self clikeHobyBtn];
}

- (void)loadCommentsList{

   [magazineTool magazineCommentsList:self.postIDStr andsuccess:^(id arr) {
    
    _dataArr = [NSMutableArray arrayWithArray:arr];
    [self.tableView reloadData];
   } failure:^(NSError * error) {
    
   }];

}
#pragma mark ---------------------创建视图---------------------------------
- (void)createTable{
    if(!_where){
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CZScreenW, CZScreenH-64) style:UITableViewStyleGrouped];
    }else{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, CZScreenW, CZScreenH-64) style:UITableViewStyleGrouped];
    }
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = NO;
  //  self.tableView.emptyDataSetSource = self;
  //  self.tableView.emptyDataSetDelegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"bookInfoCommentLJJTableViewCell" bundle:nil] forCellReuseIdentifier:@"infoLJJcell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;

    [self createfooterFrame];
}

//创建底部视图
-(void)createfooterFrame{
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, CZScreenH-64-40)];
    _webView.delegate = self;
    _webView.userInteractionEnabled = YES;
    _webView.scrollView.scrollEnabled = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURLRequest * request;
        
        NSString * encodingString = [_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:encodingString]];
        //回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            //将请求加载到WebView上
            [_webView loadRequest:request];
            
        });
    });
    [self.view addSubview:_webView];

    
    if(!_where){
    view1=[[UIView alloc]initWithFrame:CGRectMake(0, CZScreenH-40-64, CZScreenW,40 )];
    }else{
    view1 = [[UIView alloc]initWithFrame:CGRectMake(0, CZScreenH-40, CZScreenW,40 )];
    }
    //    view1.backgroundColor=[UIColor redColor];
    view1.backgroundColor = [UIColor whiteColor];
    view1.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    view1.layer.borderWidth=1.0;
   // view1.hidden = YES;
    textFiled=[[UITextField alloc]initWithFrame:CGRectMake(10, 5, CZScreenW-140, 30)];
    [view1 addSubview:textFiled];
    
    textFiled.placeholder=NSLocalizedString(@"Please fill in the comments", @"Please fill in the comments");
    //设置return建的样式
    textFiled.returnKeyType=UIReturnKeySend;
    textFiled.leftView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"填写评论"]];
    textFiled.leftViewMode=UITextFieldViewModeAlways;
    textFiled.delegate=self;
    textFiled.layer.cornerRadius = 10;
    textFiled.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textFiled.layer.borderWidth = 1;
    //收藏
    UIButton * collocetionBtn =[[UIButton alloc]initWithFrame:CGRectMake(CZScreenW-120,7, 30,26)];
   // [collocetionBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [collocetionBtn setImage:[UIImage imageNamed:@"收藏_07"] forState:UIControlStateNormal];
    [collocetionBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    collocetionBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [view1 addSubview:collocetionBtn];
    [collocetionBtn addTarget:self action:@selector(collocetionBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //分享
    UIButton * shareBtn=[[UIButton alloc]initWithFrame:CGRectMake(CZScreenW-80, 7, 30, 26)];
    //[shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"分享_07"] forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [view1 addSubview:shareBtn];
    [shareBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    
    //评论
    sendBtn=[[UIButton alloc]initWithFrame:CGRectMake(CZScreenW-30-10, 7, 30, 26)];
   // [sendBtn setTitle:@"评论" forState:UIControlStateNormal];
    [sendBtn setImage:[UIImage imageNamed:@"评分_07"] forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    sendBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [view1 addSubview:sendBtn];
    [sendBtn addTarget:self action:@selector(commentsSends) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:view1];
    
}
#pragma mark-------收藏-----------
-(void)collocetionBtnClick{

    [self clikeHobyBtn];
}
#pragma mark-------分享-----------
-(void)shareClick{

 [self showShareActionSheet:self.view];

}
#pragma mark-------评论-----------
-(void)commentsSends{

 //[_tableView setContentOffset:CGPointMake(_tableView.contentOffset.x,CZScreenH-64-40) animated:YES];
    detailCollocViewController * detail = [[detailCollocViewController alloc]init];
    detail.postIDStr = self.postIDStr;
    [self.navigationController pushViewController:detail animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1f;
    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//
//    return 40;
//
//}
//
//-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//
//    
//    labeltishi = [[UILabel alloc]init];
//    labeltishi.frame = CGRectMake(0, 20, CZScreenW, 20);
//    labeltishi.text = NSLocalizedString(@"No one comment", @"No one comment");
//    labeltishi.textColor = [UIColor grayColor];
//    labeltishi.textAlignment = NSTextAlignmentCenter;
//    if(_dataArr.count==0){
//    return labeltishi;
//    }else{
//    
//        return nil;
//    }
//
//}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if(indexPath.row==0){
        return CZScreenH-64-40;
    }else if(indexPath.row==1){
        return 44.0;
    }else{
        return UITableViewAutomaticDimension;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row==0){
        
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        if(_webView==nil){
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, CZScreenH-64-40)];
        _webView.delegate = self;
        _webView.userInteractionEnabled = YES;
            _webView.scrollView.scrollEnabled = NO;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURLRequest * request;
            
            NSString * encodingString = [_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            request = [NSURLRequest requestWithURL:[NSURL URLWithString:encodingString]];
            //回到主线程刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                //将请求加载到WebView上
                [_webView loadRequest:request];
                
            });
        });
        [cell.contentView addSubview:_webView];
        }
//        UISwipeGestureRecognizer*  _swipeGestureRecognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
//        [_swipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionDown];
//        _swipeGestureRecognizer.delegate = self;
//        [cell addGestureRecognizer:_swipeGestureRecognizer];
//        
//        UISwipeGestureRecognizer*  swipeGestureRecognizer1=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
//        [swipeGestureRecognizer1 setDirection:UISwipeGestureRecognizerDirectionUp];
//        swipeGestureRecognizer1.delegate = self;
//        [cell addGestureRecognizer:swipeGestureRecognizer1];

        return cell;
    }else if(indexPath.row==1){
        
        static NSString *identifier = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            /* 忽略点击效果 */
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = NSLocalizedString(@"comments", @"comments");
            cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
            cell.detailTextLabel.text = @"3";
        }
        return cell;
    }else{
        
        bookInfoCommentLJJTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"infoLJJcell" forIndexPath:indexPath];
        if (_dataArr.count>indexPath.row-2) {
            bookInfoCommentsModel * model = _dataArr[indexPath.row-2];
            [cell loadDataWith:model];
        }
        return cell;
    }
}
- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)sender
{
  
//    if(sender.direction == UISwipeGestureRecognizerDirectionUp){
//    // _tableView.contentOffset = sender.view.center;
//    [_tableView setContentOffset:CGPointMake(_tableView.contentOffset.x,sender.view.center.y+_tableView.contentOffset.y) animated:YES];
//    }else{
//        if(_tableView.contentOffset.y>0){
//    [_tableView setContentOffset:CGPointMake(_tableView.contentOffset.x,_tableView.contentOffset.y-sender.view.center.y) animated:YES];
//        }
//    }
       //do something ...
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
//     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//         markView = [[GuideView alloc]initWithFrame:CGRectMake(0, 0, CZScreenW, CZScreenH)];
//         markView.fullShow = YES;
//         markView.model = GuideViewCleanModeRoundRect;
//         markView.showRect = CGRectMake(210, 380, 120, 80);
//         [[UIApplication sharedApplication].keyWindow addSubview:markView];
//
//    });
}


#pragma mark ------------评论逻辑-----------------------------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.tableView.contentOffset.y > 0)
    {
       // view1.hidden = NO;
    }
    else
    {
       // view1.hidden = YES;
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *phoneAccount=[ud objectForKey:@"userid"];
    if(phoneAccount==nil ){
        [MBProgressHUD showSuccess:NSLocalizedString(@"Not logged in", @"Not logged in") toView:self.view];
        return NO;
    }else{
        self.view.frame=CGRectMake(0, -258+64, CZScreenW, CZScreenH);
        return YES;
    }
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [textFiled resignFirstResponder];
    self.view.frame=CGRectMake(0, 64, CZScreenW, CZScreenH);
    return YES;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //调用发送界面
    [self clikeSends];
    self.view.frame=CGRectMake(0, 64, CZScreenW, CZScreenH);
   // [_tableView setContentOffset:CGPointMake(_tableView.contentOffset.x,CZScreenH-64-40) animated:YES];
    return YES;
}

-(void)clikeSends{
    
    [textFiled resignFirstResponder];
    NSString *contet=textFiled.text;
    if([contet isEqualToString:@""]){
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Words can't be empty", @"Words can't be empty")];
    }else{
        
        [BBSTool publishedcomment:self.postIDStr content:contet success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            [SVProgressHUD showSuccessWithStatus:@"评论成功"];
           // [self loadCommentsList];
            textFiled.text=@"";
        } failure:^(NSError *error) {
            
        }];
        
    }
    
}
#pragma mark -----------收藏--------------
//收藏
-(void)clikeHobyBtn{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *phoneAccount=[ud objectForKey:@"userid"];
    if (phoneAccount==nil ) {
        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Not logged in", @"Not logged in")];
    }else{
       
            [BBSTool post_sc:self.postIDStr success:^(id responseObject) {
                NSString *urlStr=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
                [SVProgressHUD showSuccessWithStatus:urlStr];
                
            } failure:^(NSError *error) {
                
            }];
    }
}

- (void)showShareActionSheet:(UIView *)view
{
  
    NSString *urlstr1;
    NSString *urlStr2;
    //DirectoryModel *detailModel;
    
    //       NSURL *url;
    
    __weak bookInfoLJJViewController *theController = self;
//    if(magaArray.count==0){
//        
//    }else{
      //  detailModel=[magaArray objectAtIndex:page];
        urlstr1=[NSString stringWithFormat:@"index.php?g=portal&m=article&a=index&id=%@",_postIDStr];
        urlStr2=[NSString stringWithFormat:@"%@%@",LOCAL,urlstr1];
        
        //         url=[NSURL URLWithString:urlStr2];
        
        //1、创建分享参数（必要）
        
        
   // }
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSArray* imageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"180.png"], nil];
    
    NSURL *url=[[NSURL alloc]initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"180" ofType:@"png"]];
    //    NSString *urlStr2;
    //    NSURL *url;
    [shareParams SSDKSetupShareParamsByText:urlStr2
                                     images:imageArray
                                        url:[NSURL URLWithString:urlStr2]
                                      title:@"分享内容"
                                       type:SSDKContentTypeAuto];
    
    //1.2、自定义分享平台（非必要）
    NSMutableArray *activePlatforms = [NSMutableArray arrayWithArray:[ShareSDK activePlatforms]];
    //添加一个自定义的平台（非必要）
    SSUIShareActionSheetCustomItem *item = [SSUIShareActionSheetCustomItem itemWithIcon:[UIImage imageNamed:@"Icon.png"]
                                                                                  label:@"自定义"
                                                                                onClick:^{
                                                                                    
                                                                                    //自定义item被点击的处理逻辑
                                                                                    NSLog(@"=== 自定义item被点击 ===");
                                                                                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"自定义item被点击"
                                                                                                                                        message:nil
                                                                                                                                       delegate:nil
                                                                                                                              cancelButtonTitle:@"确定"
                                                                                                                              otherButtonTitles:nil];
                                                                                    [alertView show];
                                                                                }];
    [activePlatforms addObject:item];
    
    //2、分享
    [ShareSDK showShareActionSheet:view
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                           
                       case SSDKResponseStateBegin:
                       {
                          // [theController showLoadingView:YES];
                           break;
                       }
                       case SSDKResponseStateSuccess:
                       {
                           if (platformType == SSDKPlatformTypeFacebookMessenger)
                           {
                               break;
                           }
                           
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           if (platformType == SSDKPlatformTypeSMS && [error code] == 201)
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、短信应用没有设置帐号；2、设备不支持短信应用；3、短信应用在iOS 7以上才能发送带附件的短信。"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           else if(platformType == SSDKPlatformTypeMail && [error code] == 201)
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、邮件应用没有设置帐号；2、设备不支持邮件应用；"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           else
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           break;
                       }
                       case SSDKResponseStateCancel:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       default:
                           break;
                   }
                   
                   if (state != SSDKResponseStateBegin)
                   {
                      // [theController showLoadingView:NO];
                       //                       [theController.tableView reloadData];
                   }
                   
               }];
    
    //另附：设置跳过分享编辑页面，直接分享的平台。
    //        SSUIShareActionSheetController *sheet = [ShareSDK showShareActionSheet:view
    //                                                                         items:nil
    //                                                                   shareParams:shareParams
    //                                                           onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
    //                                                           }];
    //
    //        //删除和添加平台示例
    //        [sheet.directSharePlatforms removeObject:@(SSDKPlatformTypeWechat)];
    //        [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];
    
}

/**
 *  显示加载动画
 *
 *  @param flag YES 显示，NO 不显示
 */
//- (void)showLoadingView:(BOOL)flag
//{
//    if (flag)
//    {
//        [self.view addSubview:self.panelView];
//        [self.loadingView startAnimating];
//    }
//    else
//    {
//        [self.panelView removeFromSuperview];
//    }
//}

#pragma mark -----------------新手指引-------------------------

- (void)newUserGuide
{
    // 这里创建指引在这个视图在window上
    CGRect frame = [UIScreen mainScreen].bounds;
    bgView = [[UIView alloc]initWithFrame:frame];
    bgView.backgroundColor = [UIColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 0.6];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,70,CZScreenW,CZScreenW/640.0* 360)];
    imageView.image = [UIImage imageNamed:@"翻阅杂志_03"];
    [bgView addSubview:imageView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,CGRectGetMaxY(imageView.frame)+10,CZScreenW, CZScreenW/640.0* 360);
    [button setImage:[UIImage imageNamed:@"翻阅杂志_下一步_03"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(nextTwo) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:button];
}


-(void)nextTwo{

    [bgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    

    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,(CZScreenH-CZScreenW/640.0*557)/2.0,CZScreenW, CZScreenW/640.0*557)];
    imageView.image = [UIImage imageNamed:@"上下滑动_03"];
    [bgView addSubview:imageView];

    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nextLast)];
    [bgView addGestureRecognizer:tap];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];

    
}

-(void)nextLast{
     NSUserDefaults* userDefaultsss = [NSUserDefaults standardUserDefaults];
    [userDefaultsss setObject:@"12" forKey:@"firstCouponBoard_iPhone"];
     [userDefaultsss synchronize];
    for (UISwipeGestureRecognizer *recognizer in [[self view] gestureRecognizers]) {
        [[self view] removeGestureRecognizer:recognizer];
    }
    if(!bgView){
    CGRect frame = [UIScreen mainScreen].bounds;
    bgView = [[UIView alloc]initWithFrame:frame];
    bgView.backgroundColor = [UIColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 0.6];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    }
    [bgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40,CZScreenH-65-(CZScreenW-50)/468.0* 357,CZScreenW-50,(CZScreenW-50)/468.0* 357)];
    imageView.image = [UIImage imageNamed:@"固定位置_02"];
    [bgView addSubview:imageView];
    
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(CZScreenW/2.0-20, CZScreenH-CZScreenW/2.0/291.0*199-140, CZScreenW/2.0, CZScreenW/2.0/291.0*199);
    [button1 setImage:[UIImage imageNamed:@"固定位置_不在显示01_04"] forState:UIControlStateNormal];
    [button1 setImage:[UIImage imageNamed:@"固定位置_不在现实02_04"] forState:UIControlStateSelected];
    [button1 addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:button1];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(CZScreenW/2.0, CZScreenH-CZScreenW/2.0/318.0*185-80, CZScreenW/2.0, CZScreenW/2.0/318.0*185);
    [button setImage:[UIImage imageNamed:@"固定位置_下一步_03"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(newUserGuideTwo) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:button];
    
}

-(void)selectClick:(UIButton*)btn{

    isSelect = !isSelect;
    btn.selected = !btn.selected;
    NSUserDefaults* userDefaultsss = [NSUserDefaults standardUserDefaults];

    if(isSelect){

          [userDefaultsss setObject:nil  forKey:@"firstCouponBoard_iPhone"];
       // [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstCouponBoard_iPhone"];
    }else{
    
         [userDefaultsss setObject:@"12" forKey:@"firstCouponBoard_iPhone"];
    }
    
     [userDefaultsss synchronize];
}

- (void)newUserGuideTwo
{
    // 这里创建指引在这个视图在window上
//    CGRect frame = [UIScreen mainScreen].bounds;
//    bgView = [[UIView alloc]initWithFrame:frame];
//    bgView.backgroundColor = [UIColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 0.6];
//    [[UIApplication sharedApplication].keyWindow addSubview:bgViewTwo];
     if(![[NSUserDefaults standardUserDefaults] objectForKey:@"secondCouponBoard_iPhone"]){
    [bgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15,CZScreenH-10-(CZScreenW-30)/541.0* 399,CZScreenW-30,(CZScreenW-30)/541.0* 399)];
    imageView.image = [UIImage imageNamed:@"评分_02"];
    [bgView addSubview:imageView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(CZScreenW-200, CZScreenH-CZScreenW/640.0* 446/2-50, 200,200/640.0* 360);
    [button setImage:[UIImage imageNamed:@"浏览详情下一步_03"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(nextThree) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:button];
     }else{
      [bgView removeFromSuperview];
     }
}



-(void)nextThree{

    [bgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,CZScreenH-10-CZScreenW/640.0* 278,CZScreenW,CZScreenW/640.0* 278)];
    imageView.image = [UIImage imageNamed:@"收藏_02"];
    [bgView addSubview:imageView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, CZScreenH-CZScreenW/2.0/388.0*192-20, CZScreenW/2.0, CZScreenW/2.0/388.0*192);
    [button setImage:[UIImage imageNamed:@"收藏_下一步_02"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(nextFour) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:button];

}

-(void)nextFour{

    [bgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,CZScreenH-10-CZScreenW/640.0* 315,CZScreenW,CZScreenW/640.0* 315)];
    imageView.image = [UIImage imageNamed:@"分享_02"];
    [bgView addSubview:imageView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, CZScreenH-CZScreenW/633.0*133-10-CZScreenW/640.0* 315, CZScreenW, CZScreenW/633.0*133);
    [button setImage:[UIImage imageNamed:@"分享_我知道了_03"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(knowClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:button];

}

-(void)knowClick{

    [bgView removeFromSuperview];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"secondCouponBoard_iPhone"];
    
}

/**
 *   新手指引确定
 */
- (void)sureTapClick:(UITapGestureRecognizer *)tap
{
    UIView * view = tap.view;
    [view removeFromSuperview];
    [view removeAllSubviews];
    [view removeGestureRecognizer:tap];
   // [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstCouponBoard_iPhone"];
}

#pragma mark ---------DZNEmptyDataSetSource------

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString * string = NSLocalizedString(@"Oh, oh, there is no data!", @"Oh, oh, there is no data!");
    return [[NSAttributedString alloc]initWithString:string attributes:nil];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}



//返回标题文字
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"blankpage_image_Sleep"];
}
////返回详情文字
//- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
//    NSString *text = NSLocalizedString(@"Click refresh to refresh the data", @"Click refresh to refresh the data"); NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new]; paragraph.lineBreakMode = NSLineBreakByWordWrapping; paragraph.alignment = NSTextAlignmentCenter; NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f], NSForegroundColorAttributeName: [UIColor lightGrayColor], NSParagraphStyleAttributeName: paragraph}; return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//}
////返回可以点击的按钮 上面带文字
//- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{ NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
//    return [[NSAttributedString alloc] initWithString:NSLocalizedString(@"refresh", @"refresh") attributes:attributes];
//}
////点击button
//- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView{ // Do something
//
//    _isRemoveAll=YES;
//    _numPage=1;
//    [self loadData];
//
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

@end
