//
//  UINavigationController+LG.h
//  LGNavigationController
//
//  Created by Arrcen-LG on 2018/5/18.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LGPrefersNavigationBarHidden)

/**
 建议导航栏是否隐藏
 */
@property (nonatomic, assign) BOOL lg_prefersNavigationBarHidden;

@end

@interface UINavigationController (LGNavigationBarAppearance)

/**
 建议导航栏是否隐藏总开关
 */
@property (nonatomic, assign) BOOL lg_viewControllerBasedNavigationBarAppearanceEnabled;

@end
