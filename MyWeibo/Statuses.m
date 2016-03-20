//
//  Statuses.m
//  MyWeibo
//
//  Created by admin on 16/3/18.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "Statuses.h"
#import "YYModel.h"
#import "NSDate+Extension.h"

@implementation Statuses
/**
 * 处理获取的全部微博
 * @param statuses 包含所有微博信息的数组
 * @return 包含多个微博对象的数组
 */
- (NSArray *)handleAllStatuses:(NSArray *)statusesArray {
    self.allStatuses = [NSMutableArray array];
//    NSLog(@"微博数组：%@", statusesArray);
    for (int i = 0; i < statusesArray.count; i++) {
        // 把每条信息转化成一个对象
        Statuses *statusesObj = [Statuses yy_modelWithDictionary:statusesArray[i]];
        
        // 设置user属性
        User *userModel = [[User alloc] init];
        statusesObj.userObj = [userModel userDictConvertModel:statusesArray[i][@"user"]];
        
        // 获取转发内容
        if (statusesArray[i][@"retweeted_status"]) {
            statusesObj.retweetDictionary = [[NSMutableDictionary alloc] init];
            statusesObj.retweetDictionary = statusesArray[i][@"retweeted_status"];
        }
//        NSLog(@"转发微博信息：%@", statusesArray[i][@"retweeted_status"]);
        NSLog(@"转发微博信息：%@", statusesObj.retweetDictionary);
        
        // 获取图片缩略图片地址
        statusesObj.pic_urls = [[NSMutableArray alloc] init];
        statusesObj.pic_urls = statusesArray[i][@"pic_urls"];
//        NSLog(@"图片数组：%@", statusesObj.pic_urls);
        
        // 设置created_at属性格式
        statusesObj.created_at = [self setPropertyOfCreatedAt:statusesObj.created_at];
        
        // 设置source属性格式
//        statusesObj.source = [self setPropertyOfSource:statusesObj.source];
//        NSLog(@"来源：%@", statusesObj.source);
        
        [self.allStatuses addObject:statusesObj];
    }
    return self.allStatuses;
}

#pragma mark - YY model

+(NSArray *)modelPropertyWhitelist {
    return @[@"attitudes_count", @"comments_count", @"created_at", @"reposts_count", @"source", @"text"];
}

#pragma mark - Set the property

- (NSString *)setPropertyOfSource:(NSString *)source {
    // 正则表达式 NSRegularExpression
    // 截串 NSString
    if (source) {
        NSRange range;
        range.location = [source rangeOfString:@">"].location + 1;
        range.length = [source rangeOfString:@"</"].location - range.location;
        return [NSString stringWithFormat:@"来自%@", [source substringWithRange:range]];
    }else {
        return @"来自其他";
    }
}

- (NSString *)setPropertyOfCreatedAt:(NSString *)createdAt {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // NSLocale
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_us"];
    // E: 星期几
    // M: 月份
    // d: 日期
    // H: 24小时制的小时
    // m: 分钟
    // s: 秒
    // y: 年
    dateFormatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createdDate = [dateFormatter dateFromString:createdAt];
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 计算两个日期之间的差值
    NSDateComponents *dateComponents = [calendar components:calendarUnit fromDate:createdDate toDate:now options:0];
    if ([createdDate isThisYear])
    { // 今年
        if ([createdDate isYestoday])
        { // 昨天
            dateFormatter.dateFormat = @"昨天HH:mm";
            return [dateFormatter stringFromDate:createdDate];
        }else if ([createdDate isToday])
        { // 今天
            if (dateComponents.hour >= 1)
            {
                return [NSString stringWithFormat:@"%ld小时前", dateComponents.hour];
            }else if (dateComponents.minute >= 1)
            {
                return [NSString stringWithFormat:@"%ld分钟前", dateComponents.minute];
            }else
            {
                return @"刚刚";
            }
        }else
        { // 今年的其他日子
            dateFormatter.dateFormat = @"MM-dd";
            return [dateFormatter stringFromDate:createdDate];
        }
    }
    // 非今年
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    return [dateFormatter stringFromDate:createdDate];
}

@end
