//
//  ModalView.h
//  testiOS_ModalAlertWindow
//
//  Created by wangkai on 14-4-28.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 对话框显示时动画的方式，
 */
typedef enum ShowDialogViewAnimationOptions
{
    ShowDialogViewAnimationNone = 0,
    ShowDialogViewAnimationFromLeft,
    ShowDialogViewAnimationFromTop,
    ShowDialogViewAnimationFromRight,
    ShowDialogViewAnimationFromBottom,
    ShowDialogViewAnimationFromCenter,
} ShowDialogViewAnimationOptions;

/**
 对话框关闭时动画的方式
 */
typedef enum CloseDialogViewViewAnimationOptions
{
    CloseDialogViewAnimationNone = 0,
    CloseDialogViewAnimationToLeft,
    CloseDialogViewAnimationToTop,
    CloseDialogViewAnimationToRight,
    CloseDialogViewAnimationToBottom,
    CloseDialogViewAnimationToCenter,
} CloseDialogViewAnimationOptions;

/**
 全局函数，显示模态/非模态对话框
 showDialogViewAnimationOptions 对话框动画形式
 isModal:是否为模态对话框，YES/NO
 finished:动画执行完成后执行的代码块
 */
void showModalView(UIView *view,ShowDialogViewAnimationOptions showDialogViewAnimationOptions,
                   BOOL isModal,void (^completion)(BOOL finished));
/**
 全局函数，关闭模态/非模态对话框
 
 */
void closeModalView(CloseDialogViewAnimationOptions closeDialogViewAnimationOptions,
                    void (^completion)(BOOL finished));