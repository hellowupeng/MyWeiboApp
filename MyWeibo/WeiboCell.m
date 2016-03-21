//
//  WeiboCell.m
//  MyWeibo
//
//  Created by admin on 16/3/17.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "WeiboCell.h"
#import "WPContentLabelParser.h"

@implementation WeiboCell

- (void)awakeFromNib {
    // Initialization code
    
    [self setThePropertyOfContentLabel];
    [self setPropertyOfRetweetLabel];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPropertyOfRetweetLabel {
    // 转发微博文本
    self.retweetLabel = [[YYLabel alloc] init];
    self.retweetLabel.frame = CGRectMake(17, self.ContentLabel.frame.origin.y + self.ContentLabel.frame.size.height + 10, 290, 111);
    self.retweetLabel.frame = CGRectMake(17, 90, 290, 111);
    self.retweetLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.retweetLabel];
    
    // 头像
    self.avatarImageView = [[UIImageView alloc] init];
    self.avatarImageView.frame = CGRectMake(10, 15, 50, 50);
    // 圆形头像（不高效）
    self.avatarImageView.layer.cornerRadius = 25;
    self.avatarImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.avatarImageView];
    
    // 来源
    self.wbsourceLabel = [UILabel new];
    self.wbsourceLabel.frame = CGRectMake(74, 44, 163, 21);
    self.wbsourceLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.wbsourceLabel];
    
    // 创建日期
    self.wbdateLabel = [UILabel new];
    self.wbdateLabel.frame = CGRectMake(209, 15, 98, 21);
    self.wbdateLabel.font = [UIFont systemFontOfSize:12];
    self.wbdateLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.wbdateLabel];
}
/**
 * 设置微博内容
 */
- (void)setThePropertyOfContentLabel {
    self.ContentLabel = [[YYLabel alloc] init];
    self.ContentLabel.frame = CGRectMake(17, 70, 290, 111);
    self.ContentLabel.font = [UIFont systemFontOfSize:15];
    self.ContentLabel.text = @"大家好";
    
    // 文本解析
    YYTextSimpleEmoticonParser *parser = [YYTextSimpleEmoticonParser new];
    WPContentLabelParser *contentLabelParser = [[WPContentLabelParser alloc] init];
    parser.emoticonMapper = [contentLabelParser setParserDictionary];
    self.ContentLabel.textParser = parser;
    
    [self.contentView addSubview:self.ContentLabel];
}
/**
 * 自适应label高度
 * @param label 具体的label对象
 */
- (void)setHeightOfLabel:(YYLabel *)label {
    // 自动折行设置
    label.lineBreakMode = UILineBreakModeWordWrap;
    label.numberOfLines = 0;
    //自适应高度
    CGRect txtFrame = label.frame;
    
    label.frame = CGRectMake(txtFrame.origin.x, txtFrame.origin.y, txtFrame.size.width,
                             txtFrame.size.height =[label.text boundingRectWithSize:
                                                    CGSizeMake(txtFrame.size.width, CGFLOAT_MAX)
                                                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                         attributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName, nil] context:nil].size.height);
    label.frame = CGRectMake(txtFrame.origin.x, txtFrame.origin.y, txtFrame.size.width, txtFrame.size.height);
}

- (void)setHeightOfButton:(CGFloat)y height:(CGFloat)h {
    self.reposts_countLabel.frame = CGRectMake(self.reposts_countLabel.frame.origin.x, y + h + 10, self.reposts_countLabel.frame.size.width, self.reposts_countLabel.frame.size.height);
    self.attitudes_countLabel.frame = CGRectMake(self.attitudes_countLabel.frame.origin.x, y + h + 10, self.attitudes_countLabel.frame.size.width, self.attitudes_countLabel.frame.size.height);
    self.comments_countLabel.frame = CGRectMake(self.comments_countLabel.frame.origin.x, y + h + 10, self.comments_countLabel.frame.size.width, self.comments_countLabel.frame.size.height);
}
/**
 * 创建cell所需显示的对象
 */
-(void)createNewCellProperty {
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.frame = CGRectMake(74, 15, 171, 21);
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    
    [self.contentView addSubview:self.nameLabel];
}
/**
 * 计算每条微博的高度
 * @return 具体的高度
 */
//- (CGFloat)setHeightForRowInCell {
//    
//}
/**
 * 配置缩略图的显示
 * @param i 图片在数组中的位置
 */
- (void)setThePropertyOfThumbnailImageWithI:(int)i andJ:(int)j withAligmentLabel:(YYLabel *)label withTag:(int)tag{
    self.thumbnail_picImageView = [[UIImageView alloc] init];
    self.thumbnail_picImageView.tag = tag;
    // 设置imageview缩放mode
    self.thumbnail_picImageView.contentMode = UIViewContentModeScaleAspectFill;
    // 超出边框的内容都剪掉
    self.thumbnail_picImageView.clipsToBounds = YES;
    
    // 动态设置 imageview 的 frame
    CGFloat h = label.frame.size.height + label.frame.origin.y + 8;
    
    self.thumbnail_picImageView.frame = CGRectMake(10 + 100 * i, h + 100 * j, 95, 95);
    [self.contentView addSubview:self.thumbnail_picImageView];
}
/**
 * 设置工具条
 */
- (void)setPropertyOfBottomBarWithImageView:(UIImageView *)WeiboImageView {
    self.bottombar = [UIToolbar new];
    self.bottombar.frame = CGRectMake(0, WeiboImageView.frame.origin.y + 95 + 10, 320, 30);
    self.bottombar.backgroundColor = [UIColor whiteColor];
    
    // 转发
    UIBarButtonItem *repostItem = [[UIBarButtonItem alloc] initWithTitle:@"转发" style:UIBarButtonItemStylePlain target:self action:@selector(repostWeibo)];
    repostItem.tintColor = [UIColor grayColor];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    // 评论
    UIBarButtonItem *commentItem = [[UIBarButtonItem alloc] initWithTitle:@"评论" style:UIBarButtonItemStylePlain target:self action:@selector(commentWeibo)];
    commentItem.tintColor = [UIColor grayColor];
    
    // 点赞
    UIBarButtonItem *attitudeItem = [[UIBarButtonItem alloc] initWithTitle:@"点赞" style:UIBarButtonItemStylePlain target:self action:@selector(attitudeWeibo)];
    attitudeItem.tintColor = [UIColor grayColor];
    
    self.bottombar.items = @[repostItem, spaceItem, commentItem, spaceItem, attitudeItem];
    [self.contentView addSubview:self.bottombar];
}

/**
 * 设置无图时的工具条
 */
- (void)setPropertyOfBottomBarWithHeight:(int)h {
    self.bottombar = [UIToolbar new];
    self.bottombar.frame = CGRectMake(0, h + 10, 320, 30);
    self.bottombar.backgroundColor = [UIColor whiteColor];
    
    // 转发
    UIBarButtonItem *repostItem = [[UIBarButtonItem alloc] initWithTitle:@"转发" style:UIBarButtonItemStylePlain target:self action:@selector(repostWeibo)];
    repostItem.tintColor = [UIColor grayColor];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    // 评论
    UIBarButtonItem *commentItem = [[UIBarButtonItem alloc] initWithTitle:@"评论" style:UIBarButtonItemStylePlain target:self action:@selector(commentWeibo)];
    commentItem.tintColor = [UIColor grayColor];
    
    // 点赞
    UIBarButtonItem *attitudeItem = [[UIBarButtonItem alloc] initWithTitle:@"点赞" style:UIBarButtonItemStylePlain target:self action:@selector(attitudeWeibo)];
    attitudeItem.tintColor = [UIColor grayColor];
    
    self.bottombar.items = @[repostItem, spaceItem, commentItem, spaceItem, attitudeItem];
    [self.contentView addSubview:self.bottombar];
}

@end


