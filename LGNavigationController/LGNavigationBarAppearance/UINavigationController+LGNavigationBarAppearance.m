//
//  UINavigationController+LG.m
//  LGNavigationController
//
//  Created by Arrcen-LG on 2018/5/18.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "UINavigationController+LGNavigationBarAppearance.h"
#import <objc/runtime.h>

typedef void (^_LGViewControllerWillAppearInjectBlock)(UIViewController *viewController, BOOL animated);

@interface UIViewController (LGPrefersNavigationBarHiddenPrivate)

@property (nonatomic, copy) _LGViewControllerWillAppearInjectBlock lg_willAppearInjectBlock;

@end

@implementation UIViewController (LGPrefersNavigationBarHiddenPrivate)

+ (void)load
{
    Method originalMethod = class_getInstanceMethod(self, @selector(viewWillAppear:));
    Method swizzledMethod = class_getInstanceMethod(self, @selector(lg_viewWillAppear:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)lg_viewWillAppear:(BOOL)animated
{
    [self lg_viewWillAppear:animated];
    
    if (self.lg_willAppearInjectBlock) {
        self.lg_willAppearInjectBlock(self, animated);
    }
}

- (_LGViewControllerWillAppearInjectBlock)lg_willAppearInjectBlock
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setLg_willAppearInjectBlock:(_LGViewControllerWillAppearInjectBlock)block
{
    objc_setAssociatedObject(self, @selector(lg_willAppearInjectBlock), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

@implementation UIViewController (LGPrefersNavigationBarHidden)

- (BOOL)lg_prefersNavigationBarHidden
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setLg_prefersNavigationBarHidden:(BOOL)hidden
{
    objc_setAssociatedObject(self, @selector(lg_prefersNavigationBarHidden), @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation UINavigationController (LGNavigationBarAppearance)

+ (void)load
{
    Method originalMethod = class_getInstanceMethod(self, @selector(pushViewController:animated:));
    Method swizzledMethod = class_getInstanceMethod(self, @selector(lg_pushViewController:animated:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)lg_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self lg_setupViewControllerBasedNavigationBarAppearanceIfNeeded:viewController];
    
    [self lg_pushViewController:viewController animated:animated];
}

- (void)lg_setupViewControllerBasedNavigationBarAppearanceIfNeeded:(UIViewController *)appearingViewController
{
    if (!self.lg_viewControllerBasedNavigationBarAppearanceEnabled) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    _LGViewControllerWillAppearInjectBlock block = ^(UIViewController *viewController, BOOL animated) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf setNavigationBarHidden:viewController.lg_prefersNavigationBarHidden animated:animated];
        }
    };
    
    // Setup will appear inject block to appearing view controller.
    // Setup disappearing view controller as well, because not every view controller is added into
    // stack by pushing, maybe by "-setViewControllers:".
    appearingViewController.lg_willAppearInjectBlock = block;
    UIViewController *disappearingViewController = self.viewControllers.lastObject;
    if (disappearingViewController && !disappearingViewController.lg_willAppearInjectBlock) {
        disappearingViewController.lg_willAppearInjectBlock = block;
    }
}

- (BOOL)lg_viewControllerBasedNavigationBarAppearanceEnabled
{
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    if (number) {
        return number.boolValue;
    }
    self.lg_viewControllerBasedNavigationBarAppearanceEnabled = YES;
    return YES;
}

- (void)setLg_viewControllerBasedNavigationBarAppearanceEnabled:(BOOL)enabled
{
    SEL key = @selector(lg_viewControllerBasedNavigationBarAppearanceEnabled);
    objc_setAssociatedObject(self, key, @(enabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
