//
//  LocalUserDefaulManager.h
//  LocalArchiverManager
//
//  Created by grx on 2018/8/17.
//  Copyright © 2018年 grx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalUserDefaulManager : NSObject

/**  单例模式，获取请求管理类 */
+ (LocalUserDefaulManager *)shareManagement;

/** 存储用户偏好设置到NSUserDefults */
- (void)saveUserDataWithKey:(id)data forKey:(NSString*)key;

/** 读取用户偏好设置 */
- (id)readUserDataWithKey:(NSString*)key;

/** 删除用户偏好设置 */
-(void)removeUserDataWithkey:(NSString*)key;

@end
