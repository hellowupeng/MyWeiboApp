//
//  User.m
//  MyWeibo
//
//  Created by admin on 16/3/18.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "User.h"
#import "YYModel.h"

@implementation User

- (User *)userDictConvertModel:(NSDictionary *)userDict {
    User *user = [User yy_modelWithDictionary:userDict];
    return user;
}

#pragma mark - YY model

+(NSArray *)modelPropertyWhitelist {
    return @[@"id", @"screen_name", @"name", @"profile_image_url"];
}

@end
