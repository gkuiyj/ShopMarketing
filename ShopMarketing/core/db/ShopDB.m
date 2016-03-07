//
//  ShopDB.m
//  ShopMarketing
//
//  Created by kaiser on 16/3/5.
//  Copyright © 2016年 kaiser. All rights reserved.
//

#import "ShopDB.h"

@implementation ShopDB

- (id)init {
    self = [super init];
    if (self) {
        sqlite3_open([[ShopDB getShopDBPath] UTF8String], &database);
        //开奖的信息表
        [self createTable:"create table if not exists t_prizeInfo(infoID integer PRIMARY KEY autoincrement,phone text,name text,level text,prize text,type text,createTime text,remark text)"];
        //下载中的文件信息表
        //[self createTable:"create table if not exists t_tempFiles(fileID integer PRIMARY KEY autoincrement,fileName text,fileSize text,tempPath text, targetPath text,fileImage text,fileType text,fileCategory text,folderName text,createTime text,fileURL text,fileReceivedSize text, fileGuid text,userGuid text)"];
    }
    NSLog(@"========= ShopDB init ========");
    return self;
}

//建表操作
-(void)createTable:(char *)sql {
    char *errorMsg;
    sqlite3_exec(database, sql, NULL, NULL, &errorMsg);
    if (errorMsg != NULL) {
        NSLog(@"＝＝＝ ERR:%s",errorMsg);
    }
}

+ (NSString *)getShopDBPath {
    NSArray *documentsPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dbFilePath = [[documentsPaths objectAtIndex:0]stringByAppendingPathComponent:@"ShopDB"];
    return dbFilePath;
}

+ (sqlite3 *)getShopDB {
    sqlite3 *shopDB;
    sqlite3_open([[ShopDB getShopDBPath] UTF8String], &shopDB);
    return shopDB;
}
@end
