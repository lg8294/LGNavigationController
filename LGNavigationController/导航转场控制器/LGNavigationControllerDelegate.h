//
//  LGNavigationControllerDelegate.h
//  LGNavigationController
//
//  Created by Arrcen-LG on 2018/5/16.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// 导航控制器代理（导航转场控制器），通过返回自定义的转场动画，实现自定义导航转场
@interface LGNavigationControllerDelegate : NSObject <UINavigationControllerDelegate>

/// 设置导航控制器的代理为自己
/// @param navigationController 导航控制器
- (void)setupNavigationController:(UINavigationController *)navigationController;

@end
