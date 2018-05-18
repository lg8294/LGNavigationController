//
//  LGNavigationControllerCustomTransition.m
//  LGNavigationController
//
//  Created by Arrcen-LG on 2018/5/18.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "LGNavigationControllerCustomTransition.h"
#import "LGAnimatedController.h"
#import "LGInteractiveController.h"

@interface LGNavigationControllerCustomTransition () <UINavigationControllerDelegate>

@end

@implementation LGNavigationControllerCustomTransition

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
}

#pragma mark - UINavigationControllerDelegate
// 自定义转场动画
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {

    return [[LGAnimatedController alloc] initWithOperation:operation];
}

// 自定义交互式转场，还不知道为什么无效
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    if ([animationController isKindOfClass:[LGAnimatedController class]]) {
        LGAnimatedController *avc = (LGAnimatedController *)animationController;
        if (avc.operation == UINavigationControllerOperationPop) {
            if (self.interactivePopGestureRecognizer.state == UIGestureRecognizerStatePossible) {
                return nil;
            }
            return [[UIPercentDrivenInteractiveTransition alloc] init];
        }
    }
    return nil;
}
@end
