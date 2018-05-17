//
//  LGNavigationAnimatedController.h
//  LGNavigationController
//
//  Created by Arrcen-LG on 2018/5/17.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LGNavigationAnimatedController : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithOperation:(UINavigationControllerOperation)operation;

@property (nonatomic, assign) UINavigationControllerOperation operation;

+ (id<UIViewControllerAnimatedTransitioning>)AnimatedControllerWithOperation:(UINavigationControllerOperation)operation;

@end
