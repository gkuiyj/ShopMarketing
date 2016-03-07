//
//  ModalView.m
//  testiOS_ModalAlertWindow
//
//  Created by wangkai on 14-4-28.
//  Copyright (c) 2014年 kaiser.com. All rights reserved.
//

#import "ModalView.h"
/**
 对话框控制器
 modalView:用户需要显示的对话框视图
 myWindow:自定义的用于实现模态效果的window
 */
@class MyWindow;
@interface ModalViewController : UIViewController
{
    UIView *_modalView;
    MyWindow *_myWindow;
}
@property(retain,nonatomic)UIView *modalView;
@end

@implementation ModalViewController

-(void)setModalView:(UIView *)modalView
{
    [_modalView removeFromSuperview];
    
    _modalView  = modalView;
    [self.view addSubview:_modalView];
}
-(BOOL)shouldAutorotate     
{
    return YES;
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    float  mainScreenWidth = [UIScreen mainScreen].bounds.size.width;
    
    float  mainScreenHeight = [UIScreen mainScreen].bounds.size.height;
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft
        ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        _modalView.center = CGPointMake(mainScreenHeight/2.0, mainScreenWidth/2.0);
    }
    else
    {
        _modalView.center = CGPointMake(mainScreenWidth/2.0, mainScreenHeight/2.0);
    }
}

@end

/**实现一个自己的window 在window中拦截点击事件，
 并判断点击位置是否在对话框中，如果不是则关闭window
 根据参数isModal 判断是否是模态窗口
 */
@interface MyWindow : UIWindow
{
    ModalViewController *_myDelegate;
    BOOL _isModal;
}
@property(retain,nonatomic)ModalViewController *myDelegate;
@property(assign,nonatomic)BOOL isModal;
@end

@implementation MyWindow
@synthesize myDelegate = _myDelegate;
@synthesize isModal = _isModal;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGRect rect = _myDelegate.modalView.frame;
    
    if (point.x<rect.origin.x || (point.x>rect.origin.x+rect.size.width)
        || point.y<rect.origin.y || (point.y>rect.origin.y+rect.size.height)) {
        if (_isModal==YES) {
            
        }else
        {
            closeModalView(CloseDialogViewAnimationToCenter,nil);
        }
    }
}
@end


static MyWindow *g_alertWindow = nil;

void showModalView(UIView *view,ShowDialogViewAnimationOptions showDialogViewAnimationOptions,BOOL isModal,void (^completion)(BOOL finished))
{
    if (g_alertWindow==nil) {
        g_alertWindow = [[MyWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        g_alertWindow.isModal = isModal;
        g_alertWindow.windowLevel = UIWindowLevelNormal;
        g_alertWindow.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [g_alertWindow makeKeyAndVisible];
    }
    else
    {
        NSArray *subViews = [g_alertWindow subviews];
        for (int i=0; i<subViews.count; i++) {
            UIView *view = subViews[i];
            [view removeFromSuperview];
        }
    }
    
    ModalViewController *modalViewController = [[ModalViewController alloc]init];
    g_alertWindow.myDelegate = modalViewController;
    [modalViewController setModalView:view];
    g_alertWindow.rootViewController = modalViewController;
    view.layer.transform = CATransform3DIdentity;
    switch (showDialogViewAnimationOptions) {
        case ShowDialogViewAnimationFromRight:
            view.layer.transform = CATransform3DTranslate(view.layer.transform, 200, 0, 0);
            break;
        case ShowDialogViewAnimationFromLeft:
            view.layer.transform = CATransform3DTranslate(view.layer.transform, -200, 0, 0);
            break;
        case ShowDialogViewAnimationFromTop:
            view.layer.transform = CATransform3DTranslate(view.layer.transform, 0, -300, 0);
            break;
        case ShowDialogViewAnimationFromBottom:
            view.layer.transform = CATransform3DTranslate(view.layer.transform, 0, 300, 0);
            break;
        case ShowDialogViewAnimationFromCenter:
            view.layer.transform = CATransform3DScale(view.layer.transform, 0.001, 0.001, 1);
            break;
        default:
            break;
    }
    //view.layer.transform = CATransform3DTranslate(view.layer.transform, 0, 300, 0);
    
    [UIView transitionWithView:view duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        view.layer.transform = CATransform3DIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

void closeModalView(CloseDialogViewAnimationOptions closeDialogViewAnimationOptions,void (^completion)(BOOL finished))
{
    ModalViewController * dialogViewController = (ModalViewController *)(g_alertWindow.rootViewController);
    
    UIView  *view = dialogViewController.modalView;
    
    CATransform3D transform;
    
    switch (closeDialogViewAnimationOptions) {
        case CloseDialogViewAnimationNone:
            g_alertWindow.rootViewController = nil;
            g_alertWindow = nil;
            if (completion != nil)
            {
                completion(YES);
            }
            break;
        case CloseDialogViewAnimationToRight:
            transform = CATransform3DTranslate(view.layer.transform, 200, 0, 0);
            break;
        case CloseDialogViewAnimationToLeft:
            transform = CATransform3DTranslate(view.layer.transform, -200, 0, 0);
            break;
        case CloseDialogViewAnimationToTop:
            transform = CATransform3DTranslate(view.layer.transform, 0, -300, 0);
            break;
        case CloseDialogViewAnimationToBottom:
            transform = CATransform3DTranslate(view.layer.transform, 0, 300, 0);
            break;
        case CloseDialogViewAnimationToCenter:
            transform = CATransform3DScale(view.layer.transform, 0.001, 0.001, 1);
            break;
        default:
            break;
    }

    [UIView transitionWithView:view duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        view.layer.transform = transform;
    } completion:^(BOOL finished) {
        g_alertWindow.rootViewController = nil;
        g_alertWindow = nil;
        if (completion != nil)
        {
            completion(YES);
        }
    }];
 
}



