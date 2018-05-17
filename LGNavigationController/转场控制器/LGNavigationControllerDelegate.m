//
//  LGNavigationControllerDelegate.m
//  LGNavigationController
//
//  Created by Arrcen-LG on 2018/5/16.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "LGNavigationControllerDelegate.h"
#import "LGAnimatedController.h"
#import "LGInteractiveController.h"

@interface LGNavigationControllerDelegate ()

@property (nonatomic, strong) LGAnimatedController *animator;
@property (nonatomic, strong) LGInteractiveController *interactionController;

@property (nonatomic, assign) UINavigationControllerOperation *operation;

@end

@implementation LGNavigationControllerDelegate

- (instancetype)init
{
    self = [super init];
    if (self) {
        _animator = [[LGAnimatedController alloc] init];
        _interactionController = [[LGInteractiveController alloc] init];
    }
    return self;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [self.interactionController addToVC:viewController];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {

    self.animator.operation = operation;
    self.operation = operation;
    return self.animator;
}

//交互式动画，在非交互式动画效果中，该方法返回 nil。
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    if (self.operation == UINavigationControllerOperationPop) {
        if (self.interactionController.inProgress) {
            return self.interactionController;
        } else {
            return nil;
        }
    } else {
        return nil;
        
    }
}

@end
