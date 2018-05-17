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
#import "LGNavigationAnimatedController.h"

@interface LGNavigationControllerDelegate ()

@property (nonatomic, strong) LGPushAnimatedTransitioning *pushAnimator;
@property (nonatomic, strong) LGPopAnimatedTransitioning *popAnimator;
@property (nonatomic, strong) LGNavigationAnimatedController *animator;

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionController;
@end

@implementation LGNavigationControllerDelegate

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pushAnimator = [[LGPushAnimatedTransitioning alloc] init];
        _popAnimator = [[LGPopAnimatedTransitioning alloc] init];
        _animator = [[LGNavigationAnimatedController alloc] init];
        _interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
    }
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {

    self.animator.operation = operation;
    return self.animator;
//    if (operation == UINavigationControllerOperationPush) {
//        return self.pushAnimator;
//    } else {
//        return self.popAnimator;
//    }
}

//交互式动画，在非交互式动画效果中，该方法返回 nil。
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return self.interactive ? self.interactionController : nil;
}

@end
