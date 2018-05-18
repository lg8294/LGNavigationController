//
//  LGNavigationVController1.m
//  LGNavigationController
//
//  Created by Arrcen-LG on 2018/5/18.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "LGNavigationController.h"

@interface LGNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation LGNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
}

#pragma mark - UIGestureRecognizerDelegate

//开始进行手势识别时调用的方法，返回NO则结束，不再触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count <= 1) {
        return NO;
    }
    return YES;
}

//是否支持多手势触发，返回YES，则可以多个手势一起触发方法，返回NO则为互斥
// 解决多个手势冲突 同时接受多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

//这个方法返回YES，第一个和第二个互斥时，第二个会失效
// 解决在手指滑动时候,被pop的viewController中的UIscrollView会跟着一起滚动
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

//手指触摸屏幕后回调的方法，返回NO则不再进行手势识别，方法触发等
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch;

//下面这个两个方法也是用来控制手势的互斥执行的
//这个方法返回YES，第一个手势和第二个互斥时，第一个会失效
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0);

@end
