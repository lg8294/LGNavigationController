//
//  LGInteractiveController.m
//  LGNavigationController
//
//  Created by 李刚 on 2018/5/17.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "LGInteractiveController.h"
#import <objc/runtime.h>

@interface LGInteractiveController ()

@property (nonatomic, strong) UIViewController *vc;

@end

const NSString *kGesture;

@implementation LGInteractiveController

- (void)addToVC:(UIViewController *)vc {
    
    self.vc = vc;
    
    UIPanGestureRecognizer *gesture = objc_getAssociatedObject(vc.view, &kGesture);
    if (gesture) {
        [gesture.view removeGestureRecognizer:gesture];
    }
    
    gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureUpdate:)];
    objc_setAssociatedObject(vc.view, &kGesture, gesture, OBJC_ASSOCIATION_ASSIGN);
    
    [vc.view addGestureRecognizer:gesture];
}

- (void)handleGestureUpdate:(UIPanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self.vc.navigationController popViewControllerAnimated:YES];
        [gesture setTranslation:CGPointZero inView:gesture.view];
        self.inProgress = YES;
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [gesture translationInView:gesture.view];
        CGFloat percent = fabs(point.y/150);
        [self updateInteractiveTransition:percent];
    } else {
        CGPoint point = [gesture translationInView:gesture.view];
        CGFloat percent = fabs(point.y/150);
        if (percent > 0.5) {
            [self finishInteractiveTransition];
        } else {
            [self cancelInteractiveTransition];
        }
        self.inProgress = NO;
    }
}

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    [super startInteractiveTransition:transitionContext];
    
}
@end
