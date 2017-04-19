//
//  LoginViewController.m
//  BOOK
//
//  Created by liujianji on 16/3/7.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "LoginViewController.h"
#import "registeredViewController.h"
#import "RetrieveViewController.h"
#import "AccountTool.h"

@interface LoginViewController ()<UITextFieldDelegate>{
    UITextField *accountView;//账号
     UITextField  *PWDView;//密码
    UIButton *loginBtn;
    UIButton *registBtn;
    UIButton *forgetBtn;
    UILabel *promptLabt;//提示Lab
    NSUserDefaults *ud;
    UILabel * label11;
    UILabel * label12;
    
}

@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated{
//    [self viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent=NO;
    
}
-(void)viewDidAppear:(BOOL)animated{
   
}
-(void)viewDidDisappear:(BOOL)animated{

//    [super viewDidDisappear:animated];
//    self.navigationController.navigationBarHidden =YES;
       AppDelegate  *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
        [tempAppDelegate.LeftSlideVC openLeftView];
    
}
- (void)viewDidLoad {
   
    [super viewDidLoad];
    ud =[NSUserDefaults standardUserDefaults];
    
   self.view.backgroundColor=backColorLJJ;
    self.navigationItem.title=NSLocalizedString(@"login", @"login");
    
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"返回"] highImage:[UIImage imageNamed:@"返回"] target:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
    accountView.text=@"";
    promptLabt.text=@"";
    PWDView.text=@"";
    
      [self createTextFiledFrame];
    [self createBtnFrame];
    
    
}
//创建文本框视图
-(void)createTextFiledFrame{
    UIView *v1=[[UIView alloc]initWithFrame:CGRectMake(0, 50, CZScreenW, 100)];
    v1.backgroundColor=WhiteColor;
    [self.view addSubview:v1];
    promptLabt=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 200, 20)];
    promptLabt.textColor=[UIColor redColor];
    promptLabt.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:promptLabt];

    v1.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    v1.layer.borderWidth=1.0;
    
    UILabel *accountLab=[[UILabel alloc]initWithFrame:CGRectMake(20, 15, 60, 20)];
    
    accountLab.text=NSLocalizedString(@"Mobile phone no", @"Mobilephone");
    accountLab.textColor=[UIColor grayColor];
    accountLab.font=[UIFont systemFontOfSize:14];
     [v1 addSubview:accountLab];
    CGFloat x=CGRectGetMaxX(accountLab.frame)+10;
    label11 = [[UILabel alloc]initWithFrame:CGRectMake(x+26, 15, CZScreenW-x, 25)];
    label11.textColor = [UIColor grayColor];
    label11.userInteractionEnabled = YES;
    [v1 addSubview:label11];

    accountView=[[UITextField alloc]initWithFrame:CGRectMake(x, 15, CZScreenW-x, 25)];
    accountView.keyboardType=UIKeyboardTypeNumberPad;
    accountView.backgroundColor = [UIColor clearColor];
    accountView.delegate = self;
    accountView.textColor=[UIColor clearColor];
    accountView.placeholder=NSLocalizedString(@"Mobile phone no", @"Mobilephone");
    [v1 addSubview:accountView];
    [accountView addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIView *v2=[[UIView alloc]initWithFrame:CGRectMake(20, 50, CZScreenW, 1)];
    v2.backgroundColor=[UIColor lightGrayColor];
    [v1 addSubview:v2];
    
    UILabel *pwdLab=[[UILabel alloc]initWithFrame:CGRectMake(20,65 , 70, 20)];
    pwdLab.text=NSLocalizedString(@"password", @"password");
   
    pwdLab.textColor=[UIColor grayColor];
    pwdLab.font=[UIFont systemFontOfSize:14];
    [v1 addSubview:pwdLab];
    label12 = [[UILabel alloc]initWithFrame:CGRectMake(x+26, 65, CZScreenW-x, 20)];
    label12.textColor = [UIColor grayColor];
    label12.font = [UIFont systemFontOfSize:12];
    label12.userInteractionEnabled = YES;
    [v1 addSubview:label12];

    PWDView=[[UITextField alloc]initWithFrame:CGRectMake(x, 65, CZScreenW-x, 20)];
    PWDView.placeholder=NSLocalizedString(@"password", @"password");
    PWDView.textColor=[UIColor clearColor];
   // PWDView.font = [UIFont systemFontOfSize:12];
    PWDView.backgroundColor = [UIColor clearColor];
    //PWDView.text = @"●●●●●●";
   // PWDView.tintColor=[UIColor clearColor];
    PWDView.secureTextEntry = YES;
    [v1 addSubview:PWDView];
    [PWDView addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

-(void)textFieldDidChange :(UITextField *)theTextField{
   
    if (theTextField==accountView) {
        
        label11.text = theTextField.text;
        
    }else if(theTextField == PWDView){
    
        NSString * string = @"";
        NSInteger num = PWDView.text.length;
        for(NSInteger i = 0;i<num;i++){
        
            string = [NSString stringWithFormat:@"%@●",string];
            
        }
        
        label12.text = string;
    
    }
    
    
}

//创建按钮
-(void)createBtnFrame{
    //登录按钮
    loginBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, CZScreenH*0.3, CZScreenW-40, 44)];
    loginBtn.backgroundColor=[UIColor redColor];
    [loginBtn setTitle:NSLocalizedString(@"login", @"login") forState:UIControlStateNormal];
    [loginBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    loginBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    loginBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:loginBtn];
   //添加事件
    [loginBtn addTarget:self action:@selector(clikeLogin) forControlEvents:UIControlEventTouchUpInside];
    
    //注册按钮
    registBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, CZScreenH*0.4, CZScreenW-40, 44)];
    registBtn.backgroundColor=[UIColor lightGrayColor];
    [registBtn setTitle:NSLocalizedString(@"registered", @"Registered") forState:UIControlStateNormal];
    [registBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    registBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    registBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:registBtn];
    //添加事件
    [registBtn addTarget:self action:@selector(clikeRegister) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat h=CGRectGetMaxY(registBtn.frame)+15;
    //忘记密码
    forgetBtn=[[UIButton alloc]initWithFrame:CGRectMake((CZScreenW-200)/2.0, h, 200,15 )];
    [forgetBtn setTitle:NSLocalizedString(@"Forgot password", @"Forgot password") forState:UIControlStateNormal];
    
    [forgetBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    forgetBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    forgetBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [forgetBtn addTarget:self action:@selector(clikeRetieve) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];

}
//登录
-(void)clikeLogin{
    NSString *account=accountView.text;
    NSString *pwd=PWDView.text;
    if([account isEqualToString:@""]){
      promptLabt.text=NSLocalizedString(@"Please enter the account", @"Please enter the account");
        
    }else if ([pwd isEqualToString:@""]){
      promptLabt.text=NSLocalizedString(@"Please enter the password", @"Please enter the password");

    }else{
      [AccountTool LoginUser:account PassWord:pwd success:^(AccountModel *model) {
          NSLog(@"啊煞风景啊三闾大夫就阿里斯顿放假啊老师放假啊路上风景阿隆索发动机阿里感觉了%@",model.avatar);
          
          [MBProgressHUD showHUDAddedTo:self.view animated:YES];
          
          if([model.status isEqualToString:@"0"]){
            promptLabt.text=[NSString stringWithFormat:@"%@",model.message];
          }else{
              [MBProgressHUD showSuccess:NSLocalizedString(@"Login successful", @"Login successful") toView:self.view];
               [ud setObject:pwd forKey:@"pwd"];
               NSLog(@"%@",[ud objectForKey:@"pwd"]);
               [ud setObject:model.user_id forKey:@"userid"];
               [ud setObject:model.phone forKey:@"userphone"];
               [ud setObject:model.avatar forKey:@"userphoto"];
               [ud setObject:@(YES) forKey:@"flag"];
               [[NSNotificationCenter defaultCenter]postNotificationName:@"login" object:nil];
              
               [self.navigationController popViewControllerAnimated:YES];
              
          }
          [MBProgressHUD hideHUDForView:self.view];
          
      } failure:^(NSError *error) {
          
      }];
        
    }
}
//注册账号
-(void)clikeRegister{
    registeredViewController *registered=[[registeredViewController alloc]init];
    [self.navigationController pushViewController:registered animated:YES];
    
}
//找回密码
-(void)clikeRetieve{
    RetrieveViewController *retrieve=[[RetrieveViewController alloc]init];
    [self.navigationController pushViewController:retrieve animated:NO];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [accountView resignFirstResponder];
    [PWDView resignFirstResponder];
    
}
//返回
-(void)backHome{

    [self.navigationController popViewControllerAnimated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
