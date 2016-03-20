//
//  WPLoginViewController.m
//  MyWeibo
//
//  Created by admin on 16/3/17.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WPLoginViewController.h"
#import "WeiboSDK.h"

#define kAppKey         @"2045436852"
#define kRedirectURI    @"http://www.sina.com"

@interface WPLoginViewController ()

@end

@implementation WPLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action methods

/**
 * 微博登陆授权
 * @param sender 点击事件
 */
- (IBAction)loginWeibo:(id)sender {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From" : @"WPLoginViewController",
                         @"Other_Info_1" : [NSNumber numberWithInt:123],
                         @"Other_Info_2" : @[@"obj1" , @"obj2"],
                         @"Other_Info_3" : @{@"key1" : @"obj1", @"key2" : @"obj2"}};
    [WeiboSDK sendRequest:request];
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
