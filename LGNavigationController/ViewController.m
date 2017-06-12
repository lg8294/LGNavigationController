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
    
//    UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(backAction:)];
//    self.navigationItem.leftBarButtonItem = backBarItem;
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [nextBtn setTitle:@"下一页" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextPage:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn sizeToFit];
    [nextBtn setCenter:self.view.center];
    [self.view addSubview:nextBtn];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextPage:(id)sender {
    
//    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    ViewController *nextVC = [mainStory instantiateViewControllerWithIdentifier:NSStringFromClass([ViewController class])];
    
    ViewController *nextVC = [[ViewController alloc] init];
    nextVC.title = [NSString stringWithFormat:@"%lu", self.navigationController.viewControllers.count + 1];
    [self.navigationController pushViewController:nextVC animated:YES];
}
@end
