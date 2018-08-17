//
//  ViewController.m
//  LocalArchiverManager
//
//  Created by grx on 2018/8/17.
//  Copyright © 2018年 grx. All rights reserved.
//

#import "ViewController.h"
#import "persion.h"
#import "LocalArchiverManager.h"
#import "LocalUserDefaulManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /** 归档操作 */
    [self archverAction];
    /** 存储UserDefaul操作 */
    [self UserDefaulAction];
}

-(void)archverAction
{
    //1.创建对象
    persion *person = [[persion alloc] init];
    person.name=@"蜗牛";
    person.age=23;
    /** 存储 */
    [[LocalArchiverManager shareManagement]saveDataArchiver:person andAPIKey:@"persion"];
    /** 删除 */
    //    [[LocalArchiverManager shareManagement] clearArchiverData];
    /** 读取 */
    persion *per = [[LocalArchiverManager shareManagement]archiverQueryAPIKey:@"persion"];
    NSLog(@"per.name======%@",per.name);
}

-(void)UserDefaulAction
{
    /** 存储 */
    [[LocalUserDefaulManager shareManagement]saveUserDataWithKey:@"小白兔" forKey:@"bt"];
    /** 删除 */
    [[LocalUserDefaulManager shareManagement] removeUserDataWithkey:@"bt"];
    /** 读取 */
    NSString *str = [[LocalUserDefaulManager shareManagement] readUserDataWithKey:@"bt"];
    NSLog(@"stre======%@",str);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
