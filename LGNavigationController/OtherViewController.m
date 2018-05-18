//
//  OtherViewController.m
//  LGNavigationController
//
//  Created by Arrcen-LG on 2018/5/18.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "OtherViewController.h"
#import "UINavigationController+LGNavigationBarAppearance.h"

@interface OtherViewController ()

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lg_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor orangeColor];
}

@end
