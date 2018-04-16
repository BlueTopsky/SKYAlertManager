//
//  SKYAlertManager.m
//  TestDemo
//
//  Created by Topsky on 2018/4/13.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import "SKYAlertManager.h"

@implementation SKYAlertManager

static SKYAlertManager *_alertManager;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _alertManager = [[SKYAlertManager alloc] init];
    });
    return _alertManager;
}

+ (void)showAlertFromViewController:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style {
    [self showAlertFromViewController:viewController Title:title message:message preferredStyle:style cancleTitle:nil otherTitles:nil action:nil];
}

+ (void)showAlertFromViewController:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style cancleTitle:(NSString *)cancleTitle action:(AlertIndexBlock)alertIndexBlock {
    [self showAlertFromViewController:viewController Title:title message:message preferredStyle:style cancleTitle:cancleTitle otherTitles:nil action:alertIndexBlock];
}

+ (void)showAlertFromViewController:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style otherTitles:(NSArray *)otherTitles action:(AlertIndexBlock)alertIndexBlock {
    [self showAlertFromViewController:viewController Title:title message:message preferredStyle:style cancleTitle:nil otherTitles:otherTitles action:alertIndexBlock];
}

+ (void)showAlertFromViewController:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style cancleTitle:(NSString *)cancleTitle otherTitles:(NSArray *)otherTitles action:(AlertIndexBlock)alertIndexBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    if (cancleTitle) {
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:cancleTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            alertIndexBlock(0);
        }];
        [alertController addAction:cancleAction];
    }
    for (NSUInteger i = 0; i < otherTitles.count; i++) {
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            alertIndexBlock(i + 1);
        }];
        [alertController addAction:otherAction];
    }
    if (!viewController) {
        viewController = [[self sharedInstance] topViewController];
    }
    [viewController presentViewController:alertController animated:YES completion:nil];
}

+ (void)dismissCurrentAlertController {
    UIViewController *topVC = [[self sharedInstance] topViewController];
    if ([topVC isKindOfClass:[UIAlertController class]]) {
        [topVC dismissViewControllerAnimated:YES completion:nil];
    }
}

- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self p_topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self p_topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)p_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self p_topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self p_topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
}

@end
