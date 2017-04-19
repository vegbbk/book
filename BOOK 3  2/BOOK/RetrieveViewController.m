//
//  RetrieveViewController.m
//  BOOK
//
//  Created by liujianji on 16/3/8.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "RetrieveViewController.h"
#import "AccountTool.h"
@interface RetrieveViewController (){
    UITextField *phoneNum;
    UITextField *Vcode;
    UITextField *OKPwd;
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

@implementation RetrieveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    num=10;
    self.navigationItem.title=NSLocalizedString(@"Forgot password", @"Forgot password");
    
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"返回"] highImage:[UIImage imageNamed:@"返回"] target:self action:@selector(BackHome) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"Shape 60"] highImage:[UIImage imageNamed:@"Shape 60"] target:self action:@selector(clikeSubmit) forControlEvents:UIControlEventTouchUpInside];
     [self createFrame];
    // Dispose of any resources that can be recreated.
}
-(void)BackHome{
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
    UIView *v1=[[UIView alloc]initWithFrame:CGRectMake(0, 40, CZScreenW, 150)];
    v1.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    v1.layer.borderWidth=1.0;
    [self.view addSubview:v1];
       promptLabt=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 300, 20)];
    promptLabt.textColor=[UIColor redColor];
    promptLabt.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:promptLabt];
    UILabel *accountLab=[[UILabel alloc]initWithFrame:CGRectMake(20, 15, 80, 20)];

    accountLab.text=NSLocalizedString(@"Mobile phone no", @"Mobilephone");
    accountLab.textColor=[UIColor grayColor];
    accountLab.font=[UIFont systemFontOfSize:14];
    [v1 addSubview:accountLab];
    CGFloat x=CGRectGetMaxX(accountLab.frame)+10;
    label11 = [[UILabel alloc]initWithFrame:CGRectMake(x+26, 15, CZScreenW-x-100, 25)];
    label11.textColor = [UIColor grayColor];
    label11.userInteractionEnabled = YES;
    [v1 addSubview:label11];
    phoneNum=[[UITextField alloc]initWithFrame:CGRectMake(x, 15, CZScreenW-x-100, 25)];
    phoneNum.textColor=[UIColor clearColor];
    phoneNum.backgroundColor = [UIColor clearColor];
    phoneNum.placeholder=NSLocalizedString(@"Mobile phone no", @"Mobilephone");
    [phoneNum addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    //    accountView.
    [v1 addSubview:phoneNum];
//    CGFloat sendBtnx=CGRectGetMaxX(phoneNum.frame);
    //发送验证码
//    sendBtn=[[UIButton alloc]initWithFrame:CGRectMake(sendBtnx, 0, 100, 50)];
//    [v1 addSubview:sendBtn];
//    //    [sendBtn setTitle:@"发送验证码" forState:]
//    sendBtn.backgroundColor=[UIColor redColor];
//    
//    [sendBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
//   //发送验证码
//    [sendBtn addTarget:self action:@selector(clikeSend) forControlEvents:UIControlEventTouchUpInside];
//    
//    [sendBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
//    sendBtn.titleLabel.font=[UIFont systemFontOfSize:14];
//    sendBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
  //  创建验证码的输入框
    UIView *v2=[[UIView alloc]initWithFrame:CGRectMake(20, 50, CZScreenW, 1)];
    v2.backgroundColor=[UIColor lightGrayColor];
    [v1 addSubview:v2];
    UILabel *validationLab=[[UILabel alloc]initWithFrame:CGRectMake(20,65 , 70, 20)];
    validationLab.text=NSLocalizedString(@"password", @"password");
    
    validationLab.textColor=[UIColor grayColor];
    validationLab.font=[UIFont systemFontOfSize:14];
    [v1 addSubview:validationLab];
    label12 = [[UILabel alloc]initWithFrame:CGRectMake(x+26, 65, CZScreenW-x, 20)];
    label12.textColor = [UIColor grayColor];
    label12.userInteractionEnabled = YES;
    [v1 addSubview:label12];
    Vcode=[[UITextField alloc]initWithFrame:CGRectMake(x, 65, CZScreenW-x, 20)];
    Vcode.placeholder=NSLocalizedString(@"password", @"password");
    [v1 addSubview:Vcode];
    Vcode.backgroundColor = [UIColor clearColor];
    Vcode.textColor=[UIColor clearColor];
    Vcode.keyboardType=UIKeyboardTypeEmailAddress;
    Vcode.secureTextEntry=YES;
      [Vcode addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
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
    label13.userInteractionEnabled = YES;
    [v1 addSubview:label13];

    OKPwd=[[UITextField alloc]initWithFrame:CGRectMake(x, 115, CZScreenW-x, 20)];
    OKPwd.placeholder=NSLocalizedString(@"Confirmpassword", @"Confirmpassword");
    OKPwd.textColor=[UIColor clearColor];
    OKPwd.backgroundColor = [UIColor clearColor];
    OKPwd.secureTextEntry=YES;
    [v1 addSubview:OKPwd];
      [OKPwd addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    registerBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, CZScreenH*0.4, CZScreenW-40, 44)];
    registerBtn.backgroundColor=[UIColor redColor];
    
    [registerBtn setTitle:NSLocalizedString(@"submit", @"submit") forState:UIControlStateNormal];
    [registerBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(clikeSubmit) forControlEvents:UIControlEventTouchUpInside];
    
    registerBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    registerBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:registerBtn];
    phoneNum.keyboardType=UIKeyboardTypeNumberPad;
    Vcode.keyboardType=UIKeyboardTypeNumberPad;
}

-(void)textFieldDidChange :(UITextField *)theTextField{
    
    if (theTextField==phoneNum) {
        
        label11.text = theTextField.text;
        
    }else if(theTextField == Vcode){
        
        NSString * string = @"";
        NSInteger num = Vcode.text.length;
        for(NSInteger i = 0;i<num;i++){
            
            string = [NSString stringWithFormat:@"%@●",string];
            
        }
        
        label12.text = string;
        
    }else if(theTextField == OKPwd){
        
        NSString * string = @"";
        NSInteger num = OKPwd.text.length;
        for(NSInteger i = 0;i<num;i++){
            
            string = [NSString stringWithFormat:@"%@●",string];
            
        }
        
        label13.text = string;
        
    }
    
    
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [phoneNum resignFirstResponder];
    [Vcode resignFirstResponder];
    [OKPwd resignFirstResponder];
    
}
//修改密码
-(void)clikeSubmit{
    NSString *vcodes=Vcode.text;
    NSString *phoneNums=phoneNum.text;
    NSString *OKPwds=OKPwd.text;

    if([phoneNums isEqualToString:@""]){
        promptLabt.text= NSLocalizedString(@"Please enter the phone number", @"Please enter the phone number");
        return;
        
    }else if (phoneNums.length!=11){
        promptLabt.text= NSLocalizedString(@"Please input the correct phone number", @"Please input the correct phone number");
        return;
//    }else if ([vcodes isEqualToString:OKPwds]){
//        promptLabt.text= @"两次密码输入不一致";
//        return;
    }
    else if([vcodes isEqualToString:@""]){
        promptLabt.text= NSLocalizedString(@"Please enter the password", @"Please enter the password");
        return ;
        
    }else if([OKPwds isEqualToString:@""]){
        promptLabt.text=NSLocalizedString(@"Please enter the confirmation password", @"Please enter the confirmation password");
        return;
    }else if(OKPwds.length<5||OKPwds.length>22){
        promptLabt.text=NSLocalizedString(@"The password can't be too long or too short", @"The password can't be too long or too short");
    }else{
        [AccountTool UpdatePad:phoneNums PassWord:OKPwds vcode:@"1234" success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            
            NSString *status=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"status"]];
            if([status isEqualToString:@"0"]){
                promptLabt.text=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"mesage"]];
                
            }else{
                [MBProgressHUD showSuccess:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"message"]] toView:[UIApplication sharedApplication].keyWindow];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }

        } failure:^(NSError * error) {
            NSLog(@"%@",error);
            
        }];
        
        
        
    }
//
}
//发送验证码

-(void)clikeSend{
    NSString *accounttext=phoneNum.text;
    if ([accounttext isEqualToString:@""]) {
        promptLabt.text= @"请先输入电话号码";
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
//发送验证码的时间
-(void)changeNum{
    num-=1;
    [sendBtn setTitle:[NSString stringWithFormat:@"%li后重新获取",num] forState:UIControlStateNormal];
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


@end
