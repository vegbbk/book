//
//  BookFavTableViewController.m
//  BOOK
//
//  Created by liujianji on 16/3/7.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "BookFavTableViewController.h"
#import "BooKFavTableViewCell.h"
#import "AccountTool.h"
#import "DirectoryModel.h"
#import "releaseDetailController.h"
#import "AccountTool.h"
#import "bookInfoLJJViewController.h"
@interface BookFavTableViewController (){
    NSMutableArray *dataSource;
    
}

@end

@implementation BookFavTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=NSLocalizedString(@"My collection", @"My collection");
    dataSource=[NSMutableArray array];
   // self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CZScreenW, CZScreenH-64) style:UITableViewStyleGrouped];
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.tableView registerClass:[BooKFavTableViewCell class] forCellReuseIdentifier:@"cell"];
   
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"返回"] highImage:[UIImage imageNamed:@"返回"] target:self action:@selector(BackHome) forControlEvents:UIControlEventTouchUpInside];

   // NSString *urlStr=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=User&a=mysc"];
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",LOCAL,@"index.php?g=server&m=User&a=mysc"];
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    
    NSString *phoneAccount=[ud objectForKey:@"userid"];
    
    dic[@"user_id"]=phoneAccount;
        [CZHttpTool Post:urlStr parameters:dic success:^(id responseObject) {
            NSLog(@"阿斯顿噶三等功%@",responseObject);
            NSArray *array1=[DirectoryModel objectArrayWithKeyValuesArray:[responseObject objectForKey:@"data"]];
            for (DirectoryModel *model in array1) {
                [dataSource addObject:model];
            }
            [self.tableView reloadData];
            
        } failure:^(NSError *error) {
            
        }];
}
//返回
-(void)BackHome{
  
    [SVProgressHUD dismiss];
    AppDelegate  *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [tempAppDelegate.LeftSlideVC openLeftView];
   [self.navigationController popToRootViewControllerAnimated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    BooKFavTableViewCell *cell=[BooKFavTableViewCell CellWithTableView:tableView];
    DirectoryModel *model=[dataSource objectAtIndex:indexPath.section];
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",LOCAL,model.thumb];
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"图层 1"]];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.bookName.text=[NSString stringWithFormat:@"%@",model.title];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CZScreenW*0.3;
    
}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 10;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     DirectoryModel *model=[dataSource objectAtIndex:indexPath.section];
    if([model.isMagazine isEqualToString:@"N"]){
    releaseDetailController *detail=[[releaseDetailController alloc]init];
    detail.hidesBottomBarWhenPushed = YES;
    detail.postId=model.post_id;
    detail.ID=model.tid;
    detail.navigationItem.title=NSLocalizedString(@"article details", @"article details");
    detail.post_hits = model.post_hits;
    detail.favarticle=@"favarticle";
    
    [self.navigationController pushViewController:detail animated:NO];
    }else{
        bookInfoLJJViewController * info = [[bookInfoLJJViewController alloc]init];
        info.hidesBottomBarWhenPushed=YES;
        info.postIDStr = model.post_id;
        info.IDstr = model.post_keywords;
        info.post_hits = model.post_hits;
        info.where = @"cedsd";
        info.post_hits = model.post_hits;
        [self.navigationController pushViewController:info animated:NO];
    
    }
}
//删除收藏
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
   if (editingStyle ==UITableViewCellEditingStyleDelete) {
       NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
       
       NSString *phoneAccount=[ud objectForKey:@"userid"];
         DirectoryModel *model=[dataSource objectAtIndex:indexPath.section];
       [AccountTool deleteFav:phoneAccount andfavId:model.ID andsuccess:^(id responseObject) {

           NSString *status=[NSString stringWithFormat:@"%@",responseObject[@"status"]];
           if ([status isEqualToString:@"1"]) {
               [SVProgressHUD showSuccessWithStatus:responseObject[@"message"]];
               [dataSource removeObjectAtIndex:indexPath.section];
               [tableView reloadData];
           }else{
               [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
               
           }
       } andfailure:^(NSError *error) {
           
       }];
       
   }
}

-(void)dealloc{

    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
@end
