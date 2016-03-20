//
//  NSDate+Extension.m
//  MyWeibo
//
//  Created by admin on 16/3/18.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
/**
 * 判断某个时间是否为今年
 */
- (BOOL)isThisYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获得某个时间的年月日时分秒
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowComponents = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateComponents.year == nowComponents.year;
}
/**
 * 判断某个时间是否为昨天
 */
- (BOOL)isYestoday {
    NSDate *now = [NSDate date];
    
    // date == 2016-03-18 10:05:28 --> 2016-03-18 00:00:00
    // now == 2016-03-19 08:05:10 --> 2016-03-19 00:00:00
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    // 2016-03-18
    NSString *dateStr = [dateFormatter stringFromDate:self];
    // 2016-03-19
    NSString *nowStr = [dateFormatter stringFromDate:now];
    // 2016-03-18 00:00:00
    NSDate *date = [dateFormatter dateFromString:dateStr];
    // 2016-03-19 00:00:00
    now = [dateFormatter dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponents = [calendar components:calendarUnit fromDate:date toDate:now options:0];
    return dateComponents.year == 0 && dateComponents.month == 0 && dateComponents.day == 1;
}
/**
 * 判断某个时间是否为今天
 */
- (BOOL)isToday {
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [dateFormatter stringFromDate:self];
    NSString *nowStr = [dateFormatter stringFromDate:now];
    return [dateStr isEqualToString:nowStr];
}

@end
