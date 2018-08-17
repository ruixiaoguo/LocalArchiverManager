//
//  LocalUserDefaulManager.m
//  LocalArchiverManager
//
//  Created by grx on 2018/8/17.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LocalUserDefaulManager.h"

@implementation LocalUserDefaulManager

+ (LocalUserDefaulManager *)shareManagement
{
    static LocalUserDefaulManager *_defaulManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaulManager = [[LocalUserDefaulManager alloc]init];
    });
    return _defaulManager;
}

// 存储用户偏好设置到NSUserDefults
- (void)saveUserDataWithKey:(id)data forKey:(NSString*)key;
{
    if (data==nil || key==nil)
    {
        NSLog(@"存储%@失败",key);
        return;
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

//读取用户偏好设置
- (id)readUserDataWithKey:(NSString*)key
{
    id temp = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if(temp != nil)
    {
        return temp;
    }
    
    return nil;
}

//删除用户偏好设置
- (void)removeUserDataWithkey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}


@end
