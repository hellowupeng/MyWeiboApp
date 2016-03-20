//
//  NSDate+Extension.h
//  MyWeibo
//
//  Created by admin on 16/3/18.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
/**
 * 判断某个时间是否为今年
 */
- (BOOL)isThisYear;
/**
 * 判断某个时间是否为昨天
 */
- (BOOL)isYestoday;
/**
 * 判断某个时间是否为今天
 */
- (BOOL)isToday;

@end
