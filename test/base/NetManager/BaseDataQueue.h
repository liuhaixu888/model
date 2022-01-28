//
//  BaseDataQueue.h
//  GKiOSApp
//
//  Created by wangws1990 on 2017/5/15.
//  Copyright © 2017 wangws1990. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseDataQueue : NSObject
/**
 *  @brief 插入数据
 */
+ (void)insertDataToDataBase:(NSString *)tableName
                   primaryId:(NSString *)primaryId
                    userInfo:(NSDictionary *)userInfo
                  completion:(void(^)(BOOL success))completion;
/**
 *  @brief 数据更新
 */
+ (void)updateDataToDataBase:(NSString *)tableName
                   primaryId:(NSString *)primaryId
                    userInfo:(NSDictionary *)userInfo
                  completion:(void(^)(BOOL success))completion;
/**
 *  @brief 删除数据
 */
+ (void)deleteDataToDataBase:(NSString *)tableName
                   primaryId:(NSString *)primaryId
                primaryValue:(NSString *)primaryValue
                  completion:(void(^)(BOOL success))completion;
+ (void)deleteDataToDataBase:(NSString *)tableName
                   primaryId:(NSString *)primaryId
                    listData:(NSArray <NSDictionary *>*)listData
                  completion:(void(^)(BOOL success))completion;
/**
 *  @brief 使用事务来处理批量插入数据问题 效率比较高
 */
+ (void)insertDatasDataBase:(NSString *)tableName
                  primaryId:(NSString *)primaryId
                   listData:(NSArray <NSDictionary *>*)listData
                 completion:(void(^)(BOOL success))completion;
/**
 *  @brief 获取数据
 */
+ (void)getDatasFromDataBase:(NSString *)tableName
                   primaryId:(NSString *)primaryId
                  completion:(void(^)(NSArray <NSDictionary *>*listData))completion;
+ (void)getDatasFromDataBase:(NSString *)tableName
                   primaryId:(NSString *)primaryId
                primaryValue:(NSString *)primaryValue
                  completion:(void(^)(NSDictionary *dictionary))completion;
/**
 *  @brief 删除表
 */
+ (void)dropTableDataBase:(NSString *)tableName
               completion:(void (^)(BOOL))completion;
@end

NS_ASSUME_NONNULL_END
