//
//  AppDelegate.h
//  MyWeibo
//
//  Created by admin on 16/3/17.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"

#define kAppKey         @"2045436852"
#define kRedirectURI    @"http://www.sina.com"

@class WPLoginViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, WeiboSDKDelegate>

@property (strong, nonatomic) UIWindow *window;
/**
 * 认证口令
 */
@property (copy, nonatomic) NSString *wbtoken;
/**
 * 用户ID
 */
@property (copy, nonatomic) NSString *wbCurrentUserID;
/**
 * 当认证口令过期时用于换取认证口令的更新口令
 */
@property (copy, nonatomic) NSString *wbRefreshToken;

@property (strong, nonatomic) WPLoginViewController *loginViewController;

@end

