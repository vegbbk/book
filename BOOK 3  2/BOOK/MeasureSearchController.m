//
//  MeasureSearchController.m
//  BOOK
//
//  Created by wangyang on 16/4/5.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "MeasureSearchController.h"
#import "BooKFavTableViewCell.h"
#import "DirectoryModel.h"
#import "magazineTool.h"
#import "releaseDetailController.h"

@interface MeasureSearchController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    UITextField *searchtext;
    UIButton *cancelBtn;
    UITableView *tabview;
    NSMutableArray *dataSouce;
    UILabel * label11;
}

@end

@implementation MeasureSearchController
-(void)viewWillDisappear:(BOOL)animated{
 [cancelBtn removeFromSuperview];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.translucent=NO;
    self.view.backgroundColor = [UIColor whiteColor];
    dataSouce=[NSMutableArray array];
//    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"返回"] highImage:[UIImage imageNamed:@"返回"] target:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.size.width-110, 30)];
    backView.layer.borderColor=[[UIColor grayColor]CGColor];
    backView.layer.borderWidth=0.5;
    backView.layer.cornerRadius = 8;
    label11 = [[UILabel alloc]initWithFrame:CGRectMake(26, 0, self.view.size.width-110-28, 30)];
    label11.textColor = [UIColor blackColor];
    label11.userInteractionEnabled = YES;
    label11.font = [UIFont systemFontOfSize:12.0];
    [backView addSubview:label11];

    
    searchtext = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.view.size.width-102, 30)];
    searchtext.backgroundColor = [UIColor clearColor];
    //    searchtext
    //searchtext.layer.borderColor=[[UIColor grayColor]CGColor];
    //searchtext.layer.borderWidth=0.5;
    UIImageView *leftView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 15, 15)];
    leftView.image=[UIImage imageNamed:@"搜索"];
    [searchtext addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    searchtext.leftView=leftView;
    
    searchtext.placeholder = NSLocalizedString(@"Please enter the keywords", @"Please enter the keywords");
    searchtext.font = [UIFont systemFontOfSize:12.0];
    searchtext.returnKeyType = UIReturnKeyGo;
    searchtext.delegate = self;
    searchtext.textColor = [UIColor clearColor];
    searchtext.clearButtonMode = UITextFieldViewModeAlways;
    [backView addSubview:searchtext];
    self.navigationItem.titleView=backView;
    
    cancelBtn= [[UIButton alloc] initWithFrame:CGRectMake(self.navigationController.view.size.width-50, 27, 50, 30)];
    cancelBtn.backgroundColor = [UIColor clearColor];
    [cancelBtn setTitle:NSLocalizedString(@"Search", @"Search") forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(Searcharticle) forControlEvents:UIControlEventTouchUpInside];
    
    cancelBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [self.navigationController.view addSubview:cancelBtn];
    
    
    tabview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CZScreenW, self.view.height)];
    tabview.delegate = self;
    tabview.dataSource=self;
    tabview.separatorStyle=UITableViewCellSeparatorStyleNone;
    
     tabview.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:tabview];
    
}
-(void)textFieldDidChange :(UITextField *)theTextField{
    
    if (theTextField==searchtext) {
        
        label11.text = theTextField.text;
    }
    
}


- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x +10, bounds.origin.y, bounds.size.width-250, bounds.size.height);
    return inset;
    //return CGRectInset(bounds,50,0);
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
        [tabview reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)back{

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DirectoryModel *model=dataSouce[indexPath.row];
    releaseDetailController *detail=[[releaseDetailController alloc]init];
    
    detail.postId=model.post_id;
    detail.ID=model.ID;
    detail.typeSearch=@"Search";
    
    //    detail.hidesBottomBarWhenPushed=YES;
    [searchtext resignFirstResponder];
    [cancelBtn removeFromSuperview];
    [searchtext removeFromSuperview];
    
    detail.navigationItem.title=NSLocalizedString(@"Assessment details", @"Assessment details");
    [self.navigationController pushViewController:detail animated:YES];
}

@end
