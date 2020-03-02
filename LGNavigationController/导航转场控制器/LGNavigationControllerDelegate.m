//
//  LGNavigationControllerDelegate.m
//  LGNavigationController
//
//  Created by Arrcen-LG on 2018/5/16.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "LGNavigationControllerDelegate.h"
#import "LGAnimatedController.h"
#import <objc/runtime.h>

@interface LGNavigationControllerDelegate () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UINavigationController *navc;

@property (nonatomic, strong) LGAnimatedController *animator;

@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *gestureRecognizer;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionController;

@end

const NSString *kNavigationControllerCustomGestureRecognier;

@implementation LGNavigationControllerDelegate

- (instancetype)init
{
    self = [super init];
    if (self) {
        _animator = [[LGAnimatedController alloc] init];
        _interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
    }
    return self;
}

- (UIScreenEdgePanGestureRecognizer *)gestureRecognizer {
    if (!_gestureRecognizer) {
        _gestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        _gestureRecognizer.edges = UIRectEdgeLeft;
        _gestureRecognizer.delegate = self;
    }
    return _gestureRecognizer;
}

#pragma mark - public
- (void)setupNavigationController:(UINavigationController *)navigationController {
    self.navc = navigationController;
    
    navigationController.delegate = self;
//    NSLog(@"navigationController.view = %@", navigationController.view);
//    NSLog(@"navigationController.interactivePopGestureRecognizer.view = %@", navigationController.interactivePopGestureRecognizer.view);
    [navigationController.view addGestureRecognizer:self.gestureRecognizer];
//    [navigationController.interactivePopGestureRecognizer.view addGestureRecognizer:self.gestureRecognizer];
    navigationController.interactivePopGestureRecognizer.enabled = NO;
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {

    self.animator.operation = operation;
    return self.animator;
}

//交互式动画，在非交互式动画效果中，该方法返回 nil。
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    if (self.animator.operation == UINavigationControllerOperationPop) {
        if (self.gestureRecognizer.state > UIGestureRecognizerStatePossible) {
            return self.interactionController;
        } else {
            return nil;
        }
    } else {
        return nil;
        
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.navc.viewControllers.count <= 1) {
        return NO;
    }
    
    return YES;
}
#pragma mark - handle

- (void)handleGesture:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {

        [self.navc popViewControllerAnimated:YES];
        [gestureRecognizer setTranslation:CGPointZero inView:gestureRecognizer.view];
        
    } else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [gestureRecognizer translationInView:gestureRecognizer.view];
        CGFloat percent = [self calculatePercentWithPoint:point];
        [self.interactionController updateInteractiveTransition:percent];
    } else {
        CGPoint point = [gestureRecognizer translationInView:gestureRecognizer.view];
        CGFloat percent = [self calculatePercentWithPoint:point];
        if (percent > 0.5) {
            [self.interactionController finishInteractiveTransition];
        } else {
            [self.interactionController cancelInteractiveTransition];
        }
    }
}

#pragma mark - private

- (CGFloat)calculatePercentWithPoint:(CGPoint)point {
//    NSLog(@"%@", NSStringFromCGPoint(point));
    CGFloat percent = fabs(point.x/([UIScreen mainScreen].bounds.size.width/2));
    return percent;
}
@end
