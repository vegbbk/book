//
//  webViewCell.m
//  BOOK
//
//  Created by wangyang on 16/3/29.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "webViewCell.h"
#import "WyzAlbumViewController.h"
@interface webViewCell()<UIWebViewDelegate>{
    NSMutableArray *mUrlArray;
    
}
@end
@implementation webViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if(self ==[super initWithFrame:frame]){
       [self createFrame];
//        NSString *urlStr2=[NSString stringWithFormat:@"%@%@",LOCAL,urlstr1];

    }
    return self;
    
}

-(void)createFrame{
    _wbView=[[UIWebView alloc]initWithFrame:self.bounds];
    [self addSubview:_wbView];
    _wbView.backgroundColor=[UIColor redColor];
    
    _wbView.delegate=self;
    //设置没有黑色的背景
    _wbView.dataDetectorTypes = UIDataDetectorTypeLink;
    //取消右侧，下侧滚动条，去处上下滚动边界的黑色背景
    _wbView.backgroundColor=[UIColor clearColor];
    for (UIView *_aView in [_wbView subviews])
    {
        if ([_wbView isKindOfClass:[UIScrollView class]])
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

}
-(void)setUrlStr:(NSString *)urlStr{
    _urlStr=urlStr;
    NSURL *url=[NSURL URLWithString:_urlStr];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    [_wbView loadRequest:request];
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{

    [MBProgressHUD hideAllHUDsForView:self animated:YES];
    
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    var imgScr = '';\
    for(var i=0;i<objs.length;i++){\
    imgScr = imgScr + objs[i].src + '+';\
    };\
    return imgScr;\
    };";
    [MBProgressHUD hideAllHUDsForView:self animated:YES];
    [webView stringByEvaluatingJavaScriptFromString:jsGetImages];//注入js方法
    NSString *urlResurlt = [webView stringByEvaluatingJavaScriptFromString:@"getImages()"];
    mUrlArray = [NSMutableArray arrayWithArray:[urlResurlt componentsSeparatedByString:@"+"]];
    if (mUrlArray.count >= 2) {
        [mUrlArray removeLastObject];
    }
    [_wbView stringByEvaluatingJavaScriptFromString:@"function registerImageClickAction(){\
     var imgs=document.getElementsByTagName('img');\
     var length=imgs.length;\
     for(var i=0;i<length;i++){\
     img=imgs[i];\
     img.onclick=function(){\
     window.location.href='image-preview:'+this.src}\
     }\
     }"];
    [_wbView stringByEvaluatingJavaScriptFromString:@"registerImageClickAction();"];
    
    
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
//        [self showPhotoBrowser:index];
        [self.Delegate getWithPhoto:mUrlArray andindex:index];
        
        return NO;
    }
    return YES;
}
-(void)showPhotoBrowser:(NSInteger)index{
    WyzAlbumViewController *wyzAlbumVC = [[WyzAlbumViewController alloc]init];
    
    wyzAlbumVC.currentIndex =index;//这个参数表示当前图片的index，默认是0
    wyzAlbumVC.imgArr = mUrlArray;
    //    [self presentViewController:wyzAlbumVC animated:YES completion:^{
    //
    //    }];
//    [self.navigationController pushViewController:wyzAlbumVC animated:YES];
    
}
+(instancetype)cellCollectionWith:(UICollectionView *)collectionView :(NSIndexPath *)indexPath{
    static NSString *ID=@"webCell";
    id cell=[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath ];
    
    if(cell==nil){
        cell=[collectionView dequeueReusableCellWithReuseIdentifier :ID forIndexPath :indexPath];
        
    }
//   cell=[[self alloc]init];
    
    return cell;
    
}
//-(void)layoutSubviews{
//    [super layoutSubviews];
//    _wbView.frame=self.bounds;
//    
//}
@end
