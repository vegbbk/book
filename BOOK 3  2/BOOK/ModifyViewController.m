//
//  ModifyViewController.m
//  BOOK
//
//  Created by liujianji on 16/3/8.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "ModifyViewController.h"
#import "AccountTool.h"
@interface ModifyViewController ()
{
    UITextField *OldPwd;
    UITextField *newPwd;
    UITextField *OKPwd;
    UILabel *promptLabt;
    UILabel * label11;
    UILabel * label12;
    UILabel * label13;
}
@end

@implementation ModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"返回"] highImage:[UIImage imageNamed:@"返回"] target:self action:@selector(BackHome) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=NSLocalizedString(@"Change the password", @"Change the password");
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"Shape 60"] highImage:[UIImage imageNamed:@"Shape 60"] target:self action:@selector(clikeSave) forControlEvents:UIControlEventTouchUpInside];
    
    [self createFrameUI];
    
}
//-(void)viewDidAppear:(BOOL)animated{
//    self.navigationController.navigationBarHidden=YES;
//
//}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent=NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.translucent=YES;
}

-(void)BackHome{
    [self.navigationController popViewControllerAnimated:NO];
    
}
-(void)createFrameUI{
    //创建外部视图
    UIView *v1=[[UIView alloc]initWithFrame:CGRectMake(0, 50, CZScreenW, 150)];
    v1.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    v1.layer.borderWidth=1.0;
    promptLabt=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 200, 20)];
    promptLabt.textColor=[UIColor redColor];
    promptLabt.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:promptLabt];
    [self.view addSubview:v1];
    UILabel *accountLab=[[UILabel alloc]initWithFrame:CGRectMake(20, 15, 60, 20)];
    
    accountLab.text=NSLocalizedString(@"oldpassword", @"oldpassword");
    accountLab.textColor=[UIColor grayColor];
    accountLab.font=[UIFont systemFontOfSize:14];
    [v1 addSubview:accountLab];
    CGFloat x=CGRectGetMaxX(accountLab.frame)+10;
    label11 = [[UILabel alloc]initWithFrame:CGRectMake(x+26, 15, CZScreenW-x-100, 25)];
    label11.textColor = [UIColor grayColor];
    label11.userInteractionEnabled = YES;
    [v1 addSubview:label11];
    OldPwd=[[UITextField alloc]initWithFrame:CGRectMake(x, 15, CZScreenW-x-100, 25)];
    OldPwd.textColor=[UIColor clearColor];
    OldPwd.backgroundColor = [UIColor clearColor];
    OldPwd.placeholder=NSLocalizedString(@"oldpassword", @"oldpassword");;
    [OldPwd addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    //    accountView.
    [v1 addSubview:OldPwd];
    
    //创建验证码的输入框
    UIView *v2=[[UIView alloc]initWithFrame:CGRectMake(0, 50, CZScreenW, 1)];
    v2.backgroundColor=[UIColor lightGrayColor];
    [v1 addSubview:v2];
    UILabel *validationLab=[[UILabel alloc]initWithFrame:CGRectMake(20,65 , 70, 20)];
    validationLab.text=NSLocalizedString(@"newpassword", @"newpassword");
    
    validationLab.textColor=[UIColor grayColor];
    validationLab.font=[UIFont systemFontOfSize:14];
    [v1 addSubview:validationLab];
    label12 = [[UILabel alloc]initWithFrame:CGRectMake(x+26, 65, CZScreenW-x, 20)];
    //label12.textColor = [UIColor grayColor];
    label12.font = [UIFont systemFontOfSize:12];
    label12.userInteractionEnabled = YES;
    [v1 addSubview:label12];
    newPwd=[[UITextField alloc]initWithFrame:CGRectMake(x, 65, CZScreenW-x, 20)];
    newPwd.placeholder=NSLocalizedString(@"newpassword", @"newpassword");
    newPwd.secureTextEntry = YES;
    newPwd.textColor = [UIColor clearColor];
    [v1 addSubview:newPwd];
    [newPwd addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    //创建密码的输入框
    UIView *v3=[[UIView alloc]initWithFrame:CGRectMake(0, 100, CZScreenW, 1)];
    v3.backgroundColor=[UIColor lightGrayColor];
    [v1 addSubview:v3];
    UILabel *pwdLab=[[UILabel alloc]initWithFrame:CGRectMake(20,115 , 70, 20)];
    pwdLab.text=NSLocalizedString(@"Confirmpassword", @"Confirmpassword");
    
    pwdLab.textColor=[UIColor grayColor];
    pwdLab.font=[UIFont systemFontOfSize:14];
    [v1 addSubview:pwdLab];
    label13 = [[UILabel alloc]initWithFrame:CGRectMake(x+26, 115, CZScreenW-x, 20)];
   // label13.textColor = [UIColor grayColor];
    label13.font = [UIFont systemFontOfSize:12];
    label13.userInteractionEnabled = YES;
    [v1 addSubview:label13];
    OKPwd=[[UITextField alloc]initWithFrame:CGRectMake(x, 115, CZScreenW-x, 20)];
    OKPwd.placeholder=NSLocalizedString(@"Confirmpassword", @"Confirmpassword");
    OKPwd.textColor = [UIColor clearColor];
    [v1 addSubview:OKPwd];
    OKPwd.secureTextEntry = YES;
    [OKPwd addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}

-(void)textFieldDidChange :(UITextField *)theTextField{
    
    if (theTextField==OldPwd) {
        
        label11.text = theTextField.text;
        
    }else if(theTextField == newPwd){
        
        NSString * string = @"";
        NSInteger num = newPwd.text.length;
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

//保存
-(void)clikeSave{
    NSString *oldPwds=OldPwd.text;
    NSString *newPwds=newPwd.text;
    NSString *OkPwds=OKPwd.text;
    if([oldPwds isEqualToString:@""]){
        promptLabt.text= NSLocalizedString(@"Please enter the old password", @"Please enter the old password");
        return;
        
    }else if([newPwds isEqualToString:@""]){
        promptLabt.text= NSLocalizedString(@"Please enter a new password", @"Please enter a new password");
        return ;
        
    }else if([OkPwds isEqualToString:@""]){
        promptLabt.text= NSLocalizedString(@"Please enter the confirmation password", @"Please enter the confirmation password");
        return;
    }else if(OkPwds.length<5||OkPwds.length>22){
        promptLabt.text= NSLocalizedString(@"The password can't be too long or too short", @"The password can't be too long or too short");
    }else if (![OkPwds isEqualToString:newPwds]){
        promptLabt.text= NSLocalizedString(@"Two input password is not the same", @"Two input password is not the same");
    }
    else{
        [AccountTool ModifyPwd:oldPwds PassWord:newPwds vcode:OkPwds success:^(id responseObject) {
            NSString *status=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"status"]];
            
            if([status isEqualToString:@"0"]){
                promptLabt.text=NSLocalizedString(@"Modify the failure", @"Modify the failure");
                
            }else{
                
                //                [MBProgressHUD showSuccess:@"找回成功" toView:self.view];
                [MBProgressHUD showMessage:NSLocalizedString(@"Modify the success", @"Modify the success") toView:[UIApplication sharedApplication].keyWindow];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            
        } failure:^(NSError *error) {
            
        }];
        
        
        //        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [OKPwd resignFirstResponder];
    [OldPwd resignFirstResponder];
    [newPwd resignFirstResponder];
    
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
