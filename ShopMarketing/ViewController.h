//
//  ViewController.h
//  ShopMarketing
//
//  Created by kaiser on 16/3/4.
//  Copyright © 2016年 kaiser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneTx;
@property (weak, nonatomic) IBOutlet UIImageView *panImageView;
@property (weak, nonatomic) IBOutlet UIImageView *zhenImageView;

@property (weak, nonatomic) IBOutlet UIButton *startBtnAction;

- (IBAction)startAction:(id)sender;

@end

