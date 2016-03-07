//
//  ShiXiang_HYSegmentedControl.m
//  zszw.iphone.sq
//
//  Created by andli on 14-12-9.
//  Copyright (c) 2014年 Epoint. All rights reserved.
//

#import "ShiXiang_HYSegmentedControl.h"

#define HYSegmentedControl_Height 50        //高度
#define HYSegmentedControl_Width ([UIScreen mainScreen].bounds.size.width)
#define Min_Width_4_Button 50             //最小宽度

#define Define_Tag_add 1000

#define UIColorFromRGBValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ShiXiang_HYSegmentedControl()

@property (strong, nonatomic)UIScrollView *scrollView;
@property (strong, nonatomic)NSMutableArray *array4Btn;
@property (strong, nonatomic)UIView *bottomLineView;

@end

@implementation ShiXiang_HYSegmentedControl{
    float   subViewOfScrollViewHight;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

// 初始化
- (id)initWithOriginY:(CGFloat)y Titles:(NSArray *)titles delegate:(id)delegate Flag:(BOOL)flag{
    CGRect rect4View = CGRectMake(.0f, y, HYSegmentedControl_Width, HYSegmentedControl_Height);
    if (self = [super initWithFrame:rect4View]) {
        
        self.backgroundColor = UIColorFromRGBValue(0xffffff);//设置背景
        [self setUserInteractionEnabled:YES];
        self.delegate = delegate;
        _array4Btn = [[NSMutableArray alloc] initWithCapacity:[titles count]];
        
        //设置按钮
        CGFloat width4btn = rect4View.size.width/[titles count];//根据屏幕的宽度计算平均宽度
        
        //如果低于最低宽度要求，采用最低宽度
        if (width4btn < Min_Width_4_Button) {
            width4btn = Min_Width_4_Button;
        }
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        _scrollView.backgroundColor = self.backgroundColor;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.contentSize = CGSizeMake([titles count]*width4btn, HYSegmentedControl_Height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = YES;
        
        if (flag) {
            subViewOfScrollViewHight = -64;  //是否需要下移64
        }else{
            subViewOfScrollViewHight = 0;
        }
        UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, subViewOfScrollViewHight, HYSegmentedControl_Width, HYSegmentedControl_Height)];
        subView.backgroundColor = [UIColor clearColor];
        [_scrollView addSubview:subView];
        
        //动态添加按钮
        for (int i = 0; i<[titles count]; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*width4btn, 0, width4btn, HYSegmentedControl_Height);
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:17];//字体大小
            [btn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];//设置标题
            [btn setTitleColor:UIColorFromRGBValue(0x777777) forState:UIControlStateNormal];//设置未选中颜色
            [btn setTitleColor:UIColorFromRGBValue(0xfa6004) forState:UIControlStateSelected];//设置选中颜色
            [btn addTarget:self action:@selector(segmentedControlChange:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = Define_Tag_add+i;
            [btn setBackgroundImage:[UIImage imageNamed:@"img_sq_shixiang_tab_button_normal"] forState:UIControlStateNormal];//默认状态
            [btn setBackgroundImage:[UIImage imageNamed:@"img_sq_shixiang_tab_button_press"] forState:UIControlStateSelected];//选中状态
            [subView addSubview:btn];
    
            [_array4Btn addObject:btn];
            
            if (i == 0) {
                btn.selected = YES;
                btn.highlighted = YES;
            }
        }
        
        //lineView 中间线
        CGFloat height4Line = HYSegmentedControl_Height;
        CGFloat originY = (HYSegmentedControl_Height - height4Line)/2;
        for (int i = 1; i<[titles count]; i++) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(i*width4btn-1.0f, originY, 0.5f, height4Line)];
            lineView.backgroundColor = UIColorFromRGBValue(0xcccccc);
            [subView addSubview:lineView];
        }
        
        //底部分割线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, HYSegmentedControl_Height-1, HYSegmentedControl_Width, 4.0f)];
        lineView.backgroundColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:0.8];
        [subView addSubview:lineView];
        
        //bottom line 底部线
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, HYSegmentedControl_Height-1, width4btn-4.0f, 2.0f)];
        _bottomLineView.backgroundColor = UIColorFromRGBValue(0xfa6004);
        [subView addSubview:_bottomLineView];
        [self addSubview:_scrollView];
    }
    return self;
}

//  btn clicked
- (void)segmentedControlChange:(UIButton *)btn {
    btn.selected = YES;
    //    btn.highlighted = YES;
    
    for (UIButton *subBtn in self.array4Btn) {
        if (subBtn != btn) {
            subBtn.selected = NO;
        }
    }
    
    CGRect rect4boottomLine = self.bottomLineView.frame;
    rect4boottomLine.origin.x = btn.frame.origin.x + 2;
    
    CGPoint pt = CGPointZero;
    BOOL canScrolle = NO;
    if ((btn.tag - Define_Tag_add) >= 2 && [_array4Btn count] > 4 && [_array4Btn count] > (btn.tag - Define_Tag_add + 2)) {
        //pt.x = btn.frame.origin.x - Min_Width_4_Button*1.5f;
        canScrolle = YES;
    }else if ([_array4Btn count] > 4 && (btn.tag - Define_Tag_add + 2) >= [_array4Btn count]){
        //pt.x = (_array4Btn.count - 4) * Min_Width_4_Button;
        canScrolle = YES;
    }else if (_array4Btn.count > 4 && (btn.tag - Define_Tag_add) < 2){
        pt.x = 0;
        canScrolle = YES;
    }
    
    if (canScrolle) {
        [UIView animateWithDuration:0.3 animations:^{
            _scrollView.contentOffset = pt;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.bottomLineView.frame = rect4boottomLine;
            }];
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            self.bottomLineView.frame = rect4boottomLine;
        }];
    }
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(hySegmentedControlSelectAtIndex:)]) {
        [self.delegate hySegmentedControlSelectAtIndex:btn.tag - 1000];
    }
}

#warning ////// index 从 0 开始
// delegete method
- (void)changeSegmentedControlWithIndex:(NSInteger)index {
    if (index > [_array4Btn count]-1) {
        NSLog(@"index 超出范围");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"index 超出范围" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alertView show];
        return;
    }
    
    UIButton *btn = [_array4Btn objectAtIndex:index];
    //    [btn setBackgroundImage:[UIImage imageNamed:@"img_shqp_tab_selected"] forState:UIControlStateNormal];
    [self segmentedControlChange:btn];
}

@end

