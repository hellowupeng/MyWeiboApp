//
//  Statuses.h
//  MyWeibo
//
//  Created by admin on 16/3/18.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
/**
 * 微博类
 */
@interface Statuses : NSObject
/**
 * 表态数
 */
@property (assign, nonatomic) int attitudes_count;
/**
 * 评论数
 */
@property (assign, nonatomic) int comments_count;
/**
 * 微博创建时间
 */
@property (strong, nonatomic) NSString *created_at;
/**
 * 转发数
 */
@property (assign, nonatomic) int reposts_count;
/**
 * 微博来源
 */
@property (copy, nonatomic) NSString *source;
/**
 * 微博信息内容
 */
@property (copy, nonatomic) NSString *text;
/**
 * 用户对象
 */
@property (strong, nonatomic) User *userObj;
/**
 * 转发微博内容字典
 */
@property (strong, nonatomic) NSMutableDictionary *retweetDictionary;
/**
 * 包含所有微博信息的数组
 */
@property (strong, nonatomic) NSMutableArray *allStatuses;
/**
 * 缩略图片地址
 */
@property (strong, nonatomic) NSMutableArray *pic_urls;
/**
 * 处理获取的全部微博
 * @param statuses 具体的数组对象
 */
- (NSArray *)handleAllStatuses:(NSArray *)statuses;

@end

