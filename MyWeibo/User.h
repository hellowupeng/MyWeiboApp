//
//  User.h
//  MyWeibo
//
//  Created by admin on 16/3/18.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
/**
 * 用户UID
 */
@property (assign, nonatomic) int id;
/**
 * 用户昵称
 */
@property (copy, nonatomic) NSString *screen_name;
/**
 * 友好显示昵称
 */
@property (copy, nonatomic) NSString *name;
/**
 * 用户头像地址，50x50px
 */
@property (copy, nonatomic) NSString *profile_image_url;
/**
 * 用户字典转对象
 * @param userDict 具体的用户字典对象
 */
- (User *)userDictConvertModel:(NSDictionary *)userDict;

@end
