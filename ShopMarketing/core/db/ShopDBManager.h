//
//  ShopDBManager.h
//  ShopMarketing
//
//  Created by kaiser on 16/3/5.
//  Copyright © 2016年 kaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrizeInfoModel.h"
#import <sqlite3.h>
#import "ShopDB.h"

@interface ShopDBManager : NSObject

//添加中奖信息,
+ (void)insertPrizeInfo:(PrizeInfoModel *)info;
+ (NSMutableArray *)getAllPrizeInfoList;
+ (NSMutableArray *)getAlreadyPrizeInfoList;
+ (NSMutableArray *)getAbandonPrizeInfoList;
@end
