//
//  LGInteractiveController.h
//  LGNavigationController
//
//  Created by 李刚 on 2018/5/17.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGInteractiveController : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL inProgress;

- (void)addToVC:(UIViewController *)vc;

@end
