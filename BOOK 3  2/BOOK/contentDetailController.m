//
//  contentDetailController.m
//  BOOK
//
//  Created by wangyang on 16/5/19.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "contentDetailController.h"
#import "SearchViewController.h"
#import "magazineTool.h"
#import "DirectoryModel.h"
#import "BBSViewCell.h"
#import "DetailViewController.h"
#import "MeasureSearchController.h"

@interface contentDetailController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,SearchViewControllerDelegate>{
    UITableView *tabView;
    UILabel *Labrecommended;
    UITextField *SearchFiled;
    UIImageView *imgView;
//    NSMutableArray *dataSource;
    NSMutableArray *recommendedArray;
    NSMutableArray *magaArray;
    
}

@end

@implementation contentDetailController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建搜索框
    [self createCollectVeFrame];
    //创建UI
    [self loadUI];
   //加载数据
    self.view.backgroundColor=[UIColor whiteColor];
    
    magaArray=[NSMutableArray array];
    
    [self initData];
     self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"返回"] highImage:[UIImage imageNamed:@"返回"] target:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.title=@"目录详情";
    UISwipeGestureRecognizer   *panright=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SwipeGesture:)];
    panright.direction = UISwipeGestureRecognizerDirectionRight; //向左
    UISwipeGestureRecognizer   *panLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SwipeGesture:)];
    panLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    
    panright.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:panright];
    [self.view addGestureRecognizer:panLeft];
    
    // Do any additional setup after loading the view.
}

//返回上一层
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)SwipeGesture:(UISwipeGestureRecognizer *)swipe{
    //    UISwipeGestureRecognizer *swipe = swipe;
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(swipe.direction==UISwipeGestureRecognizerDirectionLeft){
        DetailViewController *detail=[[DetailViewController alloc]init];
//        detail.term_id=_term_id;
        detail.termAll_id=_termAll_id;
        
        [self.navigationController pushViewController:detail animated:YES];
        
    }else{
    
    }
}
//加载数据
-(void)initData{
    [magazineTool detailAvder:_term_id andsuccess:^(id responseObject) {
        if(![responseObject isEqualToString:@""]){
            NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LOCAL,responseObject]];
//            [imgView sd_setImageWithURL:url];
              [imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeImage"]];
        }

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        
    }];
    [magazineTool MagineDirectryDetail:_term_id success:^(id responseObject) {
        NSArray *array1=responseObject;
        for ( DirectoryModel *model in array1) {
            [magaArray addObject:model];
            
        }
        [tabView reloadData];
        
    } andfailure:^(NSError *error) {
        
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
   //创建搜索框
-(void)createCollectVeFrame{
    UIView *v1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CZScreenW, 50)];
    [self.view addSubview:v1];
    Labrecommended=[[UILabel alloc]initWithFrame:CGRectMake(10, 15, CZScreenW*0.4, 20)];
    Labrecommended.textColor=[UIColor grayColor];
    Labrecommended.font=[UIFont systemFontOfSize:14];
    SearchFiled=[[UITextField alloc]initWithFrame:CGRectMake(CZScreenW*0.38, 10, CZScreenW*0.58, 30)];
//    SearchFiled.leftView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"搜索"]];
    UIImageView *leftView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 15, 15)];
    leftView.image=[UIImage imageNamed:@"搜索"];
    SearchFiled.leftView=leftView;
    //    [searchtext addSubview:leftView];
    SearchFiled.leftViewMode=UITextFieldViewModeAlways;
//    SearchFiled.leftViewMode=UITextFieldViewModeAlways;
    SearchFiled.delegate=self;
    SearchFiled.autocapitalizationType=UITextAutocapitalizationTypeWords;
    SearchFiled.layer.cornerRadius=7;
    SearchFiled.layer.masksToBounds=YES;
    SearchFiled.layer.borderColor=[[UIColor grayColor]CGColor];
    
    SearchFiled.layer.borderWidth=1.0;
    
    Labrecommended.text=@"SEARCH STYLE";
    [v1 addSubview:SearchFiled];
    [v1 addSubview:Labrecommended];
    
}
//创建表哥
-(void)loadUI{
    tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, CZScreenW, CZScreenH-50)];
    tabView.dataSource=self;
    tabView.delegate=self;
    imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CZScreenW,150 )];
    tabView.tableHeaderView=imgView;
//    imgView.backgroundColor=[UIColor redColor];
    tabView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    
    [self.view addSubview:tabView];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField==SearchFiled){
        [textField resignFirstResponder];
        [SearchFiled resignFirstResponder];
        MeasureSearchController *searchview = [[MeasureSearchController alloc] init];
        searchview.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:searchview animated:YES];
        //        [SearchFiled resignFirstResponder];
        
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return magaArray.count ;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DirectoryModel *model=[magaArray objectAtIndex:indexPath.row];
    
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",LOCAL,model.thumb];
    //设置类容
    NSLog(@"%@",urlstr);
    
    
    BBSViewCell *cell=[BBSViewCell CellWithTableView:tableView];
    
//    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:urlstr]];
   [cell.imgView sd_setImageWithURL:[NSURL URLWithString:urlstr] placeholderImage:[UIImage imageNamed:@"placeImage"]];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.lblTitle.text=[NSString stringWithFormat:@"%@",model.title];
    cell.lblbrowse.text=[NSString stringWithFormat:@"%@",model.post_date];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CZScreenW, 100)];
    view.backgroundColor=[UIColor grayColor];
    cell.selectedBackgroundView=view;
    
    cell.lblReplies.text=[NSString stringWithFormat:@" 回复次数:%@",model.comment];
    
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detail=[[DetailViewController alloc]init];
    detail.term_id=_term_id;
    detail.magaArray=magaArray;
    detail.page=indexPath.row;
    
    [self.navigationController pushViewController:detail animated:YES];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
    
}
@end
