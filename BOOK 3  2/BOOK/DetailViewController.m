//
//  DetailViewController.m
//  BOOK
//
//  Created by wangyang on 16/5/19.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "DetailViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import "SDCycleScrollView.h"
#import "WyzAlbumViewController.h"

#import <ShareSDKExtension/SSEShareHelper.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>
#import "BBSTool.h"
#import <ShareSDKExtension/ShareSDK+Extension.h>
#import "DirectoryModel.h"
#import "commentSController.h"
#import "magazineModel.h"
#import "magazineTool.h"
#import "webViewCell.h"
#import "CustomTextVeiw.h"
@interface DetailViewController ()<UITextFieldDelegate,UIWebViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,webViewCellDelegate,UITextViewDelegate>{

    UIView *view1;
    UITextField *textFiled;
    UIButton *commentsBtn;
    UIButton *hobyBtn;
    NSMutableArray *mUrlArray;
    UILabel * commentsLab;
    NSMutableArray *magaArray;
    NSInteger page;
    UIWebView *wbView;
    UICollectionView *collecView;//集合视图
    NSString *pageIndex;
    
}

@end

@implementation DetailViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    pageIndex=@"";
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent=NO;
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"返回"] highImage:[UIImage imageNamed:@"返回"] target:self action:@selector(BackHome) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.title=NSLocalizedString(@"Magazine details", @"Magazine details");
    self.title=@"杂志详情";
     page=0;
    self.view.backgroundColor=[UIColor whiteColor];
    magaArray=[NSMutableArray array];
    
    UIBarButtonItem *item1=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"目录"] highImage:[UIImage imageNamed:@"目录"] target:self action:@selector(clikedirectorys) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item2=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"分享"] highImage:[UIImage imageNamed:@"分享"] target:self action:@selector(clikeShare) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:item2,item1, nil];
    //创建评论视图
   [self loadViewUI];

    [self.view addSubview:view1 ];
    //创建WebView;
    //
    
    [self CreateCollViewFrame];
    
  // [self createWebView];
   //加载网页数据
   [self initData];
    
}
//创建collView
-(void)CreateCollViewFrame{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //    设置cell尺寸
    layout.itemSize=CGSizeMake(CZScreenW, CZScreenH-104);
    //清空行距
    
    layout.minimumLineSpacing=0;
    //设置滚动方向
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    collecView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, CZScreenW, CZScreenH-104) collectionViewLayout:layout];
    collecView.dataSource=self;
    collecView.pagingEnabled=YES;
    
    collecView.delegate=self;
      collecView.backgroundColor=[UIColor whiteColor];
    [collecView registerClass:[webViewCell class] forCellWithReuseIdentifier:@"webCell"];
    
    [self.view addSubview:collecView];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
     return  [magaArray count];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

}
//加载数据
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    webViewCell *cell=[webViewCell cellCollectionWith:collecView :indexPath];
   
//    if () {
//        pageIndex=page;
//    }else{
//        pageIndex=indexPath.row;
//        
//    }
    DirectoryModel *detailModel;
    
    
    if ([pageIndex isEqualToString:@""]) {
       detailModel=[magaArray objectAtIndex:page];
        pageIndex=[NSString stringWithFormat:@"%li",page];
    }else {
       detailModel=[magaArray objectAtIndex:indexPath.row];

    }
    NSString *urlstr1=[NSString stringWithFormat:@"index.php?g=portal&m=article&a=index&id=%@",detailModel.ID];
    cell.Delegate=self;
    
    NSString *urlStr2=[NSString stringWithFormat:@"%@%@",LOCAL,urlstr1];
    cell.urlStr=urlStr2;
    
    return cell;
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView==collecView) {
        CGPoint point=scrollView.contentOffset;
        _page=point.x/CZScreenW;
       [self initWebViewDate];
        [collecView reloadData];
        
        [SVProgressHUD dismiss];
        
    }
}
//-(void)SwipeGestures:(UISwipeGestureRecognizer *)swipe{
//    //    UISwipeGestureRecognizer *swipe = swipe;
//    if (swipe.direction == UISwipeGestureRecognizerDirectionRight)
//    {
//        if(page>0){
//            page--;
//            [self initWebViewDate];
//        }else{
//            [SVProgressHUD dismiss];
//            
//            [self.navigationController popViewControllerAnimated:YES];
//            
//        }
//    }else if (swipe.direction==UISwipeGestureRecognizerDirectionLeft){
//        if(page<magaArray.count-1){
//            page++;
//            [self initWebViewDate];
//        }
//    }
//}
-(void)getWithPhoto:(NSMutableArray *)array andindex:(NSInteger)index{
    mUrlArray=array;
    [self showPhotoBrowser:index];
    
}
-(void)showPhotoBrowser:(NSInteger)index{
    WyzAlbumViewController *wyzAlbumVC = [[WyzAlbumViewController alloc]init];
    
    wyzAlbumVC.currentIndex =index;//这个参数表示当前图片的index，默认是0
    wyzAlbumVC.imgArr = mUrlArray;
 
        [self.navigationController pushViewController:wyzAlbumVC animated:YES];
    
}
//加载数据
-(void)initData{
    if (_termAll_id.length==0) {

        magaArray=_magaArray;
        page=_page;
         collecView.contentOffset=CGPointMake(_page*CZScreenW, 0);
        [self initWebViewDate];
        
    }else{
        magaArray=[NSMutableArray array];
        
      [magazineTool getAllcontent:_termAll_id andsuccess:^(id responseObject) {
          NSArray *array1=responseObject;
          [magaArray addObjectsFromArray:array1];
        
         
          [collecView reloadData];
          
          [self initWebViewDate];
      } failure:^(NSError *error) {
          
      }];
        
    }
   
}
//加载网页数据
-(void)initWebViewDate{
    if (magaArray.count==0) {
              [SVProgressHUD showSuccessWithStatus:@"此文章还未跟新"];
    }else{
        DirectoryModel *detailModel=[magaArray objectAtIndex:page];
        commentsLab.text=[NSString stringWithFormat:@"%@",detailModel.comment];
        commentsLab.textColor=[UIColor grayColor];
    }
    
}
//返回目录
-(void)clikedirectorys{
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:NO];
}

//返回
-(void)BackHome{
    [self.navigationController popViewControllerAnimated:NO];
    
}
-(void)createWebView{
    wbView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, CZScreenW,self.view.height-104 )];
    [self.view addSubview:wbView];
    wbView.backgroundColor=[UIColor greenColor];
    
    wbView.delegate=self;
    //设置没有黑色的背景
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

//    UISwipeGestureRecognizer   *panright=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SwipeGestures:)];
//    panright.direction=UISwipeGestureRecognizerDirectionRight;
//    UISwipeGestureRecognizer *panLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SwipeGestures:)];
//    panLeft.direction=UISwipeGestureRecognizerDirectionLeft;
//    [wbView addGestureRecognizer:panLeft];
//    
//    [wbView addGestureRecognizer:panright];
}

//加载数据
-(void)loadViewUI{
    view1=[[UIView alloc]initWithFrame:CGRectMake(0, CZScreenH-104, CZScreenW, 40)];
    [self.view addSubview:view1 ];
    view1.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    view1.layer.borderWidth=1.0;
    textFiled=[[UITextField alloc]initWithFrame:CGRectMake(10, 5, CZScreenW-120, 30)];
 
    UIToolbar * topKeyboardView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, CZScreenW, 30)];
    [topKeyboardView setBarStyle:UIBarStyleBlack];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedStringFromTable(@"Done",nil,nil) style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoards)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [topKeyboardView setItems:buttonsArray];
    [textFiled setInputAccessoryView:topKeyboardView];
    [view1 addSubview:textFiled];
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(CZScreenW-120, 5, 1, 30)];
    view2.backgroundColor=[UIColor grayColor];
    [view1 addSubview:view2];
    
    //爱好
    
    hobyBtn=[[UIButton alloc]initWithFrame:CGRectMake(CZScreenW-100, 10, 15, 15)];
    [hobyBtn setBackgroundImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
    //用户收藏
    [hobyBtn addTarget:self action:@selector(clikeHobyBtn) forControlEvents:UIControlEventTouchUpInside];
    
    //    hobyBtn.backgroundColor=[UIColor redColor];
    [view1 addSubview:hobyBtn];
    //评论
    
    commentsBtn=[[UIButton alloc]initWithFrame:CGRectMake(CZScreenW-70, 10, 30, 15)];
//    [commentsBtn setBackgroundImage:[UIImage imageNamed:@"查看"] forState:UIControlStateNormal];
    [commentsBtn setImage:[UIImage imageNamed:@"查看"] forState:UIControlStateNormal];
    
    [commentsBtn addTarget:self action:@selector(clikeComment) forControlEvents:UIControlEventTouchUpInside];
    CGFloat labx=CGRectGetMaxX(commentsBtn.frame)+5;
    //评论的数量
    commentsLab=[[UILabel alloc]initWithFrame:CGRectMake(labx, 10, 30, 15)];
    commentsLab.textColor=[UIColor greenColor];
    //    commentsLab.backgroundColor=[UIColor redColor];
    
    [view1 addSubview:commentsLab];
    
    [view1 addSubview:commentsBtn];
    [textFiled resignFirstResponder];
    
    textFiled.placeholder=NSLocalizedString(@"Fill in the comments", @"Fill in the comments");
    //设置return建的样式
    textFiled.returnKeyType=UIReturnKeySend;
    textFiled.leftView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"填写评论"]];
    textFiled.leftViewMode=UITextFieldViewModeAlways;
    
    textFiled.delegate=self;

}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
        NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
        NSString *phoneAccount=[ud objectForKey:@"userid"];
        
        if(phoneAccount==nil){
            //        [MBProgressHUD showMessage:@"没有登录" toView:self.view];
            [MBProgressHUD showSuccess:NSLocalizedString(@"Not logged in", @"Not logged in") toView:self.view];
            return NO;
        }else{
            
            self.view.frame=CGRectMake(0, -218, CZScreenW, CZScreenH);
            return YES;
        }
}
//关闭键盘
-(void)dismissKeyBoards{
    [textFiled resignFirstResponder];
    self.view.frame=CGRectMake(0, 64, CZScreenW, CZScreenH);
}
-(void)clikeShare{
    [self showShareActionSheet:self.view];
    
}
//查看评论
-(void)clikeComment{
    
    [textFiled resignFirstResponder];
    
    commentSController *comment=[[commentSController alloc]init];
    
    DirectoryModel *model=[magaArray objectAtIndex:page];
    
    comment.commentId=model.post_id;
     [SVProgressHUD dismiss];
    [self.navigationController pushViewController:comment animated:YES];
}
//收藏
-(void)clikeHobyBtn{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *phoneAccount=[ud objectForKey:@"userid"];
    
    if (phoneAccount==nil ) {
        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Not logged in", @"Not logged in")];
    }else{
        if(magaArray.count==0){
            return ;
        }else{
            magazineModel *model=[magaArray objectAtIndex:page];
            [BBSTool post_sc:model.post_id success:^(id responseObject) {
                NSString *urlStr=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]];
                [SVProgressHUD showSuccessWithStatus:urlStr];
                
            } failure:^(NSError *error) {
                
            }];
            
        }
        
        
    }
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [textFiled resignFirstResponder];
    self.view.frame=CGRectMake(0, 64, CZScreenW, CZScreenH);
    
    return YES;

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textFiled resignFirstResponder];
    //调用发送方法
    [self clikeSend];
    self.view.frame=CGRectMake(0, 64, CZScreenW, CZScreenH);
    return YES;

    }

//发表评论
-(void)clikeSend{
    self.view.frame=CGRectMake(0, 64, CZScreenW, CZScreenH);
    NSString *contet=textFiled.text;
    if([contet isEqualToString:@""]){
        //        [MBProgressHUD showMessage:@"文字不能为空"];
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Words can't be empty", @"Words can't be empty")];
    }else{
        if(magaArray.count==0){
            
            return;
            
        }else{
            DirectoryModel *model=[magaArray objectAtIndex:page];
            [BBSTool publishedcomment:model.post_id content:contet success:^(id responseObject) {
                NSString *status=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"status"]];
                if([status isEqualToString:@"0"]){
                    [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Comment on failure", @"Comment on failure")];
                }else{
                    [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Comment on success", @"Comment on success")];
                    
                }
                
            } failure:^(NSError *error) {
                
            }];
        }
    }
    textFiled.text=@"";
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
//  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [MBp show]
//    [SVProgressHUD showSuccessWithStatus:@"" duration:1.0];
    [SVProgressHUD showWithStatus:@""];

//    MBProgressHUD
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss ];
    
    static  NSString * const jsGetImages =
   @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    var imgScr = '';\
    for(var i=0;i<objs.length;i++){\
    imgScr = imgScr + objs[i].src + '+';\
    };\
    return imgScr;\
    };";
     [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
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

//分享
- (void)showShareActionSheet:(UIView *)view
{
    /**
     * 在简单分享中，只要设置共有分享参数即可分享到任意的社交平台
     **/
    NSString *urlstr1;
   NSString *urlStr2;
    DirectoryModel *detailModel;
    
//       NSURL *url;
    
    __weak DetailViewController *theController = self;
        if(magaArray.count==0){
    
        }else{
            detailModel=[magaArray objectAtIndex:page];
     urlstr1=[NSString stringWithFormat:@"index.php?g=portal&m=article&a=index&id=%@",detailModel.ID];
     urlStr2=[NSString stringWithFormat:@"%@%@",LOCAL,urlstr1];
    
//         url=[NSURL URLWithString:urlStr2];
    
    //1、创建分享参数（必要）
    
    
       }
    
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
