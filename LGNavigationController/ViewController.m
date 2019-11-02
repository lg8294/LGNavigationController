//
//  ViewController.m
//  LGNavigationController
//
//  Created by iOS on 2017/6/9.
//  Copyright © 2017年 iOS. All rights reserved.
//

#import "ViewController.h"
#import "UINavigationController+LGNavigationBarAppearance.h"
#import "OtherViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lg_prefersNavigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = [NSString stringWithFormat:@"%lu", self.navigationController.viewControllers.count];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [nextBtn setTitle:@"下一页" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextPage:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn sizeToFit];
    [nextBtn setCenter:self.view.center];
    [self.view addSubview:nextBtn];
    
    UIButton *nextBtn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [nextBtn1 setTitle:@"下一页1" forState:UIControlStateNormal];
    [nextBtn1 addTarget:self action:@selector(nextPage1:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn1 sizeToFit];
    CGPoint point = self.view.center;
    point.y += 30;
    [nextBtn1 setCenter:point];
    [self.view addSubview:nextBtn1];
    
    // 测试隐藏 NaviagtionBar 后侧滑返回是否有效
//#define TestNaviagtionBarHidden
#ifdef TestNaviagtionBarHidden
    if (self.navigationController.viewControllers.count % 2 == 0) {
        [self.navigationController setNavigationBarHidden:YES];
    } else {
        [self.navigationController setNavigationBarHidden:NO];
    }
    
#endif
    
    // 测试自定义返回按键后侧滑返回是否有效
//#define TestBackBtnCustom
#ifdef TestBackBtnCustom
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
        
//        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
#endif
    
}

#pragma mark -
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"%s", __func__);
    NSLog(@"%@", NSStringFromSelector(_cmd));
    return YES;
}
#pragma mark - handle

- (IBAction)nextPage:(id)sender {
    
    ViewController *nextVC = [[ViewController alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (IBAction)nextPage1:(id)sender {
    
    OtherViewController *nextVC = [[OtherViewController alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
