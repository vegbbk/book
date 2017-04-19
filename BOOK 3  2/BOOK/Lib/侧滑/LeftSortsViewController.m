//
//  LeftSortsViewController.m
//  LGDeckViewController
//
//  Created by jamie on 15/3/31.
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//

#import "LeftSortsViewController.h"
#import "AppDelegate.h"
#import "UIView+Frame.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "BookFavTableViewController.h"
#import "DownloadController.h"
#import "setUpViewController.h"
#import "AboutUsViewController.h"
#import "releaseViewController.h"
#import "ServicebackController.h"
#import "AccountTool.h"
#import "AccountModel.h"
//#import "DownPDFController.h"
#import "DownBookController.h"

#define kLeftScale 0.7 //左侧初始缩放比例
@interface LeftSortsViewController () <UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIView *headView;//头部试图
    UIImageView *headImage;//头像试图
    UIButton *nickName;//用户名
    UIButton *collectionBtn;//收藏按钮
    UIButton *readingBtn;//离线按钮
    AppDelegate *tempAppDelegate;
    UIImagePickerController *pickerImage;//跳转相册
    UIActionSheet  * myActionSheet;
    
}
@end

@implementation LeftSortsViewController
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.translucent=YES;
    self.navigationController.navigationBarHidden=YES;
    self.leftSlide=[[LeftSlideViewController alloc]init];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
      NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(initDateuser) name:@"login" object:nil];
    [self createFrame];
    
}
//创建试图
-(void)createFrame{
    //创建表格试图
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,  self.view.bounds.size.height) style:UITableViewStyleGrouped];
  //  tableview.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor=[UIColor whiteColor];
    self.tableview = tableview;
    tableview.dataSource = self;
    tableview.delegate  = self;
    _tableview.scrollEnabled=NO;
    
    //    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    //创建头部试图
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor grayColor];
    
    if (indexPath.row == 0) {
        
        cell.textLabel.text =NSLocalizedString(@"Service feedback", @"Service feedback");
        cell.imageView.image=[UIImage imageNamed:@"服务反馈"];
        
    } else if (indexPath.row == 1) {
        cell.textLabel.text = NSLocalizedString(@"About us", @"About us");
        cell.imageView.image=[UIImage imageNamed:@"关于我们"];
    } else if (indexPath.row == 2) {
        cell.textLabel.text = NSLocalizedString(@"I release", @"I release");
        cell.imageView.image=[UIImage imageNamed:@"我的发布"];

    }
        else if (indexPath.row == 3) {
        cell.textLabel.text = NSLocalizedString(@"set Up", @"set Up");
        cell.imageView.image=[UIImage imageNamed:@"设置"];
    } else if (indexPath.row == 4) {
        cell.imageView.image=[UIImage imageNamed:@"退出登录"];
        cell.textLabel.text = NSLocalizedString(@"Log Out", @"Log Out");
    }
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    
    return cell;
}



-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 150;
}
//设置头部视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width*0.7, 150)];
    
//    headView.backgroundColor=[UIColor lightGrayColor];
    headView.backgroundColor=[UIColor colorWithRed:72/255.0 green:72/255.0 blue:72/255.0 alpha:1.0];
//
    headImage=[[UIImageView alloc]initWithFrame:CGRectMake(20, 40, 60, 60)];
    headImage.userInteractionEnabled=YES;
    headImage.layer.cornerRadius=30;
    headImage.layer.borderWidth=2.0;
    headImage.layer.borderColor=[[UIColor whiteColor]CGColor];
    
    //添加手势更换头像
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(uploadHead)];
    
    tapGesture.numberOfTapsRequired=1;
    [headImage addGestureRecognizer:tapGesture];
    
    headView.layer.borderColor=[[UIColor whiteColor]CGColor];
    headView.layer.borderWidth=2.0;
    headImage.layer.masksToBounds=YES;
    
    headImage.image=[UIImage imageNamed:@"头像"];
    
    [headView addSubview:headImage];
    nickName=[[UIButton alloc]initWithFrame:CGRectMake(90, 70, 100, 20)];
    //    nickName.text=NSLocalizedString(@"login", @"login");
    //判读是否登录
    
    nickName.titleLabel.font=[UIFont systemFontOfSize:13];
    [headView addSubview:nickName];
    
    [nickName setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    NSNotification *notifi=[[NSNotification alloc]init];
//    [self initDate:notifi];
    
//    NSNotificationCenter *nofi=[NSNotification ]
   [self initDateuser];
    
    collectionBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 120, headView.width/2, 25)];
    [headView addSubview:collectionBtn];
    [collectionBtn setTitle:NSLocalizedString(@"My collection", @"My collection") forState:UIControlStateNormal];
    [collectionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    collectionBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    //添加点击事件
    [collectionBtn addTarget:self action:@selector(clikeFav) forControlEvents:UIControlEventTouchUpInside];
    
    [collectionBtn setImage:[UIImage imageNamed:@"我的收藏"] forState:UIControlStateNormal];
    readingBtn=[[UIButton alloc]initWithFrame:CGRectMake(headView.width/2, 120, headView.width/2,25)];
    
    [headView addSubview:readingBtn];
    [readingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [readingBtn setTitle:NSLocalizedString(@"Offline reading", @"Offline reading") forState:UIControlStateNormal];
    UIView *V1=[[UIView alloc]initWithFrame:CGRectMake(headView.width/2-1, 120, 2, 30)];
    [headView addSubview:V1];
    V1.backgroundColor=[UIColor whiteColor];
    
    readingBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    //添加点击事件
    [readingBtn addTarget:self action:@selector(cilkereading) forControlEvents:UIControlEventTouchUpInside];
    
    [readingBtn setImage:[UIImage imageNamed:@"离线阅读"] forState:UIControlStateNormal];
//
    return headView;
    
}
//跟换头像
-(void)uploadHead{
    //判断是否登录

    
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
 
    NSString *flag=[NSString stringWithFormat:@"%@",[ud objectForKey:@"flag"]];
    if([flag isEqualToString:@"0"]){
        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Not logged in", @"Not logged in")];
        
    }else{
        [tempAppDelegate.LeftSlideVC closeLeftView];
        myActionSheet = [[UIActionSheet alloc]
                         
                         initWithTitle:nil
                         
                         delegate:self
                         
                         cancelButtonTitle:NSLocalizedString(@"cancel", @"cancel")
                         
                         destructiveButtonTitle:nil
                         
                         otherButtonTitles: NSLocalizedString(@"Open the camera",@"Open the camera"), NSLocalizedString(@"Open the photo album", @"Open the photo album"),nil];
        
        [myActionSheet showInView:self.view];
        
        [myActionSheet reloadInputViews];

    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==myActionSheet.cancelButtonIndex){
        NSLog(@"取消");
        
    }
    switch (buttonIndex) {
        case 0:
            [self takePhoto];
            
            break;
        case 1:
            [self LocalPhoto];
            
        default:
            break;
    }
}
//开始拍照
-(void)takePhoto{
    //调用相机
    UIImagePickerControllerSourceType souceType=UIImagePickerControllerSourceTypeCamera;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        pickerImage=[[UIImagePickerController alloc]init];
        pickerImage.delegate=self;
        pickerImage.sourceType=souceType;
        pickerImage.allowsEditing=YES;
        [pickerImage reloadInputViews];
     
        [self presentViewController:pickerImage animated:YES completion:nil];

    }else {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
        
    }
   
}
//打开本地相册
-(void)LocalPhoto{
    pickerImage=[[UIImagePickerController alloc]init];
    //打开相册
    pickerImage.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    pickerImage.delegate=self;
    pickerImage.allowsEditing=YES;
    [pickerImage reloadInputViews];
    
    [self presentViewController:pickerImage animated:YES completion:nil];
    
    
}
//取消选择
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"您取消了选择图片");
    [pickerImage dismissViewControllerAnimated:YES completion:nil];
    
}
//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *type=[info objectForKey:UIImagePickerControllerMediaType];
    UIImage *image;
    
    if([type isEqualToString:@"public.image"]){
        image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [self uploadHeadfiles:image];
        
        NSData *data;
        if(UIImagePNGRepresentation(image)==nil){
            data=UIImageJPEGRepresentation(image, 0.01);
            
        }else{
            data=UIImagePNGRepresentation(image);
        }
        
        image=[UIImage imageWithData:data];
        
        image=[UIImage fixOrientation:image];
        
        image=[UIImage imageWithImageSimple:image scaledToSize:  CGSizeMake(300, 300)];
        
        headImage.image=image;
    }
    [pickerImage dismissViewControllerAnimated:YES completion:nil];
    
}
//上传头像
-(void)uploadHeadfiles:(UIImage *)image{
    
   
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=Send&a=uploadHeadImg"];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *userid=[ud objectForKey:@"userid"];
    dic[@"user_id"]=userid;
    

    [CZHttpTool PostHeadImage:urlStr parameters:dic imageFile:image fileKey:@"uploadfile" success:^(NSDictionary *responseObject) {
        NSString *status=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"status"]];
        if([status isEqualToString:@"1"]){
            NSString *urlStr=[NSString stringWithFormat:@"%@%@",LOCAL,[responseObject objectForKey:@"avatar"]];
            [ud setObject:urlStr forKey:@"userphoto"];
        }
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error){
        
    }];
    
}
-(void)initDateuser{

    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *flag=[NSString stringWithFormat:@"%@",[ud objectForKey:@"flag"]];
    
      if([flag isEqualToString:@"0"] ){
        [nickName setTitle:NSLocalizedString(@"login", @"login") forState:UIControlStateNormal];
        [nickName addTarget:self action:@selector(clikeLogin) forControlEvents:UIControlEventTouchUpInside];
          nickName.userInteractionEnabled=YES;
          headImage.image=[UIImage imageNamed:@"头像"];
          
          
    }else{
        NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
       

        NSString *userphone=[ud objectForKey:@"userphone"];
        
        [nickName setTitle:userphone forState:UIControlStateNormal];
        
        
        NSString *urlstr=[NSString stringWithFormat:@"%@",[ud objectForKey:@"userphoto"]];
        
        nickName.userInteractionEnabled=NO;
        
        [headImage sd_setImageWithURL:[NSURL URLWithString:urlstr]];
      }
    
}
//离线阅读页面
-(void)cilkereading{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
   NSString *flag=[NSString stringWithFormat:@"%@",[ud objectForKey:@"flag"]];
    if([flag isEqualToString:@"0"] ){
        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Not logged in", @"Not logged in")];
        
   
    }else{
        [tempAppDelegate.LeftSlideVC closeLeftView];
        DownBookController *pdf= [[DownBookController alloc]init];
        
        [tempAppDelegate.navc pushViewController:pdf animated:NO];
    }
}
//收藏页面
-(void)clikeFav{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
   NSString *flag=[NSString stringWithFormat:@"%@",[ud objectForKey:@"flag"]];
      if([flag isEqualToString:@"0"] ){
          [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Not logged in", @"Not logged in")];
      }else{
          
          BookFavTableViewController *bookfav=[[BookFavTableViewController alloc]init];
          [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
          [tempAppDelegate.navc pushViewController:bookfav animated:NO];

      }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *flag=[NSString stringWithFormat:@"%@",[ud objectForKey:@"flag"]];
    
    if([flag isEqualToString:@"0"]){
        if(indexPath.row==0){
            ServicebackController *server=[[ServicebackController alloc]init];
         
            [tempAppDelegate.navc pushViewController:server animated:NO];
            
        }else if (indexPath.row==1){
            AboutUsViewController * aboutus=[[AboutUsViewController alloc]init];
            [tempAppDelegate.navc pushViewController:aboutus animated:NO];
        } else if (indexPath.row == 3) {
            setUpViewController * setUp=[[setUpViewController alloc]init];
            [tempAppDelegate.navc pushViewController:setUp animated:NO];
        }
        else{
            [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Not logged in", @"Not logged in")];
            
        }
        return;
        
    }else{
        if(indexPath.row==0){
            
            ServicebackController *server=[[ServicebackController alloc]init];
            [tempAppDelegate.navc pushViewController:server animated:nil];
            
        }else if (indexPath.row==1){
            AboutUsViewController *aboutus=[[AboutUsViewController alloc]init];
            [tempAppDelegate.navc pushViewController:aboutus animated:NO];
        }else if(indexPath.row==2){
            
            releaseViewController *release=[[releaseViewController alloc]init];
            [tempAppDelegate.navc pushViewController:release animated:NO];
            
        }
        else if (indexPath.row == 3) {
            setUpViewController *setUp=[[setUpViewController alloc]init];
            [tempAppDelegate.navc pushViewController:setUp animated:NO];
            
        }else if (indexPath.row==4){
            [AccountTool exitLoginOut:^(NSString *status) {
                NSString *exitStatus=[NSString stringWithFormat:@"%@",status];
                
                if([exitStatus isEqualToString:@"0"]){

                    
                }else{
                    
                    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
                    NSLog(@"%@",[ud objectForKey:@"flag"]);
                    [ud setObject:@(NO) forKey:@"flag"];
                    [ud setObject:nil forKey:@"userid"];
                    [ud setObject:nil forKey:@"userPhone"];
                    [ud setObject:nil forKey:@"userphoto"];
                    [ud setObject:nil forKey:@"pwd"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    NSLog(@"%@",[ud objectForKey:@"flag"]);
                    
                   [[NSNotificationCenter defaultCenter]postNotificationName:@"login" object:nil];
                    
                }
            } failure:^(NSError *error) {
                
            }];
            
            
        }
        
    }

}

//点击登录
-(void)clikeLogin{
    LoginViewController *login=[[LoginViewController alloc]init];
    [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉

    
    [tempAppDelegate.navc pushViewController:login animated:YES];

    
}

@end
