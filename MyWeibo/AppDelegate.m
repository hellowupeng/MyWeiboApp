//
//  AppDelegate.m
//  MyWeibo
//
//  Created by admin on 16/3/17.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "AppDelegate.h"
#import "WPLoginViewController.h"
#import "WeiboSDK.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "DiscoverViewController.h"
#import "ProfileViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 注册AppKey
    [WeiboSDK registerApp:kAppKey];
    // 打开调试
    [WeiboSDK enableDebugMode:YES];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.loginViewController = [[WPLoginViewController alloc] init];
    
    self.window.rootViewController = self.loginViewController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Weibo SDK delegate
/**
 * 收到一个来自微博客户端的请求
 * @param request 具体的请求对象
 */
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    
}
/**
 * 收到一个来自微博客户端的响应
 * @param response 具体的响应对象
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if ([response isKindOfClass:WBAuthorizeResponse.class]) {
        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
        self.wbCurrentUserID = [(WBAuthorizeResponse *)response userID];
        self.wbRefreshToken = [(WBAuthorizeResponse *)response refreshToken];
        // 成功授权
        if (self.wbtoken) {
            HomeViewController *homeViewController = [[HomeViewController alloc] init];
            UINavigationController *homeNavgationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
            homeViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"icon_home.png"] selectedImage:[UIImage imageNamed:@"icon_home"]];
            
            
            MessageViewController *messageViewController = [[MessageViewController alloc] init];
            UINavigationController *messageNavigationController = [[UINavigationController alloc] initWithRootViewController:messageViewController];
            messageViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"消息" image:[UIImage imageNamed:@"icon_message.png"] selectedImage:[UIImage imageNamed:@"icon_message.png"]];
            
            DisCoverViewController *discoverViewController = [[DisCoverViewController alloc] init];
            UINavigationController *discoverNavigationController = [[UINavigationController alloc] initWithRootViewController:discoverViewController];
            discoverViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"icon_discover.png"] selectedImage:[UIImage imageNamed:@"icon_discover.png"]];
            
            ProfileViewController *profileViewController = [[ProfileViewController alloc] init];
            UINavigationController *profileNavigationController = [[UINavigationController alloc] initWithRootViewController:profileViewController];
            profileViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"icon_profile.png"] selectedImage:[UIImage imageNamed:@"icon_profile.png"]];
            
            UITabBarController *tabBarController = [[UITabBarController alloc] init];
            tabBarController.viewControllers = @[homeNavgationController, messageNavigationController, discoverNavigationController, profileNavigationController];
            [self.loginViewController presentViewController:tabBarController animated:YES completion:^{
                
            }];
        }
    }else if ([response isKindOfClass:WBSendMessageToWeiboResponse.class]) {
        NSLog(@"WBSendMessageToWeiboResponse");
    }else if ([response isKindOfClass:WBPaymentResponse.class]) {
        NSLog(@"WBPaymentResponse");
    }else if ([response isKindOfClass:WBSDKAppRecommendResponse.class]) {
        NSLog(@"WBSDKAppRecommendResponse");
    }else if ([response isKindOfClass:WBShareMessageToContactResponse.class]) {
        NSLog(@"WBShareMessageToContactResponse");
    }
}

#pragma mark - Override methods

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [WeiboSDK handleOpenURL:url delegate:self];
}

@end
