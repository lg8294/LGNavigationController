//
//  LGNavigationAnimatedController.m
//  LGNavigationController
//
//  Created by Arrcen-LG on 2018/5/17.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "LGNavigationAnimatedController.h"
#import "LGPushAnimatedTransitioning.h"
#import "LGPopAnimatedTransitioning.h"

@interface LGNavigationAnimatedController ()

@end

@implementation LGNavigationAnimatedController

- (instancetype)initWithOperation:(UINavigationControllerOperation)operation
{
    self = [super init];
    if (self) {
        _operation = operation;
    }
    return self;
}

+ (id<UIViewControllerAnimatedTransitioning>)AnimatedControllerWithOperation:(UINavigationControllerOperation)operation {
    if (operation == UINavigationControllerOperationPop) {
        return [[LGPopAnimatedTransitioning alloc] init];
    } else if (operation == UINavigationControllerOperationPush) {
        return [[LGPushAnimatedTransitioning alloc] init];
    } else {
        return nil;
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    if (self.operation == UINavigationControllerOperationPush) {
        
        [[transitionContext containerView] addSubview:toView];
        toView.alpha = 0;
        
        toView addGestureRecognizer:<#(nonnull UIGestureRecognizer *)#>
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toView.alpha = 1;
            fromView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        } completion:^(BOOL finished) {
            fromView.transform = CGAffineTransformIdentity;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    } else {
        [[transitionContext containerView] insertSubview:toView belowSubview:fromView];
        toView.alpha = 0;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toView.alpha = 1;
            fromView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        } completion:^(BOOL finished) {
            fromView.transform = CGAffineTransformIdentity;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}
@end
