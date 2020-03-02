//
//  UINavigationController+LG.h
//  LGNavigationController
//
//  Created by Arrcen-LG on 2018/5/18.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 视图控制器扩展
 */
@interface UIViewController (LGPrefersNavigationBarHidden)

/**
 在当前视图控制器中，设置导航栏是否隐藏
 */
@property (nonatomic, assign) BOOL lg_prefersNavigationBarHidden;

@end


/**
 导航栏控制器扩展
 */
@interface UINavigationController (LGNavigationBarAppearance)

/**
 在导航栏控制器中，设置导航栏在各个视图控制器中设置的值是否有效
 */
@property (nonatomic, assign) BOOL lg_viewControllerBasedNavigationBarAppearanceEnabled;

@end
