//
//  releaseDetailController.m
//  BOOK
//
//  Created by liujianji on 16/3/10.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "releaseDetailController.h"
#import "MeasureViewCell.h"
#import "commentSViewCell.h"
#import "BBSTool.h"
#import "commentsModel.h"
#import "detailsIDModel.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import "WyzAlbumViewController.h"
#import "UIButton+WebCache.h"
#import <ShareSDKExtension/SSEShareHelper.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>
#import "UITableView+FDTemplateLayoutCell.h"
@interface releaseDetailController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIWebViewDelegate>{
    UITableView *tabView;
    UITextField *textFiled;
    UIView *view1;
    UIWebView *wbView;
    //    CGFloat documentHeight;
    NSMutableArray *listArray;
    CGFloat cellHeiht;
    
    NSMutableArray *conmentArray;
    //    detailsIDModel *detailModel;
    NSMutableArray *detailArray;
    NSDictionary *detailDic;
    
     NSMutableArray *mUrlArray;
    UIButton *sendBtn;
    
    
}
@end

@implementation releaseDetailController
- (void)viewDidLoad {
    [super viewDidLoad];
       detailArray =[NSMutableArray array];
    
    //    self.navigationItem.title=@"论坛详情";
    self.automaticallyAdjustsScrollViewInsets=NO;
  
    
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
    //    self.navigationController.navigationBar.translucent=NO;
    //    self.navigationController.navigationBar.hidden=NO;
    
    listArray =[NSMutableArray array];
    tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, CZScreenW, CZScreenH-104)];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"返回"] highImage:[UIImage imageNamed:@"返回"] target:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
    tabView.delegate=self;
    tabView.dataSource=self;
    tabView.separatorStyle=UITableViewCellSeparatorStyleNone;
    if([_favarticle isEqualToString:@"favarticle"]){
        self.navigationItem.rightBarButtonItem =[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"分享"] highImage:[UIImage imageNamed:@"分享"] target:self action:@selector(clikeShare) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:tabView];
    [self createfooterFrame];
    
    //取消右侧，下侧滚动条，去处上下滚动边界的黑色背景
    wbView=[[UIWebView alloc]initWithFrame:CGRectMake(10, 0, CZScreenW-20,1 )];
    wbView.backgroundColor=[UIColor clearColor];
    //      wbView.scrollView.scrollEnabled = NO;
    //
    wbView.dataDetectorTypes = UIDataDetectorTypeLink;
    wbView.scalesPageToFit=YES;
    wbView.delegate=self;
    CGFloat offsetInner=-10;
    wbView.scrollView.scrollEnabled=NO;
    NSString *urlstr1=[NSString stringWithFormat:@"index.php?g=portal&m=article&a=index&id=%@",_ID];
    
    
    NSString *urlStr2=[NSString stringWithFormat:@"%@%@",LOCAL,urlstr1];
    NSURL *url=[NSURL URLWithString:urlStr2];
    NSLog(@"%@",urlStr2);
    
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    [wbView loadRequest:request];
//    [tabView reloadData];
    
    wbView.scrollView.contentInset=UIEdgeInsetsMake(offsetInner, offsetInner, offsetInner, offsetInner);
    wbView.userInteractionEnabled=YES;
    
    [tabView reloadData];
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
    
    tabView.showsHorizontalScrollIndicator=NO;
    tabView.showsVerticalScrollIndicator=NO;
    [tabView registerClass:[commentSViewCell class] forCellReuseIdentifier:@"acell"];

    [self initDate];
    [self createLeftButton];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
   
}
-(void)viewWillAppear:(BOOL)animated{
    //    self.tabBarController.tabBar.hidden=YES;
    //    //    self.navigationController.navigationBar.translucent=NO;
    [super viewWillAppear:YES];
      self.navigationController.navigationBar.translucent=YES;
    self.navigationController.navigationBarHidden=NO;

    
    
}
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
    [view addSubview:label];
    
    UIBarButtonItem *releaseButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:view];
    NSArray * arr = @[releaseButtonItem2];
    self.navigationItem.rightBarButtonItems = arr;
}

//刷新数据
-(void)initDate{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    NSString *postId=[NSString stringWithFormat:@"%@",_postId];
    
    [BBSTool releaseList:postId andsuccess:^(id responseObject) {
        
        NSArray *array1=responseObject;
        [listArray removeAllObjects];
        
        for (commentsModel *model in array1) {
            
            [listArray addObject:model];
            
        }
        [tabView reloadData];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}
//网络开始加载
-(void)webViewDidStartLoad:(UIWebView *)webView{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    CGRect frame = wbView.frame;
    CGSize fittingSize = [wbView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
   
    [tabView reloadData];
    CGSize newsize=CGSizeMake(CZScreenW-20, webView.frame.size.height);
    webView.scrollView.contentSize=newsize;
    
    wbView.frame=frame;
    
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    var imgScr = '';\
    for(var i=0;i<objs.length;i++){\
    imgScr = imgScr + objs[i].src + '+';\
    };\
    return imgScr;\
    };";
    
    [webView stringByEvaluatingJavaScriptFromString:jsGetImages];//注入js方法
   
    
    
    NSString *urlResurlt = [webView stringByEvaluatingJavaScriptFromString:@"getImages()"];
    mUrlArray = [NSMutableArray arrayWithArray:[urlResurlt componentsSeparatedByString:@"+"]];

    if (mUrlArray.count >= 2) {
        [mUrlArray removeLastObject];
    }
    [wbView stringByEvaluatingJavaScriptFromString:@"function registerImageClickAction(){\
     var imgs=document.getElementsByTagName('img');\
     var length=imgs.length;\
     for(var i=0;i<length;i++){\
     img=imgs[i];\
     img.onclick=function(){\
     window.location.href='image-preview:'+this.src}\
     }\
     }"];
    [wbView stringByEvaluatingJavaScriptFromString:@"registerImageClickAction();"];
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    //预览图片
    if ([request.URL.scheme isEqualToString:@"image-preview"]) {
        NSString* path = [request.URL.absoluteString substringFromIndex:[@"image-preview:" length]];
        path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSInteger index = 0;
        for (NSInteger i=0;i<mUrlArray.count;i++) {
            NSString *str=mUrlArray[i];
            
            if ([path isEqualToString:str]) {
                index=i;
            }
        }
        [self showPhotoBrowser:index];
        return NO;
    }
    return YES;
}
-(void)showPhotoBrowser:(NSInteger)index{
    WyzAlbumViewController *wyzAlbumVC = [[WyzAlbumViewController alloc]init];
    wyzAlbumVC.currentIndex =index;//这个参数表示当前图片的index，默认是0
    wyzAlbumVC.imgArr = mUrlArray;
    [self.navigationController pushViewController:wyzAlbumVC animated:YES];
}

//网页加载失败
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    [MBProgressHUD showError:NSLocalizedString(@"Load failed", @"Load failed") toView:self.view];
    
}
//返回上一成
-(void)backHome{
    if([_typeSearch isEqualToString:@"Search"]){
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        [self.navigationController popViewControllerAnimated:NO];
        
        
    }
    
}
#pragma mark - photobrowser代理方法
//创建底部视图
-(void)createfooterFrame{
    view1=[[UIView alloc]initWithFrame:CGRectMake(0, CZScreenH-40, CZScreenW,40 )];
    //    view1.backgroundColor=[UIColor redColor];
    
    view1.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    view1.layer.borderWidth=1.0;
    
    textFiled=[[UITextField alloc]initWithFrame:CGRectMake(10, 5, CZScreenW-100, 30)];
    [view1 addSubview:textFiled];
    
    textFiled.placeholder=NSLocalizedString(@"Please fill in the comments", @"Please fill in the comments");
    //设置return建的样式
    textFiled.layer.borderWidth=1;
    textFiled.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textFiled.layer.cornerRadius = 8;
    textFiled.returnKeyType=UIReturnKeySend;
    textFiled.leftView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"填写评论"]];
    textFiled.leftViewMode=UITextFieldViewModeAlways;
    tabView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    textFiled.delegate=self;
    //收藏
    UIButton * collocetionBtn =[[UIButton alloc]initWithFrame:CGRectMake(CZScreenW-80,7, 30, 26)];
   [collocetionBtn setImage:[UIImage imageNamed:@"收藏_07"] forState:UIControlStateNormal];
    
    [collocetionBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    collocetionBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [view1 addSubview:collocetionBtn];
    [collocetionBtn addTarget:self action:@selector(collocetionBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //分享
    UIButton * shareBtn=[[UIButton alloc]initWithFrame:CGRectMake(CZScreenW-40, 7, 30, 26)];
     [shareBtn setImage:[UIImage imageNamed:@"分享_07"] forState:UIControlStateNormal];
    
    [shareBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [view1 addSubview:shareBtn];
    [shareBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    
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
#pragma mark -----------收藏--------------
//收藏
-(void)clikeHobyBtn{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *phoneAccount=[ud objectForKey:@"userid"];
    if (phoneAccount==nil ) {
        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Not logged in", @"Not logged in")];
    }else{
        
        [BBSTool post_sc:self.postId success:^(id responseObject) {
            NSString *urlStr=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
            [SVProgressHUD showSuccessWithStatus:urlStr];
            
        } failure:^(NSError *error) {
            
        }];
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //    [textFiled becomeFirstResponder];
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *phoneAccount=[ud objectForKey:@"userid"];
    
    if(phoneAccount==nil ){
        [MBProgressHUD showSuccess:NSLocalizedString(@"Not logged in", @"Not logged in") toView:self.view];
        return NO;
    }else{
        
        self.view.frame=CGRectMake(0, -258, CZScreenW, CZScreenH);
        return YES;
    }
    
    
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [textFiled resignFirstResponder];
    self.view.frame=CGRectMake(0, 0, CZScreenW, CZScreenH);
    return YES;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textFiled resignFirstResponder];
    //调用发送界面
    
    [self clikeSends];
    self.view.frame=CGRectMake(0, 0, CZScreenW, CZScreenH);
    return YES;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [listArray count]+1;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        static NSString *identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            /* 忽略点击效果 */
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell.contentView addSubview:wbView];
            
        }
        return cell;
        
    }else{
        
        commentSViewCell *cell=[commentSViewCell cellWithTableView:tableView];
        [self configureCell:cell atIndexPath:indexPath];
        return cell;
        
    }
}

- (void)configureCell:(commentSViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    if(listArray.count==0){
        UILabel *lab=[[UILabel alloc]initWithFrame:cell.bounds];
        lab.textColor=[UIColor lightGrayColor];
        lab.font=[UIFont systemFontOfSize:25];
        lab.text=@"还没有任何的评论哦";
        
    }else{
        commentsModel *model=listArray[indexPath.row-1];
        NSString *dateStrimng=[ZBTime intervalSinceNow:model.createtime];
        NSLog(@"%@",model.createtime);
        
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.avatar]]];
        cell.LabName.text=[NSString stringWithFormat:@"%@",model.mobile];
        
        cell.LabTime.text=[NSString stringWithFormat:@"%@",dateStrimng];
        cell.textView.text=[NSString stringWithFormat:@"%@",model.content];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        cell.layer.borderColor=[[UIColor lightGrayColor]CGColor];
        cell.layer.borderWidth=0.5;
    }

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [textFiled resignFirstResponder];
    
}
//发送评论
-(void)clikeSends{
    
    NSString *contet=textFiled.text;
    
    if([contet isEqualToString:@""]){
        //        [MBProgressHUD showMessage:@"文字不能为空"];
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Words can't be empty", @"Words can't be empty")];
    }else{
        //        NSLog(@"%@",detailModel.post_id);
        
        [BBSTool publishedcomment:_postId content:contet success:^(id responseObject) {
            
            //            NSLog(@"阿斯顿发送到发送到发送发送到发送到发送%@",responseObject);
            NSString *status=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"status"]];
            if([status isEqualToString:@"0"]){
                NSString *message=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
                
                [SVProgressHUD showErrorWithStatus:message];
                
            }else{
                NSDate *date=[NSDate date];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                dateFormatter.dateFormat=[NSString stringWithFormat:@"yyyy-MM-dd HH:mm:ss" ];
                NSString *dateString = [ZBTime intervalSinceNow:[dateFormatter stringFromDate:date]];
//                2016-04-07 09:14:00
               
                commentsModel *model=[[commentsModel alloc]init];
                model.createtime=dateString;
                model.content=contet;
//                [listArray addObject:model];
                //            [self initDate];
                [self initDate];
                
                [tabView reloadData];
                [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Comment on success", @"Comment on success")];
            }
            
        } failure:^(NSError *error) {
            
        }];
        
    }
    [textFiled resignFirstResponder];
    
    self.view.frame=CGRectMake(0, 0, CZScreenW, CZScreenH);
    textFiled.text=@"";
}
//返回高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row==0){
        CGRect frame=wbView.frame;
        frame.size.height=wbView.scrollView.contentSize.height;
        frame.size.width=CZScreenW-20;
        
        wbView.frame=frame;
        //        if(wbView.scrollView.contentSize.height==0){
        return wbView.scrollView.contentSize.height-20;
 
    }else {
        commentsModel *model=listArray[indexPath.row-1];
        CGSize size ;
        
        size = [model.content boundingRectWithSize:CGSizeMake(CZScreenW-75, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        return 55+size.height;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//分享
-(void)clikeShare{
    [self showShareActionSheet:self.view];
    
}
//分享
- (void)showShareActionSheet:(UIView *)view
{
    /**
     * 在简单分享中，只要设置共有分享参数即可分享到任意的社交平台
     **/
    NSString *urlstr1;
    NSString *urlStr2;
//    DirectoryModel *detailModel;
    
    //    NSURL *url;
    
    __weak releaseDetailController *theController = self;
//    if(magaArray.count==0){
//        
//    }else{
//        detailModel=[magaArray objectAtIndex:page];
        urlstr1=[NSString stringWithFormat:@"index.php?g=portal&m=article&a=index&id=%@",_ID];
        urlStr2=[NSString stringWithFormat:@"%@%@",LOCAL,urlstr1];
        
        //     url=[NSURL URLWithString:urlStr2];
        
        //1、创建分享参数（必要）
        
        
//    }
    
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
                           [theController showLoadingView:YES];
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
                       [theController showLoadingView:NO];
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
- (void)showLoadingView:(BOOL)flag
{
    if (flag)
    {
        [self.view addSubview:self.panelView];
        [self.loadingView startAnimating];
    }
    else
    {
        [self.panelView removeFromSuperview];
    }
}


@end
