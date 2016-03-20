//
//  HomeTimeLine.h
//  MyWeibo
//
//  Created by admin on 16/3/18.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeViewController.h"
#import "Statuses.h"
#import "User.h"

@interface HomeTimeLine : NSObject<HandleReceivedJSONDataDelegate>

@property (weak, nonatomic) id<HandleReceivedJSONDataDelegate> delegate;
/**
 * 消息未读数
 */
@property (assign, nonatomic) int has_unread;
/**
 * 微博对象
 */
//@property (strong, nonatomic) Statuses *statuses;
/**
 * 用户对象
 */
//@property (strong, nonatomic) User *user;

@end
