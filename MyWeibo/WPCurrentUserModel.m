//
//  WPCurrentUserModel.m
//  MyWeibo
//
//  Created by admin on 16/3/21.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WPCurrentUserModel.h"

@implementation WPCurrentUserModel

#pragma mark - WP handle receive JSON data

- (NSDictionary *)didReceiveUserInfo:(NSData *)userInfoData {
    NSError *error;
    NSDictionary *userInfoDictionary = [NSJSONSerialization JSONObjectWithData:userInfoData options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"解析用户信息数据错误：%@", error.userInfo);
    }
    NSLog(@"当前登录用户信息为：%@", userInfoDictionary);
    return userInfoDictionary;
}

@end
