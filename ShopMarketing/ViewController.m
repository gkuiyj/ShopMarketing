//
//  ViewController.m
//  ShopMarketing
//
//  Created by kaiser on 16/3/4.
//  Copyright © 2016年 kaiser. All rights reserved.
//

#import "ViewController.h"
#import "PrizeManageViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "math.h"
#import "ModalView.h"
#import "ShopDBManager.h"
#import "PrizeInfoModel.h"

@interface ViewController (){
    float random;
    float orign;
    
    BOOL isStart;
    
    NSString *_level; //中几等奖
    NSString *_prize; //中奖奖品
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"首页";
    isStart = YES;
    
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:177/255.0f green:9/255.0f blue:17/255.0f alpha:1];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"wait_cont_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(prizeBtnAction)];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewTap:(id)sender{
    [self.phoneTx resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    self.navigationItem.leftBarButtonItem = nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    //return UIStatusBarStyleLightContent;
    return UIStatusBarStyleDefault;
}

- (void)prizeBtnAction{
    PrizeManageViewController *vc = [PrizeManageViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startAction:(id)sender {
    NSString *phone = self.phoneTx.text;
    if ([@"" isEqualToString:phone]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入手机号参与抽奖！" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if (isStart) {
        isStart = NO;
        [self choujiang];
    }
}

- (void)choujiang
{
    //******************旋转动画******************
    //产生随机角度
    srand((unsigned)time(0));  //不加这句每次产生的随机数不变
    random = (rand() % 20) / 10.0;
    //设置动画
    CABasicAnimation *spin = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [spin setFromValue:[NSNumber numberWithFloat:M_PI * (0.0+orign)]];
    [spin setToValue:[NSNumber numberWithFloat:M_PI * (10.0+random+orign)]];
    [spin setDuration:2.5];
    [spin setDelegate:self];//设置代理，可以相应animationDidStop:finished:函数，用以弹出提醒框
    //速度控制器
    [spin setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    //添加动画
    [[self.zhenImageView layer] addAnimation:spin forKey:nil];
    //锁定结束位置
    self.zhenImageView.transform = CGAffineTransformMakeRotation(M_PI * (10.0+random+orign));
    //锁定fromValue的位置
    orign = 10.0+random+orign;
    orign = fmodf(orign, 2.0);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSInteger area;

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //判断抽奖结果  0-60度
    if (orign >= (0.0/3.0) && orign < (0.5/3.0)) {
        area = 1;
        _level = @"一等奖！";
        _prize = [userDefaults objectForKey:@"prize1"];
    }
    else if (orign >= (0.5/3.0) && orign < ((0.5/3.0)*2)) {
        area = 4;
        _level = @"四等奖！";
        _prize = [userDefaults objectForKey:@"prize4"];
    }
    else if (orign >= ((0.5/3.0)*2) && orign < ((0.5/3.0)*3)) {
        area = 2;
        _level = @"二等奖！";
        _prize = [userDefaults objectForKey:@"prize2"];
    }
    else if (orign >= (0.0+0.5) && orign < ((0.5/3.0)+0.5)) {
        area = 5;
        _level = @"五等奖！";
        _prize = [userDefaults objectForKey:@"prize5"];
    }
    else if (orign >= ((0.5/3.0)+0.5) && orign < (((0.5/3.0)*2)+0.5)) {
        area = 4;
        _level = @"四等奖！";
        _prize = [userDefaults objectForKey:@"prize4"];
    }
    else if (orign >= (((0.5/3.0)*2)+0.5) && orign < (((0.5/3.0)*3)+0.5)) {
        area = 5;
        _level = @"五等奖！";
        _prize = [userDefaults objectForKey:@"prize5"];
    }
    else if (orign >= (0.0+1.0) && orign < ((0.5/3.0)+1.0)) {
        area = 3;
        _level = @"三等奖！";
        _prize = [userDefaults objectForKey:@"prize3"];
    }
    else if (orign >= ((0.5/3.0)+1.0) && orign < (((0.5/3.0)*2)+1.0)) {
        area = 5;
        _level = @"五等奖！";
        _prize = [userDefaults objectForKey:@"prize5"];
    }
    else if (orign >= (((0.5/3.0)*2)+1.0) && orign < (((0.5/3.0)*3)+1.0)) {
        area = 4;
        _level = @"四等奖！";
        _prize = [userDefaults objectForKey:@"prize4"];
    }
    else if (orign >= (0.0+1.5) && orign < ((0.5/3.0)+1.5)) {
        area = 5;
        _level = @"五等奖！";
        _prize = [userDefaults objectForKey:@"prize5"];
    }
    else if (orign >= ((0.5/3.0)+1.5) && orign < (((0.5/3.0)*2)+1.5)) {
        area = 3;
        _level = @"三等奖！";
        _prize = [userDefaults objectForKey:@"prize3"];
    }
    else {
        area = 5;
        _level = @"五等奖！";
        _prize = [userDefaults objectForKey:@"prize5"];
    }
    
    //UIAlertView *result = [[UIAlertView alloc] initWithTitle:@"恭喜中奖！" message:message delegate:self cancelButtonTitle:@"领奖去！" otherButtonTitles: nil];
    //[result show];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];
    view.center = CGPointMake(AppWidth/2.0f, AppHeight/2.0f);
    view.layer.borderColor = [UIColor orangeColor].CGColor;
    view.layer.borderWidth = 2;
    view.layer.cornerRadius = 15;
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 131)];
    imgView.image = [UIImage imageNamed:@"zhongjiang"];
    [view addSubview:imgView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 200, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor redColor];
    label.text = [NSString stringWithFormat:@"您中了 %@",_level];;
    label.font = [UIFont boldSystemFontOfSize:24];
    [view addSubview:label];
    
    UILabel *gift = [[UILabel alloc] initWithFrame:CGRectMake(50, 220, 200, 40)];
    gift.textAlignment = NSTextAlignmentCenter;
    gift.textColor = [UIColor grayColor];
    gift.text = [NSString stringWithFormat:@"获得 %@",_prize];
    gift.font = [UIFont boldSystemFontOfSize:17];
    [view addSubview:gift];
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 320, 120, 44)];
    cancelBtn.backgroundColor = [UIColor orangeColor];
    cancelBtn.layer.cornerRadius = 22;
    cancelBtn.tag = 0;
    [cancelBtn setTitle:@"放  弃" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cancelBtn];
    
    UIButton *okBtn = [[UIButton alloc] initWithFrame:CGRectMake(160, 320, 120, 44)];
    okBtn.backgroundColor = [UIColor orangeColor];
    okBtn.layer.cornerRadius = 22;
    okBtn.tag = 1;
    [okBtn setTitle:@"领  奖" forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:okBtn];
    isStart = YES;
    showModalView(view, ShowDialogViewAnimationFromTop, YES, ^(BOOL finished) {
        
    });
}

- (void)btnAction:(UIBarButtonItem*)btn{
    NSInteger n = btn.tag;
    PrizeInfoModel *m = [[PrizeInfoModel alloc] init];
    m.phone = self.phoneTx.text;
    m.prize = _prize;
    m.level = _level;
    m.type = [NSString stringWithFormat:@"%ld",n];
    m.createTime = [self stringFromDate:[NSDate date]];
    //中奖记录插入数据库
    [ShopDBManager insertPrizeInfo:m];
    
    if (n == 1) {
        closeModalView(CloseDialogViewAnimationToCenter,nil);
    }else{
        closeModalView(CloseDialogViewAnimationToCenter,nil);
    }
}

- (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

@end
