//
//  registeredViewController.m
//  BOOK
//
//  Created by liujianji on 16/3/8.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "registeredViewController.h"
#import "AccountTool.h"
#import "CZHttpTool.h"
@interface registeredViewController (){
    UITextField *accountView;
    UITextField *PWDView;
    UITextField *validationView;
    UIButton *registerBtn;//注册按钮
    UIButton *sendBtn;//发送验证消息
    UILabel *promptLabt;//提示Lab
    NSTimer *timer;
    NSInteger num;
    UILabel * label11;
    UILabel * label12;
    UILabel * label13;
}

@end

@implementation registeredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=NSLocalizedString(@"registered", @"registered");
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"返回"] highImage:[UIImage imageNamed:@"返回"] target:self action:@selector(BackHome) forControlEvents:UIControlEventTouchUpInside];
    //打开页面的时候清空内容
    promptLabt.text=@"";
    accountView.text=@"";
    PWDView.text=@"";
    accountView.text=@"";
    
    
    [self createFrame];
    
}
-(void)BackHome{
//    AppDelegate  *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    
//    [tempAppDelegate.LeftSlideVC openLeftView];
//    [self.navigationController popViewControllerAnimated:NO];

   [self.navigationController popViewControllerAnimated:NO];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    AppDelegate  *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [tempAppDelegate.LeftSlideVC closeLeftView];

}
//加载控件
-(void)createFrame{
    //创建外部视图
    num=60;
    
    UIView *v1=[[UIView alloc]initWithFrame:CGRectMake(0, 40, CZScreenW, 150)];
    //添加提示文本
    promptLabt=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 200, 20)];
    promptLabt.textColor=[UIColor redColor];
    promptLabt.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:promptLabt];
    
    v1.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    v1.layer.borderWidth=1.0;
    [self.view addSubview:v1];
    UILabel *accountLab=[[UILabel alloc]initWithFrame:CGRectMake(20, 15, 60, 20)];
    
    accountLab.text=NSLocalizedString(@"Mobile phone no", @"Mobilephone");
    accountLab.textColor=[UIColor grayColor];
    accountLab.font=[UIFont systemFontOfSize:14];
    [v1 addSubview:accountLab];
    CGFloat x=CGRectGetMaxX(accountLab.frame)+10;
    label11 = [[UILabel alloc]initWithFrame:CGRectMake(x+26, 15, CZScreenW-x-100, 25)];
    label11.textColor = [UIColor grayColor];
    label11.userInteractionEnabled = YES;
    [v1 addSubview:label11];
    accountView=[[UITextField alloc]initWithFrame:CGRectMake(x, 15, CZScreenW-x-100, 25)];
    accountView.keyboardType=UIKeyboardTypeNumberPad;
    accountView.backgroundColor = [UIColor clearColor];
    accountView.textColor=[UIColor clearColor];
    accountView.placeholder=NSLocalizedString(@"Mobile phone no", @"Mobilephone");
    [v1 addSubview:accountView];
    [accountView addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    UIView *v2=[[UIView alloc]initWithFrame:CGRectMake(20, 50, CZScreenW, 1)];
    v2.backgroundColor=[UIColor lightGrayColor];
    [v1 addSubview:v2];
    UILabel *validationLab=[[UILabel alloc]initWithFrame:CGRectMake(20,65 , 70, 20)];
    validationLab.text=NSLocalizedString(@"password", @"password");;
    
    validationLab.textColor=[UIColor grayColor];
    validationLab.font=[UIFont systemFontOfSize:14];
    [v1 addSubview:validationLab];
    
    label12 = [[UILabel alloc]initWithFrame:CGRectMake(x+26, 65, CZScreenW-x, 20)];
    label12.textColor = [UIColor grayColor];
    label12.font = [UIFont systemFontOfSize:12];
    label12.userInteractionEnabled = YES;
    [v1 addSubview:label12];
    
    validationView=[[UITextField alloc]initWithFrame:CGRectMake(x, 65, CZScreenW-x, 20)];
//    validationView.keyboardType=UIKeyboardTypeNumberPad;
    validationView.textColor=[UIColor clearColor];
    validationView.backgroundColor = [UIColor clearColor];
    validationView.secureTextEntry=YES;
    
    validationView.placeholder=NSLocalizedString(@"password", @"password");;
    [v1 addSubview:validationView];
    [validationView addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    //创建密码的输入框
    UIView *v3=[[UIView alloc]initWithFrame:CGRectMake(20, 100, CZScreenW, 1)];
    v3.backgroundColor=[UIColor lightGrayColor];
    [v1 addSubview:v3];
    UILabel *pwdLab=[[UILabel alloc]initWithFrame:CGRectMake(20,115 , 70, 20)];
    pwdLab.text=NSLocalizedString(@"Confirmpassword", @"Confirmpassword");
    
    pwdLab.textColor=[UIColor grayColor];
    pwdLab.font=[UIFont systemFontOfSize:14];
    [v1 addSubview:pwdLab];
    label13 = [[UILabel alloc]initWithFrame:CGRectMake(x+26, 115, CZScreenW-x, 20)];
    label13.textColor = [UIColor grayColor];
    label13.font = [UIFont systemFontOfSize:12];
    label13.userInteractionEnabled = YES;
    [v1 addSubview:label13];

    PWDView=[[UITextField alloc]initWithFrame:CGRectMake(x, 115, CZScreenW-x, 20)];
    PWDView.placeholder=NSLocalizedString(@"Confirmpassword", @"Confirmpassword");
    [v1 addSubview:PWDView];
    PWDView.backgroundColor = [UIColor clearColor];
    PWDView.textColor=[UIColor clearColor];
    
    PWDView.secureTextEntry = YES;
    [PWDView addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    //注册按钮
    registerBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, CZScreenH*0.4, CZScreenW-40, 44)];
    registerBtn.backgroundColor=[UIColor redColor];
    
    [registerBtn setTitle:NSLocalizedString(@"registered", @"registered") forState:UIControlStateNormal];
    [registerBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    
    [registerBtn addTarget:self action:@selector(clikeregist) forControlEvents:UIControlEventTouchUpInside];
    
    registerBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    registerBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:registerBtn];
    
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
        
        label13.text = string;
        
    }else if(theTextField == validationView){
        
        NSString * string = @"";
        NSInteger num = validationView.text.length;
        for(NSInteger i = 0;i<num;i++){
            
            string = [NSString stringWithFormat:@"%@●",string];
            
        }
        
        label12.text = string;
        
    }

    
    
}



//注册
-(void)clikeregist{
     NSString *accounttext=accountView.text;
     NSString *vcodetext=validationView.text;
     NSString *passWord=PWDView.text;
    BOOL flag=[self checkTel:accounttext];
    
    if([accounttext isEqualToString:@""]){
        promptLabt.text=NSLocalizedString(@"Please enter the phone number", @"Please enter the phone number");
        return;
        
    }else if (accounttext.length!=11){
        promptLabt.text= NSLocalizedString(@"Please input the correct phone number", @"Please input the correct phone number");
        return;
    }
    else if([vcodetext isEqualToString:@""]){
        promptLabt.text= NSLocalizedString(@"Please enter the password", @"Please enter the password");
        
        return ;
        
//    }else if([passWord isEqualToString:vcodetext]){
//        promptLabt.text= @"两次的密码输入不相等";
//        return ;
    }
    else if([passWord isEqualToString:@""]){
        promptLabt.text= NSLocalizedString(@"Please enter the confirmation password", @"Please enter the confirmation password");
        return;
    }else if(passWord.length<5||passWord.length>22){
        promptLabt.text= NSLocalizedString(@"The password can't be too long or too short", @"The password can't be too long or too short")
        ;
    }else if (flag==NO){
        promptLabt.text= NSLocalizedString(@"Please input the correct phone number", @"Please input the correct phone number");
        return;

    }else{
        [AccountTool registUser:accounttext PassWord:passWord vcode:@"1234" success:^(id  responseObject) {
            NSLog(@"%@",responseObject);
            
            NSString *status=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"status"]];
           //提示语
            if([status isEqualToString:@"0"]){

                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"mesage"]]];
                
            }else{
                [MBProgressHUD showSuccess:NSLocalizedString(@"registered successful", @"registered successful") toView:[UIApplication sharedApplication].keyWindow];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }
        } failure:^(NSError * error) {
            NSLog(@"%@",error);
            
        }];
        
        
    }
}
- (BOOL)checkTel:(NSString *)str
{
    if ([str length] == 0) {
        
        
        return NO;
        
    }
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    if (!isMatch) {
        
        return NO;
    }
    return YES;
    
}
//发送验证码
-(void)cilekSendCode{
    NSString *accounttext=accountView.text;
    if ([accounttext isEqualToString:@""]) {
        promptLabt.text=NSLocalizedString(@"Please enter the phone number", @"Please enter the phone number");
    }else if (accounttext.length!=11) {
        promptLabt.text= @"请输入11位的电话号码";
    }else{
        [AccountTool GetPhoneVerification:accounttext success:^(id responseObject) {
            NSString *status=[NSString stringWithFormat:@"%@",responseObject];
            
            NSLog(@"lsgjalksjglajglasdg%@",status);
            if(![status isEqualToString:@"0"]){
                timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeNum) userInfo:nil repeats:YES];
            }else{
                promptLabt.text= @"请输入有效的手机号码";
            }
        } failure:^(NSError *error) {
            promptLabt.text=@"验证码获取错误";
            
        }];
        
    }
}
//重发验证码
-(void)changeNum{
    num-=1;
    [sendBtn setTitle:[NSString stringWithFormat:@"%ld后重新获取",num] forState:UIControlStateNormal];
    sendBtn.userInteractionEnabled = NO;
    sendBtn.backgroundColor = [UIColor lightGrayColor];
    if (num==0) {
        sendBtn.backgroundColor=[UIColor redColor];
        
        sendBtn.userInteractionEnabled = YES;
        [sendBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        num = 60;
        [timer invalidate];
        
    }
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [PWDView resignFirstResponder];
    [accountView resignFirstResponder];
    [validationView resignFirstResponder];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
