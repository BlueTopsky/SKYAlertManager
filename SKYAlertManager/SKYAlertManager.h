//
//  SKYAlertManager.h
//  TestDemo
//
//  Created by Topsky on 2018/4/13.
//  Copyright © 2018年 Topsky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//点击按钮的回调，取消按钮的index为0；其它按钮的index按照添加的顺序从1开始递增（即使没有取消按钮也是从1开始递增）
typedef void (^AlertIndexBlock) (NSUInteger index);

@interface SKYAlertManager : NSObject

//获取当前最顶层的ViewController
- (UIViewController *)topViewController;

+ (instancetype)sharedInstance;

//便捷创建方法（无按钮）
+ (void)showAlertFromViewController:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style;

//推出弹窗的视图控制器，为空则默认为当前最顶层视图控制器
+ (void)showAlertFromViewController:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style cancleTitle:(NSString *)cancleTitle action:(AlertIndexBlock)alertIndexBlock;

//便捷创建方法（没有取消按钮，但有其它按钮）
+ (void)showAlertFromViewController:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style otherTitles:(NSArray *)otherTitles action:(AlertIndexBlock)alertIndexBlock;

/**
 完整创建方法（有取消按钮和其它按钮）

 @param viewController 推出弹窗的视图控制器，为空则默认为当前最顶层视图控制器
 @param title 标题
 @param message 具体消息
 @param style 弹窗样式
 @param cancleTitle 取消按钮标题
 @param otherTitles 其它按钮标题数组
 @param alertIndexBlock 点击按钮的回调
 */
+ (void)showAlertFromViewController:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)style cancleTitle:(NSString *)cancleTitle otherTitles:(NSArray *)otherTitles action:(AlertIndexBlock)alertIndexBlock;

//退出当前最顶层的AlertController
+ (void)dismissCurrentAlertController;

@end
