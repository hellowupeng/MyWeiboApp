//
//  WPCurrentUserModel.h
//  MyWeibo
//
//  Created by admin on 16/3/21.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeViewController.h"

@interface WPCurrentUserModel : NSObject
/**
 * 用户UID
 */
@property (nonatomic, assign) int id;
/**
 * 字符串型的用户UID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 * 用户昵称
 */
@property (nonatomic, copy) NSString *screen_name;
/**
 * 友好显示名称
 */
@property (nonatomic, copy) NSString *name;
/**
 * 用户所在省级ID
 */
@property (nonatomic, assign) int province;
/**
 * 用户所在城市ID
 */
@property (nonatomic, assign) int city;
/**
 * 用户个人所在地
 */
@property (nonatomic, copy) NSString *location;
/**
 * 用户个人描述
 */
@property (nonatomic, copy) NSString *wbDescription;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *profile_image_url;

@property (nonatomic, copy) NSString *profile_url;

@property (nonatomic, copy) NSString *domain;

@property (nonatomic, copy) NSString *weihao;

@property (nonatomic, copy) NSString *gender;

@property (nonatomic, assign) int followers_count;

@property (nonatomic, assign) int friends_count;

@property (nonatomic, assign) int statuses_count;

@property (nonatomic, assign) int favourites_count;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, assign) BOOL following;

@property (nonatomic, assign) BOOL allow_all_act_msg;

@property (nonatomic, assign) BOOL geo_enabled;

@property (nonatomic, assign) BOOL verified;

@property (nonatomic, assign) int verified_type; // 暂未支持

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSDictionary *status;

@property (nonatomic, assign) BOOL allow_all_comment;

@property (nonatomic, copy) NSString *avatar_large;

@property (nonatomic, copy) NSString *avatar_hd;

@property (nonatomic, copy) NSString *verified_reason;

@property (nonatomic, assign) BOOL follow_me;

@property (nonatomic, assign) int online_status;

@property (nonatomic, assign) int bi_followers_count;

@property (nonatomic, copy) NSString *lang;
/**
 * 处理收到的用户信息数据
 */
- (NSDictionary *)didReceiveUserInfo:(NSData *)userInfoData;

@end



















