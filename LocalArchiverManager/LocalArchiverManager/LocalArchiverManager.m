//
//  LocalArchiverManager.m
//  test
//
//  Created by grx on 2018/8/17.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "LocalArchiverManager.h"

#define Document [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define ArchiverFile    [Document stringByAppendingPathComponent:@"Archiver"]

@interface LocalArchiverManager()

@property(nonatomic, strong) NSFileManager *fileManager;

@end

@implementation LocalArchiverManager

+ (LocalArchiverManager *)shareManagement
{
    static LocalArchiverManager *_LocalManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _LocalManager = [[LocalArchiverManager alloc]init];
    });
    return _LocalManager;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        self.fileManager = [NSFileManager defaultManager];
    }
    return self;
}

#pragma mark private methods
// 检测path路径文件是否存在
- (BOOL)checkPathIsExist:(NSString *)path
{
    return [_fileManager fileExistsAtPath:path isDirectory:nil];
}

// 创建文件
- (void)createArchiverFile
{
    if (![self checkPathIsExist:ArchiverFile])
    {
        [self addNewFolder:ArchiverFile];
    }
}

//新建目录,path为目录路径(包含目录名)
- (void)addNewFolder:(NSString *)path
{
    [_fileManager createDirectoryAtPath:path
            withIntermediateDirectories:YES
                             attributes:nil
                                  error:nil];
}

#pragma mark public methods

- (void)clearArchiverData
{
    NSError *error;
    if([_fileManager removeItemAtPath:ArchiverFile error:&error])
    {
        NSLog(@"删除成功");
    } else {
        NSLog(@"清除本地序列化的文件失败....:%@",error);
    }
}
// 保存数据
- (void)saveDataArchiver:(id)obj andAPIKey:(NSString *)path
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:obj forKey:path];
    [archiver finishEncoding];
    [self createArchiverFile];
    path = [path stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSString *pathStr = [ArchiverFile stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.text",path]];
    BOOL isSuc = [data writeToFile:pathStr atomically:YES];
    if(!isSuc) {
        NSLog(@"本地序列化失败key....:%@",path);
    }
}
// 获取数据
- (id)archiverQueryAPIKey:(NSString *)path
{
    NSString *str = [path stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSString *pathStr = [ArchiverFile stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.text",str]];
    NSMutableData *data = [[NSMutableData alloc] initWithContentsOfFile:pathStr];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    id content = [unarchiver decodeObjectForKey:path];
    [unarchiver finishDecoding];
    return content;
}

- (NSString *)gaintSaveLocalPathStr
{
    NSString *pathStr = [NSString stringWithFormat:@"%@",ArchiverFile];
    NSLog(@"获取本地存储路径===%@",pathStr);
    return pathStr;
}

@end
