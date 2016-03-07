//
//  ShopDBManager.m
//  ShopMarketing
//
//  Created by kaiser on 16/3/5.
//  Copyright © 2016年 kaiser. All rights reserved.
//

#import "ShopDBManager.h"

@implementation ShopDBManager

/** 添加中奖记录
 *
 */
+ (void)insertPrizeInfo:(PrizeInfoModel *)info{

    sqlite3 *db = [ShopDB getShopDB];
    char *errorMsg;
    NSString *insertSql;
    
    insertSql = [NSString stringWithFormat:@"insert into t_prizeInfo (phone, name, level, prize, type, createTime, remark) values('%@','%@','%@','%@','%@','%@','%@')",info.phone,info.name,info.level,info.prize,info.type,info.createTime,info.remark];
    
    sqlite3_exec(db, [insertSql UTF8String], NULL, NULL, &errorMsg);
    if (errorMsg != NULL) {
        NSLog(@"ERR:%s",errorMsg);
    }
    
    sqlite3_close(db);
    sqlite3_free(errorMsg);
}

//获取抽奖信息列表
+ (NSMutableArray *)getAllPrizeInfoList{
    sqlite3 *db = [ShopDB getShopDB];
    
    NSString *sql = [NSString stringWithFormat:@"select infoID,phone,name,level,prize,type,createTime,remark from t_prizeInfo"];
    sqlite3_stmt *statement;
    sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil);
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    while (sqlite3_step(statement) == SQLITE_ROW) {
        //NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        NSString *infoID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
        NSString *phone = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
        NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
        NSString *level = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
        NSString *prize = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
        NSString *type = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
        NSString *createTime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
        NSString *remark = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];

        PrizeInfoModel *m = [PrizeInfoModel new];
        m.infoID = infoID;
        m.phone = phone;
        m.name = name;
        m.level = level;
        m.prize = prize;
        m.type = type;
        m.createTime = createTime;
        m.remark = remark;
        [dataArray addObject:m];
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(db);
    return dataArray;
}

//获取抽奖信息列表
+ (NSMutableArray *)getAlreadyPrizeInfoList{
    sqlite3 *db = [ShopDB getShopDB];
    
    NSString *sql = [NSString stringWithFormat:@"select infoID,phone,name,level,prize,type,createTime,remark from t_prizeInfo where type = '1'"];
    sqlite3_stmt *statement;
    sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil);
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    while (sqlite3_step(statement) == SQLITE_ROW) {
        //NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        NSString *infoID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
        NSString *phone = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
        NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
        NSString *level = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
        NSString *prize = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
        NSString *type = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
        NSString *createTime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
        NSString *remark = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
        
        PrizeInfoModel *m = [PrizeInfoModel new];
        m.infoID = infoID;
        m.phone = phone;
        m.name = name;
        m.level = level;
        m.prize = prize;
        m.type = type;
        m.createTime = createTime;
        m.remark = remark;
        [dataArray addObject:m];
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(db);
    return dataArray;
}


//获取抽奖信息列表
+ (NSMutableArray *)getAbandonPrizeInfoList{
    sqlite3 *db = [ShopDB getShopDB];
    
    NSString *sql = [NSString stringWithFormat:@"select infoID,phone,name,level,prize,type,createTime,remark from t_prizeInfo where type = '0'"];
    sqlite3_stmt *statement;
    sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil);
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    while (sqlite3_step(statement) == SQLITE_ROW) {
        //NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        NSString *infoID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
        NSString *phone = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
        NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
        NSString *level = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
        NSString *prize = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
        NSString *type = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
        NSString *createTime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
        NSString *remark = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
        
        PrizeInfoModel *m = [PrizeInfoModel new];
        m.infoID = infoID;
        m.phone = phone;
        m.name = name;
        m.level = level;
        m.prize = prize;
        m.type = type;
        m.createTime = createTime;
        m.remark = remark;
        [dataArray addObject:m];
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(db);
    return dataArray;
}

@end
