//
//  detailCollocViewController.m
//  BOOK
//
//  Created by liujianji on 17/3/21.
//  Copyright © 2017年 liujianji. All rights reserved.
//

#import "detailCollocViewController.h"
#import "bookInfoCommentLJJTableViewCell.h"
#import "magazineTool.h"
@interface detailCollocViewController ()<UITableViewDataSource,UITableViewDelegate>{

    UILabel *notilabel;
}
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * dataArr;
@end

@implementation detailCollocViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:18],NSFontAttributeName,nil]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _dataArr = [NSMutableArray array];
    
    
    self.title = NSLocalizedString(@"Comment details", @"Comment details");
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"返回"] highImage:[UIImage imageNamed:@"返回"] target:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];

    
     _dataArr = [NSMutableArray array];
    [self createTable];
    notilabel = [[UILabel alloc]init];
    notilabel.frame = CGRectMake(0, CZScreenH/2.0-100, CZScreenW, 20);
    notilabel.text = @"暂无评论列表,快去评论吧";
    notilabel.textColor = [UIColor lightGrayColor];
    notilabel.textAlignment = NSTextAlignmentCenter;
    notilabel.hidden = YES;
    notilabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:notilabel];

    [self loadCommentsList];
    
    
    // Do any additional setup after loading the view.
}
//返回
-(void)backHome{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)loadCommentsList{
    
    [magazineTool magazineCommentsList:self.postIDStr andsuccess:^(id arr) {
        
        _dataArr = [NSMutableArray arrayWithArray:arr];
        if(_dataArr.count>0){
            
            notilabel.hidden = YES;
        }else{
        
            notilabel.hidden = NO;
        }
        [self.tableView reloadData];
    } failure:^(NSError * error) {
        
    }];
    
}

#pragma mark ---------------------创建视图---------------------------------
- (void)createTable{
   
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CZScreenW, CZScreenH-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //  self.tableView.emptyDataSetSource = self;
    //  self.tableView.emptyDataSetDelegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"bookInfoCommentLJJTableViewCell" bundle:nil] forCellReuseIdentifier:@"infoLJJcell"];
    [self.view addSubview:self.tableView];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1f;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.1f;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _dataArr.count;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    bookInfoCommentLJJTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"infoLJJcell" forIndexPath:indexPath];
    if (_dataArr.count>indexPath.row) {
        bookInfoCommentsModel * model = _dataArr[indexPath.section];
        [cell loadDataWith:model];
    }
       return cell;
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
