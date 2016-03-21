//
//  HomeTimeLine.m
//  MyWeibo
//
//  Created by admin on 16/3/18.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "HomeTimeLine.h"
#import <YYModel/YYModel.h>
#import "HomeViewController.h"

@implementation HomeTimeLine

#pragma mark - Handle receive JSON data delegate

- (NSArray *)didReceiveData:(NSData *)Jsondata {
    // 解析json
    NSError *error = nil;
    NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:Jsondata options:NSJSONReadingMutableContainers error:&error];
//    NSLog(@"收到微博的home_timeLine数据：%@", result);
    
    // 暂时没有用
    HomeTimeLine *homeTimeline = [HomeTimeLine yy_modelWithDictionary:result];
    NSLog(@"has unread: %d", homeTimeline.has_unread);
    
    Statuses *statues = [[Statuses alloc] init];
    NSArray *allStatuses = [statues handleAllStatuses:result[@"statuses"]];
    
    return allStatuses;
}

#pragma mark - YY model
/**
 * // 如果实现了该方法，则处理过程中不会处理该列表外的属性
 * @return 具体的白名单数组对象
 */
+(NSArray *)modelPropertyWhitelist {
    return @[@"has_unread", @"statuses"];
}

@end
