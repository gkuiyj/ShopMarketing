//
//  ShiXiang_HYSegmentedControl.h
//  zszw.iphone.sq
//
//  Created by andli on 14-12-9.
//  Copyright (c) 2014年 Epoint. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HYSegmentedControlDelegate <NSObject>

@required
//代理函数 获取当前下标
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index;

@end

@interface ShiXiang_HYSegmentedControl : UIView

@property (assign, nonatomic) id<HYSegmentedControlDelegate>delegate;

/**
 *  初始化函数
 *
 *  @param y
 *  @param titles
 *  @param delegate
 *  @param flag     子视图是否需要上移64像素
 *
 *  @return
 */
- (id)initWithOriginY:(CGFloat)y Titles:(NSArray *)titles delegate:(id)delegate Flag:(BOOL)flag;

//提供方法改变 index
- (void)changeSegmentedControlWithIndex:(NSInteger)index;

@end

