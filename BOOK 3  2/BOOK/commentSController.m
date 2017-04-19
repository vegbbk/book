//
//  commentSController.m
//  BOOK
//
//  Created by wangyang on 16/3/28.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "commentSController.h"
#import "BBSTool.h"
#import "commentSViewCell.h"
#import "commentsModel.h"
@interface commentSController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
   UITableView *tabView;
    NSMutableArray *listArray;
    UITextField *textFiled;
    UIView *view1;
    UIButton *sendBtn;
    
    
}

@end

@implementation commentSController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    NSString *commentId=[NSString stringWithFormat:@"%@",_commentId];
    
    
    self.navigationController.navigationBar.translucent=NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"评论";
    listArray=[NSMutableArray array];
     self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"返回"] highImage:[UIImage imageNamed:@"返回"] target:self action:@selector(BackHome) forControlEvents:UIControlEventTouchUpInside];
    tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, CZScreenW, self.view.height-90)];
    tabView.delegate=self;
    tabView.dataSource=self;
    tabView.separatorStyle=UITableViewCellSeparatorStyleNone;
   
    [self.view addSubview:tabView];
   
    [self initDate];
    
   
    
    [self createFooterFrame];
    
    // Do any additional setup after loading the view.
}
-(void)initDate{
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if([_commentId isEqualToString:@""]){
            
        }else{
        }
        [BBSTool releaseList:_commentId andsuccess:^(id responseObject) {
            [listArray removeAllObjects];
            
            NSArray *array1=responseObject;
            for (commentsModel *model in array1) {
                [listArray addObject:model];
                
            }
            [tabView reloadData];
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        } failure:^(NSError *error) {
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });

}
-(void)BackHome{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)createFooterFrame{
    
    view1=[[UIView alloc]initWithFrame:CGRectMake(0, CZScreenH-104, CZScreenW,40 )];
    //    view1.backgroundColor=[UIColor redColor];
    
    view1.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    view1.layer.borderWidth=1.0;
//    view1.backgroundColor=[UIColor redColor];
    
    textFiled=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, CZScreenW-60, 30)];
    [view1 addSubview:textFiled];
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(CZScreenW-80, 5, 1, 30)];
    view2.backgroundColor=[UIColor grayColor];
    [view1 addSubview:view2];
    textFiled.placeholder=@"请填写评论";
    //设置return建的样式
    textFiled.returnKeyType=UIReturnKeySend;
    textFiled.leftView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"填写评论"]];
    textFiled.leftViewMode=UITextFieldViewModeAlways;
    tabView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    textFiled.delegate=self;
    sendBtn=[[UIButton alloc]initWithFrame:CGRectMake(CZScreenW-70, 10, 60, 30)];
    //    sendBtn.backgroundColor=[UIColor blueColor];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    sendBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [view1 addSubview:sendBtn];
    [sendBtn addTarget:self action:@selector(clikeSend) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:view1];
    
}
-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [listArray count];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    commentSViewCell *cell=[commentSViewCell cellWithTableView:tableView];
    if(listArray.count==0){
        UILabel *lab=[[UILabel alloc]initWithFrame:cell.bounds];
        lab.textColor=[UIColor lightGrayColor];
        lab.font=[UIFont systemFontOfSize:25];
        lab.text=@"没有任何的评论";
        
    }else{
        commentsModel *model=listArray[indexPath.row];
      
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.avatar]]];
        cell.LabName.text=[NSString stringWithFormat:@"%@",model.mobile];
        NSString *dateStrimng=[ZBTime intervalSinceNow:model.createtime];
        
        cell.LabTime.text=[NSString stringWithFormat:@"%@",dateStrimng];
        
        cell.textView.text=[NSString stringWithFormat:@"%@",model.content];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        cell.layer.borderColor=[[UIColor lightGrayColor]CGColor];
        cell.layer.borderWidth=0.5;
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //    [textFiled becomeFirstResponder];
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *phoneAccount=[ud objectForKey:@"userid"];
    
    if(phoneAccount==nil){
        //        [MBProgressHUD showMessage:@"没有登录" toView:self.view];
        [MBProgressHUD showSuccess:@"没有登录" toView:self.view];
        return NO;
    }else{
        
        self.view.frame=CGRectMake(0, -198, CZScreenW, CZScreenH);
        return YES;
    }
    
    
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [textFiled resignFirstResponder];
    self.view.frame=CGRectMake(0, 64, CZScreenW, CZScreenH);
    return YES;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textFiled resignFirstResponder];
    //调用发送界面
    
    [self clikeSend];
    self.view.frame=CGRectMake(0, 64, CZScreenW, CZScreenH);
    return YES;
}
-(void)clikeSend{
     self.view.frame=CGRectMake(0, 64, CZScreenW, CZScreenH);
    NSString *contet=textFiled.text;
    if([contet isEqualToString:@""]){
        //        [MBProgressHUD showMessage:@"文字不能为空"];
        [SVProgressHUD showErrorWithStatus:@"文字不能为空"];
    }else{
      
        [BBSTool publishedcomment:_commentId content:contet success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            NSDate *date=[NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss SS"];
            NSString *dateString = [ZBTime intervalSinceNow:[dateFormatter stringFromDate:date]];
            
            commentsModel *model=[[commentsModel alloc]init];
            model.createtime=dateString;
            model.content=contet;
//            [listArray addObject:model];
                   [self initDate];
            
            [tabView reloadData];
            
        } failure:^(NSError *error) {
            
        }];
        
    }
    textFiled.text=@"";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
