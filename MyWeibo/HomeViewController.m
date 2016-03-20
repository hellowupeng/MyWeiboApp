//
//  HomeViewController.m
//  MyWeibo
//
//  Created by admin on 16/3/17.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "HomeViewController.h"
#import "WeiboCell.h"
#import "MJRefresh.h"
#import "WeiboSDK.h"
#import "AppDelegate.h"
#import "HomeTimeLine.h"
#import "Statuses.h"
#import "User.h"
#import "YYWebImage.h"
#import "YYText.h"

#define kAppKey         @"2045436852"
#define kRedirectURI    @"http://www.sina.com"

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate, WBHttpRequestDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"用户名";
    
    // 下拉刷新
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
//        // 结束刷新
//        [self.myTableView.mj_header endRefreshing];
//        });
        // 请求home_timeLine数据
        self.extraParams = [NSMutableDictionary dictionary];
        self.extraParams = nil;
//        [self.extraParams setObject:@"1" forKey:@"count"];
        [self requestForOpenAPIWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:self.extraParams withTag:@"home_timeLine"];
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_edit.png"] style:UIBarButtonItemStylePlain target:self action:@selector(editNewWeibo)];
    // 开始下拉刷新请求数据
    [self.myTableView.mj_header beginRefreshing];
}

#pragma mark - Action methods

- (void)editNewWeibo {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"CellID";
    // 干掉了重用机制，但是会增加内存消耗，后面想想更好的解决办法
//    NSString *identifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    // 使用weibo cell nib
    UINib *nib = [UINib nibWithNibName:@"WeiboCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[WeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else {
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview]; // 删除并重新分配
        }
    }
    
    [cell setThePropertyOfContentLabel];
    [cell setPropertyOfRetweetLabel];
    
    [cell createNewCellProperty];
    
    // 配置cell
    cell.nameLabel.text = [[self.tableViewData[indexPath.row] userObj] name];
//     加载头像 （想想能不能用上高效的三方框架）？
    NSData *avatarData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[self.tableViewData[indexPath.row] userObj] profile_image_url]]];
    cell.avatarImageView.image = [UIImage imageWithData:avatarData];
//    cell.weiboContentLabel.text = [self.tableViewData[indexPath.row] text];
    cell.attitudes_countLabel.text = [[NSNumber numberWithInt:[self.tableViewData[indexPath.row] attitudes_count]] stringValue];
    cell.comments_countLabel.text = [[NSNumber numberWithInt:[self.tableViewData[indexPath.row] comments_count]] stringValue];
    cell.reposts_countLabel.text = [[NSNumber numberWithInt:[self.tableViewData[indexPath.row] reposts_count]] stringValue];
    cell.wbsourceLabel.text = [self.tableViewData[indexPath.row] source];
    cell.wbdateLabel.text = [self.tableViewData[indexPath.row] created_at];
    cell.ContentLabel.text = [self.tableViewData[indexPath.row] text];
    
    // 显示转发的微博的缩略图
    NSArray *retweetPicArray = [self.tableViewData[indexPath.row] retweetDictionary][@"pic_urls"];
    
    // 显示转发的微博
    if ([self.tableViewData[indexPath.row] retweetDictionary]) {
        NSString *retweetUser = [self.tableViewData[indexPath.row] retweetDictionary][@"user"][@"name"];
        
        NSString *at_string = @"@";
        if (retweetUser) {
            retweetUser = [at_string stringByAppendingString:retweetUser];
            
            NSString *retweet_s = [retweetUser stringByAppendingString:@":"];
            cell.retweetLabel.text = [retweet_s stringByAppendingString:[self.tableViewData[indexPath.row] retweetDictionary][@"text"]];
        }else {
           cell.retweetLabel.text = [self.tableViewData[indexPath.row] retweetDictionary][@"text"];
        }
        [cell setHeightOfLabel:cell.retweetLabel];
//        NSLog(@"原微博内容: %@", [self.tableViewData[indexPath.row] retweetDictionary][@"text"]);
        
        if (retweetPicArray.count < 4) { // 少于4张图
            for (int i = 0; i < retweetPicArray.count; i++) {
                [cell setThePropertyOfThumbnailImageWithI:i andJ:0 withAligmentLabel:cell.retweetLabel withTag:0];
                cell.thumbnail_picImageView.yy_imageURL = [NSURL URLWithString:retweetPicArray[i][@"thumbnail_pic"]];
                
                // 添加工具栏
                if (i == 0) {
                    [cell setPropertyOfBottomBarWithImageView:cell.thumbnail_picImageView];
                }
            }
        }else { // 大于3张图
            // 判断行数
            int row = 0;
            if (retweetPicArray.count/3.0 <= 2.0) {
                row = 2;
            }else {
                row = 3;
            }
            
            int tag = 0;
            
            // 创建图片控件
            for (int j = 0; j < row; j++) {
                for (int i = 0; i < 3; i++) {
                    [cell setThePropertyOfThumbnailImageWithI:i andJ:j withAligmentLabel:cell.retweetLabel withTag:tag];
                    tag++;
                    
                    // 计算图片位置
                    int location = 0;
                    if (j == 0 ) {
                        location = i;
                    }else if(j == 1) {
                        location = j + i + 2;
                    }else {
                        location = j + i + 4;
                    }
                    
                    if (location < retweetPicArray.count) {
                        cell.thumbnail_picImageView.image = nil;
                        cell.thumbnail_picImageView.yy_imageURL = [NSURL URLWithString:retweetPicArray[location][@"thumbnail_pic"]];
                    }
                }
                
                // 添加工具栏
                if (row == 2) {
                    for (UIImageView *photos in cell.contentView.subviews) {
                        if (photos.tag == 3) {
                            [cell setPropertyOfBottomBarWithImageView:photos];
                        }
                    }
                }
                if (row == 3) {
                    for (UIImageView *photos in cell.contentView.subviews) {
                        if (photos.tag == 6) {
                            [cell setPropertyOfBottomBarWithImageView:photos];
                        }
                    }
                }
            }
        }
        
    }
    
    // 文本自适应高度
    [cell setHeightOfLabel:cell.ContentLabel];
    
    // 显示缩略图
    NSArray *picArray = [self.tableViewData[indexPath.row] pic_urls];
    
    // 只有原创微博且无图情况
    if (picArray.count == 0 && retweetPicArray.count == 0 && [self.tableViewData[indexPath.row] retweetDictionary][@"text"] == nil) {
        int h = cell.ContentLabel.frame.origin.y + cell.ContentLabel.frame.size.height;
        [cell setPropertyOfBottomBarWithHeight:h];
    }
    
    // 只转发带文字的微博
    if (picArray.count == 0 && retweetPicArray.count == 0 && [self.tableViewData[indexPath.row] retweetDictionary][@"text"] != nil) {
        int h = cell.retweetLabel.frame.origin.y + cell.retweetLabel.frame.size.height;
        [cell setPropertyOfBottomBarWithHeight:h];
    }
    
        if (picArray.count < 4) { // 少于4张图
            for (int i = 0; i < picArray.count; i++) {
                [cell setThePropertyOfThumbnailImageWithI:i andJ:0 withAligmentLabel:cell.ContentLabel withTag:0];
                cell.thumbnail_picImageView.yy_imageURL = [NSURL URLWithString:picArray[i][@"thumbnail_pic"]];
                
                // 添加工具栏
                if (i == 0) {
                    [cell setPropertyOfBottomBarWithImageView:cell.thumbnail_picImageView];
                }
            }
        }else { // 大于3张图
            // 判断行数
            int row = 0;
            if (picArray.count/3.0 <= 2.0) {
                row = 2;
            }else {
                row = 3;
            }
            // 创建图片控件
            int tag = 0;
            for (int j = 0; j < row; j++) {
                for (int i = 0; i < 3; i++) {
                    [cell setThePropertyOfThumbnailImageWithI:i andJ:j withAligmentLabel:cell.ContentLabel withTag:tag];
                    tag++;
                    
                    // 计算图片位置
                    int location = 0;
                    if (j == 0 ) {
                        location = i;
                    }else if(j == 1) {
                        location = j + i + 2;
                    }else {
                        location = j + i + 4;
                    }
                    
                    if (location < picArray.count) {
//                        cell.thumbnail_picImageView.image = nil;
                        cell.thumbnail_picImageView.yy_imageURL = [NSURL URLWithString:picArray[location][@"thumbnail_pic"]];
                    }
                }
            }
            
            // 添加工具栏
            if (row == 2) {
                for (UIImageView *photos in cell.contentView.subviews) {
                    if (photos.tag == 3) {
                            [cell setPropertyOfBottomBarWithImageView:photos];
                    }
                }
            }
            if (row == 3) {
                for (UIImageView *photos in cell.contentView.subviews) {
                    if (photos.tag == 6) {
                        [cell setPropertyOfBottomBarWithImageView:photos];
                    }
                }
            }
        }
    
    self.CellToolBar = cell.bottombar;
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 计算cell的高度
    return self.CellToolBar.frame.origin.y + self.CellToolBar.frame.size.height;
}

#pragma mark - Http request methods

- (void)requestForOpenAPIWithURL:(NSString *)url params:(NSDictionary *)extraParams withTag:(NSString *)tag {
    [WBHttpRequest requestWithAccessToken:self.myDelegate.wbtoken url:url httpMethod:@"GET" params:extraParams delegate:self withTag:tag];
}

#pragma mark - WB http request delegate

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"请求失败：%@", error.userInfo);
}

- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"收到微博请求响应");
}

- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data {
    if ([request.tag isEqualToString:@"home_timeLine"]) {
//        WBStatus *status = [[WBStatus alloc] init];
//        [status didReceiveData:data];
        HomeTimeLine *homeTimeLine = [[HomeTimeLine alloc] init];
       self.tableViewData = [homeTimeLine didReceiveData:data];
    }
    [self.myTableView.mj_header endRefreshing];
    [self.myTableView reloadData];
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
