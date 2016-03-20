//
//  WeiboCell.h
//  MyWeibo
//
//  Created by admin on 16/3/17.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYText/YYText.h>

@interface WeiboCell : UITableViewCell
/**
 * 头像
 */
@property (strong, nonatomic) UIImageView *avatarImageView;
/**
 * 用户名
 */
@property (strong, nonatomic) UILabel *nameLabel;
/**
 * 微博内容 (弃用)
 */
@property (strong, nonatomic) IBOutlet UILabel *weiboContentLabel;
/**
 * 赞
 */
@property (strong, nonatomic) IBOutlet UILabel *attitudes_countLabel;
/**
 * 评论
 */
@property (strong, nonatomic) UILabel *comments_countLabel;
/**
 * 转发
 */
@property (strong, nonatomic) IBOutlet UILabel *reposts_countLabel;
/**
 * 微博来源
 */
@property (strong, nonatomic) UILabel *wbsourceLabel;
/**
 * 时间
 */
@property (strong, nonatomic) UILabel *wbdateLabel;
/**
 * yylabel 微博内容
 */
@property (strong, nonatomic) YYLabel *ContentLabel;
/**
 * 转发的原微博内容
 */
@property (strong, nonatomic) YYLabel *retweetLabel;
/**
 * 缩略图
 */
@property (strong, nonatomic) UIImageView *thumbnail_picImageView;
/**
 * 工具条
 */
@property (strong, nonatomic) UIToolbar *bottombar;
/**
 * 设置有图时的工具条
 */
- (void)setPropertyOfBottomBarWithImageView:(UIImageView *)WeiboImageView;
/**
 * 配置无图时的工具条
 * @param h 高度
 */
- (void)setPropertyOfBottomBarWithHeight:(int)h;
/**
 * 配置缩略图的显示
 * @param i 图片在数组中的位置
 */
- (void)setThePropertyOfThumbnailImageWithI:(int)i andJ:(int)j withAligmentLabel:(YYLabel *)label withTag:(int)tag;
/**
 * 自适应label高度
 * @param label 具体的label对象
 */
- (void)setHeightOfLabel:(YYLabel *)label;
/**
 * 动态改变底部3个按钮的frame
 */
- (void)setHeightOfButton:(CGFloat)y height:(CGFloat)h;
/**
 * 显示原创微博的文本内容
 */
- (void)setThePropertyOfContentLabel;
/**
 * 显示转发微博的文本内容
 */
- (void)setPropertyOfRetweetLabel;
/**
 * 创建cell所需显示的对象
 */
-(void)createNewCellProperty;

@end
