//
//  ViewController.m
//  LGNavigationController
//
//  Created by iOS on 2017/6/9.
//  Copyright © 2017年 iOS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = [NSString stringWithFormat:@"%lu", self.navigationController.viewControllers.count];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [nextBtn setTitle:@"下一页" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextPage:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn sizeToFit];
    [nextBtn setCenter:self.view.center];
    [self.view addSubview:nextBtn];
    
//    if (self.navigationController.viewControllers.count % 2 == 0) {
//        [self.navigationController setNavigationBarHidden:YES];
//    } else {
//        [self.navigationController setNavigationBarHidden:NO];
//    }
}

#pragma mark - handle

- (IBAction)nextPage:(id)sender {
    
    ViewController *nextVC = [[ViewController alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
