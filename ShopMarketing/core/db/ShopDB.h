//
//  ShopDB.h
//  ShopMarketing
//
//  Created by kaiser on 16/3/5.
//  Copyright © 2016年 kaiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface ShopDB : NSObject{
    sqlite3 *database;
}

+ (NSString *)getShopDBPath;
+ (sqlite3 *)getShopDB;
@end
