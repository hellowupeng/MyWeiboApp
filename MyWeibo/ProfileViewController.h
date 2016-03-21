//
//  ProfileViewController.h
//  MyWeibo
//
//  Created by admin on 16/3/17.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
/**
 * 个人资料
 */
@property (strong, nonatomic) IBOutlet UIView *profileView;
/**
 * 头像
 */
@property (strong, nonatomic) IBOutlet UIImageView *avatarView;

@end
