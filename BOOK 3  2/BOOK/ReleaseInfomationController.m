//
//  ReleaseInfomationController.m
//  BOOK
//
//  Created by liujianji on 16/3/9.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "ReleaseInfomationController.h"
#import "releasePictureViewCell.h"
#import "CZHttpTool.h"
#import "BBSTool.h"
@interface ReleaseInfomationController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,releasePictureViewDelegate>
{
    UITableView *tabView;
//    UIButton *BtnRelease;//发布按钮
    CustomTextVeiw *titleFiled;//标题栏
    CustomTextVeiw *noteView;//备注类容
    NSMutableArray *imageArray;
    NSMutableArray *returnImage;
    
    UILabel *portLab;
    UILabel *contentLab;
    UIWebView *webView;
    
}
@end

@implementation ReleaseInfomationController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.translucent=YES;
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    returnImage =[NSMutableArray array];
    
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"Shape 60"] highImage:[UIImage imageNamed:@"Shape 60"] target:self action:@selector(releasePhoto) forControlEvents:UIControlEventTouchUpInside];
    imageArray=[NSMutableArray array];

    self.navigationItem.title=NSLocalizedString(@"Publishing BBS", @"PublishingBBS");
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self createFrame];
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"返回"] highImage:[UIImage imageNamed:@"返回"] target:self action:@selector(BackHome) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)BackHome{
    [self.navigationController popViewControllerAnimated:NO];
    
}
-(void)createFrame{
    tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, CZScreenW, self.view.height-104) style:UITableViewStylePlain];
    
    [self.view addSubview:tabView];
    tabView.scrollEnabled=NO;
    tabView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    tabView.sectionHeaderHeight=10;
    tabView.sectionFooterHeight=10;
    
    tabView.delegate=self;
    tabView.dataSource=self;

    [self createHeaderView];
    [self createfooterView];
    
}
//创建头部试图
-(void)createHeaderView{
    UIView *v1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CZScreenW, 60)];
    UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(18, 20, 50, 20)];
    titleLab.text=NSLocalizedString(@"title", @"title");
    titleLab.textColor=[UIColor grayColor];
    //    v1.backgroundColor=[UIColor blueColor];
    [v1 addSubview:titleLab];
    
    CGFloat filedx=CGRectGetMaxX(titleLab.frame)+10;
    //实现协议
    
    
    titleFiled=[[CustomTextVeiw alloc]initWithFrame:CGRectMake(filedx, 12, CZScreenW-filedx-20, 30)];
    titleFiled.keyboardType=UIKeyboardTypeNamePhonePad;
    titleFiled.returnKeyType=UIReturnKeyDone;
    //titleFiled.adjustsFontSizeToFitWidth = YES;
   // titleFiled.clearButtonMode=UITextFieldViewModeUnlessEditing;
    
    UIToolbar * topKeyboardView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, CZScreenW, 30)];
    [topKeyboardView setBarStyle:UIBarStyleBlack];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedStringFromTable(@"Done",nil,nil) style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [topKeyboardView setItems:buttonsArray];
    
    [titleFiled setInputAccessoryView:topKeyboardView];
    titleFiled.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    titleFiled.delegate=self;
    titleFiled.customPlaceholder=NSLocalizedString(@"Please enter a title", @"Please enter a title");
    
    [v1 addSubview:titleFiled];
    //标题类容提示
    portLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 40, CZScreenW-20, 20)];
    portLab.textAlignment=NSTextAlignmentRight;
    portLab.textColor=[UIColor redColor];
    portLab.font=[UIFont systemFontOfSize:13];
    
    //    portLab.backgroundColor=[UIColor redColor];
    [v1 addSubview:portLab];
    tabView.tableHeaderView=v1;
    
}
-(void)dismissKeyBoard{
    [titleFiled resignFirstResponder];
    [noteView resignFirstResponder];
    
}
//创建底部视图
-(void)createfooterView{
    UIView *v1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CZScreenW, 120)];
    //    v1.backgroundColor=[UIColor purpleColor];
    noteView=[[CustomTextVeiw alloc]initWithFrame:CGRectMake(20, 0, CZScreenW-30, 100)];
    //    noteView.backgroundColor=[UIColor blueColor];
    noteView.customPlaceholder=NSLocalizedString(@"At this moment, what do you want to say", @"At this moment, what do you want to say");
    noteView.showsHorizontalScrollIndicator=NO;
    noteView.showsVerticalScrollIndicator=NO;
    
    noteView.customPlaceholderColor=[UIColor grayColor];
    noteView.delegate=self;
    UIToolbar * topKeyboardView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, CZScreenW, 30)];
    [topKeyboardView setBarStyle:UIBarStyleBlack];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedStringFromTable(@"Done",nil,nil) style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [topKeyboardView setItems:buttonsArray];
    [noteView setInputAccessoryView:topKeyboardView];
    
   // v1.layer.borderColor=[[UIColor lightGrayColor]CGColor];
   // v1.layer.borderWidth=1.0;
    [v1 addSubview:noteView];
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 120, CZScreenW, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [v1 addSubview:line];
    contentLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 100, CZScreenW-20, 20)];
    contentLab.textAlignment=NSTextAlignmentRight;
    contentLab.textColor=[UIColor redColor];
    contentLab.font=[UIFont systemFontOfSize:13];
    [v1 addSubview:contentLab];
    
    //    tabView.tableHeaderView=v1;
    tabView.tableFooterView=v1;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    releasePictureViewCell  *cell=[releasePictureViewCell CellWithTableView:tabView];
    //设置委托
    cell.delegate=self;
    
    cell.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    cell.layer.borderWidth=1.0;
    
    
    return cell;
    
}
//关闭键盘
-(void)closeKeyBord{
  [titleFiled resignFirstResponder];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [titleFiled resignFirstResponder];
    [noteView resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0];
    
    self.view.frame=CGRectMake(0, 64, CZScreenW,CZScreenH);
    [UIView commitAnimations];
    
    
}
-(void)picture:(UIImagePickerController *)pickerCon{
    //    NSLog(@"相机打开成功");
    [self presentViewController:pickerCon animated:YES completion:nil];
    
}
//获取图片
-(void)pictureString:(UIImage *)image{
    [imageArray addObject:image];
    
}
-(void)deleteImage{

    [imageArray removeLastObject];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [titleFiled resignFirstResponder];
    [noteView resignFirstResponder];
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
    
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
    
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    if(textView==noteView){
    self.view.frame=CGRectMake(0, -218+24, CZScreenW,CZScreenH);
    }
    return YES;
    
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    if(textView==noteView){
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0];
    
    self.view.frame=CGRectMake(0, 64, CZScreenW,CZScreenH);
    [UIView commitAnimations];
    }
    return YES;
    
}
//发布图片
-(void)releasePhoto{
    
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=send&a=uploadFile"];
    
    NSString *title=titleFiled.text;
    NSString *content=noteView.text;
    if([title isEqualToString:@""]){
        portLab.text=NSLocalizedString(@"Please enter a title", @"Please enter a title");
        
    }else if([content isEqualToString:@""]){
        contentLab.text=NSLocalizedString(@"Please enter the class, let", @"Please enter the class, let");
        
    }else if (title.length>20){
        portLab.text=NSLocalizedString(@"Title should not exceed 20 words", @"Title should not exceed 20 words");
        
    }else{
        if(imageArray.count==0){
            [self releaseBBs];
            
        }else{
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            for (UIImage *img  in imageArray) {
                [ CZHttpTool postImage:urlStr parameters:nil imageFile:img fileKey:@"url" success:^(NSDictionary  *responseObject) {
                    
                    [returnImage addObject:[responseObject objectForKey:@"url"]];
                    if(returnImage.count==imageArray.count){
                        //判断什么时候调用
                        [self releaseBBs];
                    }
                } failure:^(NSError *error) {
                }];
            }
        }
    }
}
//发布论坛
-(void)releaseBBs{
    NSString *jsonStr=@"";
    if(returnImage.count==0){
        
    }else{
        for (int i=0;i<returnImage.count;i++) {
            if(i==returnImage.count-1){
                jsonStr=[jsonStr stringByAppendingString:[NSString stringWithFormat:@"%@",returnImage[i]]];
                
            }else{
                jsonStr=[jsonStr stringByAppendingString:[NSString stringWithFormat:@"%@,",returnImage[i]]];
            }
        }
    }
    NSString *title=titleFiled.text;
    NSString *content=noteView.text;
    
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *phoneAccount=[ud objectForKey:@"userid"];
    NSInteger lang=0;
    if([language isEqualToString:@"en"]){
        
        lang=1;
    }
    dic[@"language"]=@(lang);
    dic[@"user_id"]=phoneAccount;
    dic[@"json"]=jsonStr;
    dic[@"post_title"]=title;
    dic[@"post_content"]=content;
    [BBSTool releaseBBS:dic andsuccess:^(id responseObject) {
//        NSLog(@"阿双方哈康师傅哈康师傅哈康师傅哈司法考试分%@",responseObject);
        [MBProgressHUD hideHUDForView:self.view];
        NSString *str=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"status" ]];
        
        if([str isEqualToString:@"0"]){
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Post failure", @"Post failure")];
            
           
            
        }else{
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Release success", @"Release success")];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
    
}
//发布论坛
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
