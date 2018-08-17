//
//  LocalArchiverManager.h
//  test
//
//  Created by grx on 2018/8/17.
//  Copyright © 2018年 grx. All rights reserved.
//

// LocalArchiverManager.h 文件

#import <Foundation/Foundation.h>

@interface LocalArchiverManager : NSObject

/**  单例模式，获取请求管理类 */
+ (LocalArchiverManager *)shareManagement;

/** 获取本地的序列化的路径 */
- (NSString *)gaintSaveLocalPathStr;

/** 清除本地的序列化的文件 */
- (void)clearArchiverData;

/** 保存缓存数据 */
- (void)saveDataArchiver:(id)obj andAPIKey:(NSString *)path;

/** 获取缓存数据 */
- (id)archiverQueryAPIKey:(NSString *)path;

@end


