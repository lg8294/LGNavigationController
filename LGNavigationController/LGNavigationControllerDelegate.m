//
//  LGNavigationControllerDelegate.m
//  LGNavigationController
//
//  Created by Arrcen-LG on 2018/5/16.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "LGNavigationControllerDelegate.h"
#import "LGPushAnimatedTransitioning.h"
#import "LGPopAnimatedTransitioning.h"

@interface LGNavigationControllerDelegate ()

@property (nonatomic, strong) LGPushAnimatedTransitioning *animator;
@property (nonatomic, strong) LGPopAnimatedTransitioning *popAnimator;

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionController;
@end

@implementation LGNavigationControllerDelegate

- (instancetype)init
{
    self = [super init];
    if (self) {
        _animator = [[LGPushAnimatedTransitioning alloc] init];
        _popAnimator = [[LGPopAnimatedTransitioning alloc] init];
        _interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
    }
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        return self.animator;
    } else if (operation == UINavigationControllerOperationPop) {
        return self.popAnimator;
    }
    
    return nil;
}

//交互式动画，在非交互式动画效果中，该方法返回 nil。
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return self.interactionController;
}

@end
