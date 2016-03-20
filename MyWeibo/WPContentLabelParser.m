//
//  WPContentLabelParser.m
//  MyWeibo
//
//  Created by admin on 16/3/18.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WPContentLabelParser.h"

@implementation WPContentLabelParser

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSMutableDictionary *)setParserDictionary {
    NSMutableDictionary *mapper = [NSMutableDictionary new];
    mapper[@"[爱你]"] = [UIImage imageNamed:@"d_aini.png"];
    
    
    return mapper;
}

@end
