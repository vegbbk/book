//
//  SearchViewController.m
//  BOOK
//
//  Created by DariusZhu on 16/4/3.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "SearchViewController.h"
#import "BooKFavTableViewCell.h"
#import "DirectoryModel.h"
#import "magazineTool.h"
@interface SearchViewController (){
    UITextField *searchtext;
    UIButton *cancelBtn;
    UITableView *tableview;
    NSMutableArray *dataSouce;
    
}

@end


@implementation SearchViewController
//-(void)viewWillAppear:(BOOL)animated{
//    [self viewWillAppear:YES];
//   
//}
- (void)viewDidLoad {
    [super viewDidLoad];
//     self.navigationController.navigationBar.translucent=NO;
    self.view.backgroundColor = [UIColor whiteColor];
    dataSouce=[NSMutableArray array];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"返回"] highImage:[UIImage imageNamed:@"返回"] target:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    searchtext = [[UITextField alloc] initWithFrame:CGRectMake(40, 28, self.view.size.width-100, 30)];
    searchtext.backgroundColor = [UIColor whiteColor];
//    searchtext
    searchtext.layer.borderColor=[[UIColor grayColor]CGColor];
    searchtext.layer.borderWidth=0.5;
    
    searchtext.layer.cornerRadius = 15;
    searchtext.placeholder = @"请输入你要查询的关键字";
    searchtext.font = [UIFont systemFontOfSize:12.0];
    searchtext.returnKeyType = UIReturnKeyGo;
    searchtext.delegate = self;
    searchtext.clearButtonMode = UITextFieldViewModeAlways;
    [self.navigationController.view addSubview:searchtext];
    
     cancelBtn= [[UIButton alloc] initWithFrame:CGRectMake(self.navigationController.view.size.width-60, 25, 50, 30)];
     cancelBtn.backgroundColor = [UIColor clearColor];
    [cancelBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(Searcharticle) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:cancelBtn];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CZScreenW, self.view.height)];
    tableview.delegate = self;
    tableview.dataSource=self;
    tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    tableview.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
    
    [self.view addSubview:tableview];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSouce.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BooKFavTableViewCell *cell=[BooKFavTableViewCell CellWithTableView:tableView];
   
    DirectoryModel *model=dataSouce[indexPath.row];
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",LOCAL,model.thumb];
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.bookName.text=[NSString stringWithFormat:@"%@",model.title];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    
    return cell;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [searchtext resignFirstResponder];
    //添加搜索的方法
    [self Searcharticle];
    
    return YES;
}
//添加搜索的方法
-(void)Searcharticle{
    [searchtext resignFirstResponder];
    NSString *seatext=searchtext.text;
    [magazineTool Searcharticle:seatext success:^(id responseObject) {
        NSArray *array1=responseObject;
        for (DirectoryModel *model in array1) {
            [dataSouce addObject:model];
            
        }
        [tableview reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
}
-(void)back{
    [searchtext resignFirstResponder];
    [cancelBtn removeFromSuperview];
    [searchtext removeFromSuperview];
//    [self.navigationController dismissModalViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     DirectoryModel *model=dataSouce[indexPath.row];
//    [self.delegate SearChtext:model];
//   
    [[NSNotificationCenter defaultCenter]postNotificationName:@"searchModel" object:self userInfo:@{@"model":model}];
    
    UIViewController *viewCtl = self.navigationController.viewControllers[2];
    [self.navigationController popToViewController:viewCtl animated:YES];
    [searchtext resignFirstResponder];
    [cancelBtn removeFromSuperview];
    [searchtext removeFromSuperview];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [searchtext resignFirstResponder];

}


@end
