//
//  ServicebackController.m
//  BOOK
//
//  Created by liujianji on 16/3/9.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "ServicebackController.h"
#import "CustomTextVeiw.h"
#import "AccountTool.h"
@interface ServicebackController (){
    CustomTextVeiw *textView;
    CustomTextVeiw *textFiled;
    UIButton *submitBtn;//提交按钮
}

@end

@implementation ServicebackController
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=NSLocalizedString(@"Service feedback", @"Service feedback");
     self.navigationItem.rightBarButtonItem= [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"Shape 60"] highImage:[UIImage imageNamed:@"Shape 60"] target:self action:@selector(clikeSubmitbtn) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor=[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"返回"] highImage:[UIImage imageNamed:@"返回"] target:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
    [self createFrame];
    
}
-(void)backHome{
//    NSLog(@"阿双方来说大幅拉升大幅拉升阶段法律师傅");
    
    AppDelegate  *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    
   [tempAppDelegate.LeftSlideVC openLeftView];
   
   [self.navigationController popToRootViewControllerAnimated:YES];

//    [self.navigationController popViewControllerAnimated:NO];
    
}
-(void)createFrame{
    textView=[[CustomTextVeiw alloc]initWithFrame:CGRectMake(0, 0, CZScreenW, CZScreenH*0.3)];
    [self.view addSubview:textView];
//    textView.text=@"请填写我们的反馈意见,你的意见对我们的帮组很大";
    textView.backgroundColor=[UIColor whiteColor];
    UIToolbar * topKeyboardView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, CZScreenW, 30)];
    [topKeyboardView setBarStyle:UIBarStyleBlack];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedStringFromTable(@"Done",nil,nil) style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [topKeyboardView setItems:buttonsArray];
    
    [textView setInputAccessoryView:topKeyboardView];
    textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textView.customPlaceholder=NSLocalizedString(@"Please fill out our feedback, your opinion is a big help for us", @"Please fill out our feedback, your opinion is a big help for us");
    textView.customPlaceholderColor=[UIColor grayColor];
    

    textFiled=[[CustomTextVeiw alloc]initWithFrame:CGRectMake(0, CZScreenH*0.3+15, CZScreenW, 50)];
   // textFiled.clearButtonMode =UITextFieldViewModeUnlessEditing ;
    [self.view addSubview:textFiled];
     textFiled.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textFiled.backgroundColor=[UIColor whiteColor];
    [textFiled setInputAccessoryView:topKeyboardView];
    textFiled.customPlaceholder=NSLocalizedString(@"Please leave your E-mail, so as to enable us to reply you", @"Please leave your E-mail, so as to enable us to reply you");

    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [textFiled resignFirstResponder];
    [textView resignFirstResponder];
    
}
//服务反馈
-(void)clikeSubmitbtn{
    NSString *emailStr=textFiled.text;
    NSString *contextText=textView.text;
   BOOL flag= [self isValidateEmail:emailStr];
    if([contextText isEqualToString:@""]){
        [SVProgressHUD showSuccessWithStatus:@"内容不能为空"];
    }else if(!flag==YES){
        [SVProgressHUD showSuccessWithStatus:@"邮箱格式错误"];
        
    }else{
    [AccountTool AddMssage:contextText eamil:emailStr success:^(id responseObject) {
        NSString *status=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"status"]];
        if([status isEqualToString:@"1"]){
          
            [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"message"]];
            AppDelegate  *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            
            [tempAppDelegate.LeftSlideVC openLeftView];
           
           [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }
    } failure:^(NSError *error) {
        
    }];
        
    }
    
}
//邮箱验证
-(void)dismissKeyBoard{
    [textFiled resignFirstResponder];
    [textView resignFirstResponder];
    
}
-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
