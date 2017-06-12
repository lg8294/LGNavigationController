//
//  LGNavigationController.m
//  LGNavigationController
//
//  Created by iOS on 2017/6/9.
//  Copyright © 2017年 iOS. All rights reserved.
//

#import "LGNavigationController.h"

#define NslogSelf NSLog(@"\n\n-[line %d]\n%s\n\n", __LINE__, __FUNCTION__)

@interface LGNavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation LGNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NslogSelf;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
        self.delegate = self;
    }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    NslogSelf;
    return [super popViewControllerAnimated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NslogSelf;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    //设置返回按钮
    if (self.viewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem = self.navigationItem.backBarButtonItem;
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NslogSelf;
    NSLog(@"%@", viewController);
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

#pragma mark - UIGestureRecognizerDelegate
// 使navigationcontroller中第一个控制器不响应右滑pop手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    NslogSelf;
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    return YES;
}
// 解决多个手势冲突 同时接受多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    NslogSelf;
    return YES;
}
// 解决在手指滑动时候,被pop的viewController中的UIscrollView会跟着一起滚动
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    NslogSelf;
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

//手指触摸屏幕后回调的方法，返回NO则不再进行手势识别，方法触发等
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch;

//开始进行手势识别时调用的方法，返回NO则结束，不再触发手势
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer;

//是否支持多时候触发，返回YES，则可以多个手势一起触发方法，返回NO则为互斥
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;

//下面这个两个方法也是用来控制手势的互斥执行的
//这个方法返回YES，第一个手势和第二个互斥时，第一个会失效
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0);

//这个方法返回YES，第一个和第二个互斥时，第二个会失效
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0);
@end
