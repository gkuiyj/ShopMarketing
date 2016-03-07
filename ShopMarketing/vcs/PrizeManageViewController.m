//
//  PrizeManageViewController.m
//  ShopMarketing
//
//  Created by kaiser on 16/3/4.
//  Copyright © 2016年 kaiser. All rights reserved.
//

#import "PrizeManageViewController.h"
#define FirstPrize @"prize1"
#define SecondPrize @"prize2"
#define ThirdPrize @"prize3"
#define FourthPrize @"prize4"
#define FivetPrize @"prize5"

@interface PrizeManageViewController ()

@end

@implementation PrizeManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"奖项设置";
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
    [self.view addGestureRecognizer:tap];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveBtnAction)];
    
    [self configUI];
}

- (void)configUI{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.level1.text = [userDefaults objectForKey:FirstPrize];
    self.level2.text = [userDefaults objectForKey:SecondPrize];
    self.level3.text = [userDefaults objectForKey:ThirdPrize];
    self.level4.text = [userDefaults objectForKey:FourthPrize];
    self.level5.text = [userDefaults objectForKey:FivetPrize];
}

- (void)viewTap:(id)sender{
    [self.level1 resignFirstResponder];
    [self.level2 resignFirstResponder];
    [self.level3 resignFirstResponder];
    [self.level4 resignFirstResponder];
    [self.level5 resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)saveBtnAction{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *prize1 = self.level1.text;
    NSString *prize2 = self.level2.text;
    NSString *prize3 = self.level3.text;
    NSString *prize4 = self.level4.text;
    NSString *prize5 = self.level5.text;
    
    [userDefaults setObject:prize1 forKey:FirstPrize];
    [userDefaults setObject:prize2 forKey:SecondPrize];
    [userDefaults setObject:prize3 forKey:ThirdPrize];
    [userDefaults setObject:prize4 forKey:FourthPrize];
    [userDefaults setObject:prize5 forKey:FivetPrize];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保存成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
    [self configUI];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveAction:(id)sender {
}
@end
