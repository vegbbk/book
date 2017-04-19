//
//  DownBookController.m
//  BOOK
//
//  Created by wangyang on 16/6/21.
//  Copyright © 2016年 liujianji. All rights reserved.
//

#import "DownBookController.h"
#import "DownLoadBookCell.h"
#import "ZFDownloadManager.h"
#import "PDFDownloadedCell.h"
#import "PDFDownloadingCell.h"
#import "ReaderDocument.h"
#import "ReaderViewController.h"
@interface DownBookController ()<ZFDownloadDelegate,ReaderViewControllerDelegate>
@property (atomic, strong) NSMutableArray *downloadObjectArr;
@end

@implementation DownBookController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationItem.title=NSLocalizedString(@"My download", @"My download");

    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"返回"] highImage:[UIImage imageNamed:@"返回"] target:self action:@selector(BackHome) forControlEvents:UIControlEventTouchUpInside];

}
-(void)BackHome{
    [self.navigationController popViewControllerAnimated:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    if (_downloadObjectArr==nil) {
        _downloadObjectArr=[NSMutableArray array];
        
    }
  [self initData];
}
- (void)initData
{
    NSMutableArray *downladed = [ZFDownloadManager sharedInstance].downloadedArray;
    NSMutableArray *downloading = [ZFDownloadManager sharedInstance].downloadingArray;
  
    [_downloadObjectArr addObject:downladed];
    [_downloadObjectArr addObject:downloading];
    
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}
- (void)downloadResponse:(ZFSessionModel *)sessionModel
{
    if (self.downloadObjectArr) {
        // 取到对应的cell上的model
        NSArray *downloadings = self.downloadObjectArr[1];
        if ([downloadings containsObject:sessionModel]) {
            
            NSInteger index = [downloadings indexOfObject:sessionModel];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:1];
            __block PDFDownloadingCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            __weak typeof(self) weakSelf = self;
            sessionModel.progressBlock = ^(CGFloat progress, NSString *speed, NSString *remainingTime, NSString *writtenSize, NSString *totalSize) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.progressLabel.text   = [NSString stringWithFormat:@"%@/%@ ",writtenSize,totalSize];
                    cell.speedLabel.text      = speed;
                    cell.progress.progress    = progress;
                    cell.downloadBtn.selected = YES;
                     cell.speedLabel.hidden = NO;
                });
            };
            
            sessionModel.stateBlock = ^(DownloadState state){
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 更新数据源
                    if (state == DownloadStateCompleted) {
                        [weakSelf initData];
                        cell.downloadBtn.selected = YES;
                         cell.speedLabel.hidden = NO;
                    }
                    // 暂停
                    if (state == DownloadStateSuspended) {
                        cell.speedLabel.hidden = YES;
                        cell.downloadBtn.selected = NO;
                    }
                });
            };
        }
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    NSArray *sectionArray = self.downloadObjectArr[section];
    return sectionArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   __block ZFSessionModel *downloadObject = self.downloadObjectArr[indexPath.section][indexPath.row];
    if (indexPath.section==0) {
        PDFDownloadedCell *cell=[PDFDownloadedCell CellWithTableView:tableView];
        cell.SessionModel = downloadObject;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.section==1){
        
        PDFDownloadingCell *cell=[PDFDownloadingCell CellWithTableView:tableView];
        cell.sessionModel=downloadObject;
        [ZFDownloadManager sharedInstance].delegate = self;
        cell.downloadBlock=^(UIButton *sender){
            [[ZFDownloadManager sharedInstance]download:downloadObject.url andBookName:downloadObject.bookName andImage:downloadObject.image progress:^(CGFloat progress, NSString *speed, NSString *remainingTime, NSString *writtenSize, NSString *totalSize) {
                
            } state:^(DownloadState state) {
                
            }];
            
        };
         cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
          __block ZFSessionModel *downloadObject = self.downloadObjectArr[indexPath.section][indexPath.row];
//        NSString *imagePath=  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0]stringByAppendingPathComponent:downloadObject.fileName]  ;
     NSString *imagePath=   [ZFCachesDirectory stringByAppendingPathComponent:downloadObject.fileName];
        
        NSLog(@"%@",ZFCachesDirectory);
        
        NSString *phrase = nil;
        
//        NSString *imagePath=[path stringByAppendingPathComponent:urlstr];
        
        
        ReaderDocument *document = [ReaderDocument withDocumentFilePath:imagePath password:phrase];
        
        
        if (document != nil) // Must have a valid ReaderDocument object in order to proceed with things
        {
            ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
            
            readerViewController.delegate = self; // Set the ReaderViewController delegate to self
            
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
            
            
            
            [self.navigationController pushViewController:readerViewController animated:YES];
            
            
#else // present in a modal view controller
            
            readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
            
            [self presentViewController:readerViewController animated:YES completion:NULL];
            
#endif // DEMO_VIEW_CONTROLLER_PUSH
        }
        else // Log an error so that we know that something went wrong
        {
            //        NSLog(@"%s [ReaderDocument withDocumentFilePath:'%@' password:'%@'] failed.", __FUNCTION__, filePath, phrase);
        }

    }
}
- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
    
    [self.navigationController popViewControllerAnimated:YES];
    
#else // dismiss the modal view controller
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
#endif // DEMO_VIEW_CONTROLLER_PUSH
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return NSLocalizedString(@"delete", @"delete");
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *downloadArray = _downloadObjectArr[indexPath.section];
    ZFSessionModel * downloadObject = downloadArray[indexPath.row];
    
    // 根据url删除该条数据
    [[ZFDownloadManager sharedInstance] deleteFile:downloadObject.url];
    [downloadArray removeObject:downloadObject];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
}

-(void)dealloc{

    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @[NSLocalizedString(@"The download is complete", @"The download is complete"),NSLocalizedString(@"In the download", @"In the download")][section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
    
}
@end
