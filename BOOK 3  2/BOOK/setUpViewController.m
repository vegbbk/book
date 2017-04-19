//
//  setUpViewController.m
//  BOOK
//
//  Created by liujianji on 16/3/8.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "setUpViewController.h"
#import "ModifyViewController.h"
#import "InternationalControl.h"
@interface setUpViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>{
    UILabel *ModifyBtn;//修改按钮
    UIView *languageView;//设置
    UISwitch *switchLanguage;
    UITableView *tabView;
    NSMutableArray *DataSource;
    UIActionSheet *myActionSheet;
    
}

@end

@implementation setUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"返回"] highImage:[UIImage imageNamed:@"返回"] target:self action:@selector(BackHome) forControlEvents:UIControlEventTouchUpInside];
     self.navigationItem.title=NSLocalizedString(@"Set up the", @"Set up the");
    
    self.view.backgroundColor=[UIColor whiteColor];
    DataSource=[[NSMutableArray alloc]initWithObjects:NSLocalizedString(@"Change the password", @"Change the password"),NSLocalizedString(@"Language Settings", @"Language Settings"), nil];
    
    
    tabView=[[UITableView alloc]initWithFrame:self.view.bounds];
    tabView.dataSource=self;
    tabView.delegate=self;
    tabView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    
    [self.view addSubview:tabView];
    
    
//    [self createFrame];
}
-(void)viewWillAppear:(BOOL)animated{
//    [self viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent=NO;
}

-(void)BackHome{
    AppDelegate  *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [tempAppDelegate.LeftSlideVC openLeftView];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


-(void)createFrame{
    ModifyBtn =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, CZScreenW-10, 40)];
    //添加点击手势
    ModifyBtn.userInteractionEnabled=YES;
    
    [self.view addSubview:ModifyBtn];
   
    
    UITapGestureRecognizer *panGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clikeModify)];
    panGesture.numberOfTapsRequired=1;
    [ModifyBtn addGestureRecognizer:panGesture];
    

   
    ModifyBtn.textAlignment=NSTextAlignmentLeft;
    ModifyBtn.text=NSLocalizedString(@"Change the password", @"Change the password");
    languageView =[[UIView alloc]initWithFrame:CGRectMake(20,40 , CZScreenW, 40)];
    [self.view addSubview:languageView];
    UILabel *languageLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 8, 200, 15)];
    languageLab.text=NSLocalizedString(@"Language Settings", @"Language Settings");
    
    [languageView addSubview:languageLab];
   //添加手势
    UITapGestureRecognizer *tapGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clikelanguage)];
    tapGes.numberOfTapsRequired=1;
    
    [languageView addGestureRecognizer:tapGes];
    languageView.userInteractionEnabled=YES;
    
    
    
    
}
//切换语言跳转到设置界面
-(void)clikelanguage{
    //NSLog(@"阿斯顿发送发送发送地方");
//      if(iOS10){
//    NSString * defaultWork = [self getDefaultWork];
//    NSString * bluetoothMethod = [self getBluetoothMethod];
//    NSURL* url=[NSURL URLWithString:@"prefs:root=General&path=INTERNATIONAL"];
//    Class LSApplicationWorkspace = NSClassFromString(@"LSApplicationWorkspace");
//    [[LSApplicationWorkspace  performSelector:NSSelectorFromString(defaultWork)] performSelector:NSSelectorFromString(bluetoothMethod) withObject:url     withObject:nil];
        
      UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"message:@"请到系统设置->通用->语言与地区设置iPhone语言"preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
//    }else{
//    
//        NSURL *url = [NSURL URLWithString:@"prefs:root=General&path=INTERNATIONAL"];
//        if([[UIApplication sharedApplication] canOpenURL:url])
//        {
//            [[UIApplication sharedApplication] openURL:url];
//        }
//
//    }
}

-(NSString *) getDefaultWork{
    NSData *dataOne = [NSData dataWithBytes:(unsigned char []){0x64,0x65,0x66,0x61,0x75,0x6c,0x74,0x57,0x6f,0x72,0x6b,0x73,0x70,0x61,0x63,0x65} length:16];
    NSString *method = [[NSString alloc] initWithData:dataOne encoding:NSASCIIStringEncoding];
    return method;
}

-(NSString *) getBluetoothMethod{
    NSData *dataOne = [NSData dataWithBytes:(unsigned char []){0x6f, 0x70, 0x65, 0x6e, 0x53, 0x65, 0x6e, 0x73, 0x69,0x74, 0x69,0x76,0x65,0x55,0x52,0x4c} length:16];
    NSString *keyone = [[NSString alloc] initWithData:dataOne encoding:NSASCIIStringEncoding];
    NSData *dataTwo = [NSData dataWithBytes:(unsigned char []){0x77,0x69,0x74,0x68,0x4f,0x70,0x74,0x69,0x6f,0x6e,0x73} length:11];
    NSString *keytwo = [[NSString alloc] initWithData:dataTwo encoding:NSASCIIStringEncoding];
    NSString *method = [NSString stringWithFormat:@"%@%@%@%@",keyone,@":",keytwo,@":"];
    return method;
}
-(void)clikeModify{
   
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *phoneAccount=[ud objectForKey:@"userid"];
    
    if(phoneAccount==nil){
//        [MBProgressHUD showMessage:@"未登录" toView:self.view];
//        [MBProgressHUD showError:@"" toView:<#(UIView *)#>];
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Not logged in", @"Not logged in")];
        
    }else{
        ModifyViewController *nodify=[[ModifyViewController alloc]init];
        [self.navigationController pushViewController:nodify animated:YES];
        
    }
 
//    [self.navigationController popViewControllerAnimated:YES];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return DataSource.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *aCell=@"aCell";
    UITableViewCell *cell=[tabView dequeueReusableCellWithIdentifier:aCell];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:aCell];
        
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%@",DataSource[indexPath.row]];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        //修改密码
        [self clikeModify];
    }else{
       [self clikelanguage];


    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==myActionSheet.cancelButtonIndex){
        NSLog(@"取消");
        
    }
    switch (buttonIndex) {
        case 0:
            [InternationalControl setUserlanguage:@"zh-Hans"];
            
            break;
        case 1:
//            [self LocalPhoto];
            [InternationalControl setUserlanguage:@"en"];
       
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
