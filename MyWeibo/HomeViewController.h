//
//  HomeViewController.h
//  MyWeibo
//
//  Created by admin on 16/3/17.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;
/**
 * 接收并处理来自微博响应的JSON数据
 */
@protocol HandleReceivedJSONDataDelegate <NSObject>

/**
 * 处理微博响应的数据
 * @param data 具体的数据对象
 */
- (NSArray *)didReceiveData:(NSData *)data;

@end

@interface HomeViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *myTableView;
/**
 * 请求参数
 */
@property (strong, nonatomic) NSMutableDictionary *extraParams;

@property (strong, nonatomic) AppDelegate *myDelegate;
/**
 * 表视图所需的数组数据
 */
@property (copy, nonatomic) NSArray *tableViewData;
/**
 * 工具栏
 */
@property (strong, nonatomic) UIToolbar *CellToolBar;

@end
