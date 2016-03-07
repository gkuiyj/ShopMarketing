//
//  PrizeManageViewController.h
//  ShopMarketing
//
//  Created by kaiser on 16/3/4.
//  Copyright © 2016年 kaiser. All rights reserved.
//

#import "BaseViewController.h"

@interface PrizeManageViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *level1;
@property (weak, nonatomic) IBOutlet UITextField *level2;
@property (weak, nonatomic) IBOutlet UITextField *level3;
@property (weak, nonatomic) IBOutlet UITextField *level4;
@property (weak, nonatomic) IBOutlet UITextField *level5;

- (IBAction)saveAction:(id)sender;
@end
