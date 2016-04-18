//
//  ViewController.m
//  NSFileManager
//
//  Created by yangjun on 15/7/10.
//  Copyright (c) 2015年 阳君. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //    [self testCreatingFileManager];                          // 创建NSFileManager
        [self testLocatingSystemDirectories];                    // 获取系统目录
    //    [self testLocatingApplicationGroupContainerDirectories]; // 定位应用程序组容器目录
    //    [self testDiscoveringDirectoryContents];                 // 目录内容
    //    [self testCreatingAndDeletingItems];                     // 创建和删除项目
    //    [self testMovingAndCopyingItems];                        // 移动和复制
    //    [self testManagingICloudBasedItems];                     // 管理ICloud
    //    [self testDeterminingAccessToFiles];                     // 确定访问文件
    //    [self testGettingAndSettingAttributes];                  // 获取和设置属性
    //    [self testGettingAndComparingFileContents];              // 获取和比较文件内容
    //    [self testGettingRelationshipBetweenItems];              // 获取文件之间的关系
    //    [self testConvertingFilePathsToStrings];                 // 路径转字符串
    //    [self testManagingTheCurrentDirectory];                  // 路径处理
}

#pragma mark 创建NSFileManager
- (void)testCreatingFileManager {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 或
    fileManager = [[NSFileManager alloc] init];
    
}

#pragma mark 获取系统目录
- (void)testLocatingSystemDirectories {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    // 定位和选择创建指定的常见的目录域
    // 定位Library目录路径
    NSURL *url = [fileManager URLForDirectory:NSLibraryDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&error];
    NSLog(@"app_home_lib:%@", url);
    
    // tmp下创建临时目录
    url = [fileManager URLForDirectory:NSItemReplacementDirectory inDomain:NSUserDomainMask appropriateForURL:[NSURL URLWithString:@"test"] create:YES error:&error];
    NSLog(@"app_home_tmp:%@", url);
    
    // 获取Library目录路径
    NSArray *paths = [fileManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask];
    NSLog(@"app_home_lib:%@", paths);
    
}

#pragma mark 定位应用组目录
- (void)testLocatingApplicationGroupContainerDirectories {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 定位应用组目录，需在https://idmsa.apple.com/IDMSWebAuth/authenticate配置
    NSURL *groupURL = [fileManager containerURLForSecurityApplicationGroupIdentifier:@"idebtufuer"];
    NSLog(@"Application Group Container Directories:%@", groupURL);
    
}

#pragma mark 目录内容
- (void)testDiscoveringDirectoryContents {
    
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 获取应用沙盒下的目录路径
    NSURL *appHomeDir = [NSURL URLWithString:NSHomeDirectory()];
    NSArray *array = [fileManager contentsOfDirectoryAtURL:appHomeDir includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles error:&error];
    NSLog(@"contentsOfDirectoryAtURL:%@", array);
    
    // 获取应用沙盒下的文件或目录名
    array = [fileManager contentsOfDirectoryAtPath:NSHomeDirectory() error:&error];
    NSLog(@"contentsOfDirectoryAtPath:%@", array);
    
    // 获取应用沙盒下的所有目录和文件路径
    NSDirectoryEnumerator<NSURL *> *dirEnumerator = [fileManager enumeratorAtURL:appHomeDir includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles errorHandler:nil];
    for (NSURL *theURL in dirEnumerator) {
        NSLog(@"enumeratorAtURL:%@", theURL);
    }
    
    // 获取应用沙盒下的所有目录和文件的路径名
    NSDirectoryEnumerator<NSString *> *dirEnum = [fileManager enumeratorAtPath:NSHomeDirectory()];
    NSString *file;
    while (file = [dirEnum nextObject]) {
        NSLog(@"enumeratorAtPath:%@", file);
    }
    
    // 获取应用沙盒下的所有目录和文件的路径名
    array = [fileManager subpathsAtPath:NSHomeDirectory()];
    NSLog(@"subpathsAtPath:%@", array);
    
    // 获取应用沙盒下的所有目录和文件的路径名
    array = [fileManager subpathsOfDirectoryAtPath:NSHomeDirectory() error:&error];
    NSLog(@"subpathsOfDirectoryAtPath:%@", array);
    
}

#pragma mark 创建和删除
- (void)testCreatingAndDeletingItems {
    
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentURL = [fileManager URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&error];// 获取Document路径
    NSString *dirStr = [documentURL.path stringByAppendingPathComponent:@"directory"];
    NSURL *dirUrl = [NSURL URLWithString:dirStr];
    
    // 根据url路径创建
    BOOL create = [fileManager createDirectoryAtURL:dirUrl withIntermediateDirectories:YES attributes:nil error:&error];
    NSLog(@"createDirectoryAtURL:%d", create);
    
    // 根据url路径删除
    BOOL remove = [fileManager removeItemAtURL:dirUrl error:&error];
    NSLog(@"removeItemAtURL:%d", remove);
    
    // 根据string路径创建
    create = [fileManager createDirectoryAtPath:dirStr withIntermediateDirectories:YES attributes:nil error:&error];
    NSLog(@"createDirectoryAtPath:%d", create);
    
    // 根据string路径创建
    remove = [fileManager removeItemAtPath:dirStr error:&error];
    NSLog(@"removeItemAtPath:%d", remove);
    
    // 创建plist文件
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject:@"YangJun" forKey:@"937447974"];
    // 得到完整的文件名
    NSString *filename = [documentURL.path stringByAppendingPathComponent:@"test.plist"];
    // 写入
    [dict writeToFile:filename atomically:YES];
    
    // 文件路径替换
    NSString *replaceStr = [documentURL.path stringByAppendingPathComponent:@"test1.plist"];
    BOOL replace = [fileManager replaceItemAtURL:[NSURL URLWithString:replaceStr] withItemAtURL:dirUrl backupItemName:nil options:NSFileManagerItemReplacementUsingNewMetadataOnly resultingItemURL:nil error:&error];
    NSLog(@"replaceItemAtURL:%d", replace);
    
    // 清空
    [fileManager removeItemAtPath:filename error:&error];
    [fileManager removeItemAtPath:replaceStr error:&error];
    
}

#pragma mark 移动和复制
- (void)testMovingAndCopyingItems {
    
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentDireURL = [fileManager URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&error];// Document目录路径
    
    NSString *source = [documentDireURL.path stringByAppendingPathComponent:@"Source"];// 源路径
    NSString *to = [documentDireURL.path stringByAppendingPathComponent:@"To"];// 目标路径
    
    [fileManager createDirectoryAtPath:source withIntermediateDirectories:YES attributes:nil error:&error];// 创建文件夹
    
    // 复制
    BOOL copy = [fileManager copyItemAtPath:source toPath:to error:&error];
    // 等价
    // [fileManager copyItemAtURL:[NSURL URLWithString:source] toURL:[NSURL URLWithString:to] error:&error];
    [fileManager removeItemAtPath:to error:&error];
    
    // 移动
    [fileManager moveItemAtPath:source toPath:to error:&error];
    // 等价
    // [fileManager moveItemAtURL:[NSURL URLWithString:source] toURL:[NSURL URLWithString:to] error:&error];
    NSLog(@"copyItemAtPath:%d", copy);
    NSLog(@"NSDocumentDirectory:%@", [fileManager subpathsAtPath:documentDireURL.path]);
    
}

#pragma mark iCloud管理
- (void)testManagingICloudBasedItems {
    
    // 需在项目中开启ICloud。Targets->Capabilities
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    id ubiquityIdentityToken = fileManager.ubiquityIdentityToken;// ICloud的token
    if (!ubiquityIdentityToken) {
        NSLog(@"未登录iCLoud或项目未开启ICloud");
    }
    
    NSURL *iCloudUrl = [fileManager URLForUbiquityContainerIdentifier:nil];//iCloud 容器
    NSLog(@"iCloud容器:%@", iCloudUrl);
    
    BOOL isUbiquitousItemAtURL = [fileManager isUbiquitousItemAtURL:iCloudUrl];// 路径是否在iCloud上
    NSLog(@"isUbiquitousItemAtURL:%d", isUbiquitousItemAtURL);
    
    // 测试数据
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject:@"YangJun" forKey:@"937447974"];
    NSURL *documentDireURL = [fileManager URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&error];// Document目录路径
    NSString *fileUrlStr = [iCloudUrl.path stringByAppendingPathComponent:@"test.plist"];
    [dict writeToFile:fileUrlStr atomically:YES]; // 输入写入
    
    // 文件从本地移动到iCLoud 或 从iCLoud移动到本地
    [fileManager setUbiquitous:YES itemAtURL:[NSURL URLWithString:fileUrlStr] destinationURL:[NSURL URLWithString:[iCloudUrl.path stringByAppendingPathComponent:@"test.plist"]] error:&error];
    
    // 下载iCloud文件
    [fileManager startDownloadingUbiquitousItemAtURL:[NSURL URLWithString:fileUrlStr] error:&error];
    
    // 删除ICloud文件对应的本地副本
    [fileManager evictUbiquitousItemAtURL:[NSURL URLWithString:fileUrlStr] error:&error];
    
    // iCloud上的文件的分享地址，可以供其他人下载
    NSURL *downloadUrl =  [fileManager URLForPublishingUbiquitousItemAtURL:[NSURL URLWithString:fileUrlStr] expirationDate:nil error:&error];
    
    NSLog(@"NSDocumentDirectory:%@", [fileManager subpathsAtPath:documentDireURL.path]);
    NSLog(@"iCloudUrl:%@", [fileManager subpathsAtPath:iCloudUrl.path]);
    
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }
    

    // 清理iCloud
    NSDirectoryEnumerator<NSURL *> *dirEnumerator = [fileManager enumeratorAtURL:iCloudUrl includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles errorHandler:nil];
    for (NSURL *theURL in dirEnumerator) {
        [fileManager removeItemAtPath:theURL.path error:&error];// 删除
    }
    
}

#pragma mark 确定文件
- (void)testDeterminingAccessToFiles {
    
    NSFileManager *fileManager  = [NSFileManager defaultManager];
    
    BOOL fileExistsAtPath = [fileManager fileExistsAtPath:NSHomeDirectory()];// 文件是否存在
    NSLog(@"是否存在:%d", fileExistsAtPath);
    
    BOOL isDirectory = NO;// 是否系统文件
    // 文件是否存在
    fileExistsAtPath = [fileManager fileExistsAtPath:NSHomeDirectory() isDirectory:&isDirectory];
    NSLog(@"是否存在:%d;系统文件:%d", fileExistsAtPath, isDirectory);
    
    // 是否可读
    BOOL isReadableFile = [fileManager isReadableFileAtPath:NSHomeDirectory()];
    NSLog(@"是否可读:%d", isReadableFile);
    
    // 是否可写
    BOOL isWritableFile = [fileManager isWritableFileAtPath:NSHomeDirectory()];
    NSLog(@"是否可写:%d", isWritableFile);
    
    // 判断权限
    BOOL isExecutableFile = [fileManager isExecutableFileAtPath:NSHomeDirectory()];
    NSLog(@"是否有权限:%d", isExecutableFile);
    
    // 是否可删除
    BOOL isDeletableFile = [fileManager isDeletableFileAtPath:NSHomeDirectory()];
    NSLog(@"是否可删除:%d", isDeletableFile);
    
}

#pragma mark 获取和设置属性
- (void)testGettingAndSettingAttributes {
    
    NSError *error;
    NSFileManager *fileManager  = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // 路径分割
    NSArray *array = [fileManager componentsToDisplayForPath:documentsDirectory];
    NSLog(@"componentsToDisplayForPath：%@", array);
    
    // 当前路径的文件或文件夹名
    NSString *displayNameAtPath = [fileManager displayNameAtPath:documentsDirectory];
    NSLog(@"displayNameAtPath:%@", displayNameAtPath);
    
    // 获取文件属性
    NSDictionary *itemAttributes = [fileManager attributesOfItemAtPath:documentsDirectory error:&error];
    NSLog(@"attributesOfItemAtPath:%@",itemAttributes);
    
    // 获取文件所处的系统存储空间使用情况
    NSDictionary *fileAttributes = [fileManager attributesOfFileSystemForPath:documentsDirectory error:&error];
    NSLog(@"attributesOfFileSystemForPath:%@",fileAttributes);
    
    // 测试数据
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject:@"YangJun" forKey:@"937447974"];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];
    [dict writeToFile:filePath atomically:YES]; // 输入写入
    
    // 属性设置
    NSLog(@"%@", [fileManager attributesOfItemAtPath:filePath error:&error]);
    [fileManager setAttributes:[NSDictionary dictionaryWithObject:@"1" forKey:NSFileExtensionHidden] ofItemAtPath:filePath error:&error];// 文件隐藏
    NSLog(@"%@", [fileManager attributesOfItemAtPath:filePath error:&error]);
    
    if (error) {
        NSLog(@"错误：%@", error.localizedDescription);
    }
    
}

#pragma mark 获取和比较文件内容
- (void)testGettingAndComparingFileContents {
    
    NSFileManager *fileManager  = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // 测试数据
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject:@"YangJun" forKey:@"937447974"];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];
    [dict writeToFile:filePath atomically:YES]; // 输入写入
    
    // 文件读取
    NSData *data = [fileManager contentsAtPath:filePath];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];// NSData转NSString
    NSLog(@"contentsAtPath:%@", jsonString);
    
    // 文件内容比较
    NSString *filePath1 = [documentsDirectory stringByAppendingPathComponent:@"test1.plist"];
    [dict writeToFile:filePath1 atomically:YES]; // 输入写入
    BOOL contents = [fileManager contentsEqualAtPath:filePath andPath:filePath1];
    NSLog(@"contentsEqualAtPath:%d", contents);
    
}

#pragma mark 文件之间的关系
- (void)testGettingRelationshipBetweenItems {
    
    NSError *error;
    NSFileManager *fileManager  = [NSFileManager defaultManager];
    
    NSURLRelationship outRelationship;
    // 两个文件的关系
    [fileManager getRelationship:&outRelationship ofDirectoryAtURL:[NSURL URLWithString:NSHomeDirectory()] toItemAtURL:[NSURL URLWithString:NSTemporaryDirectory()] error:&error];
    
    // 文件和指定系统路径之间的关系
    [fileManager getRelationship:&outRelationship ofDirectory:NSDocumentDirectory inDomain:NSUserDomainMask toItemAtURL:[NSURL URLWithString:NSTemporaryDirectory()] error:&error];
    
    if (error) {
        NSLog(@"错误：%@", error.localizedDescription);
    }
    
}

#pragma mark 文件路径转字符串
- (void)testConvertingFilePathsToStrings {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 路径转char
    const char *c = [fileManager fileSystemRepresentationWithPath:NSHomeDirectory()];
    
    NSLog(@"fileSystemRepresentationWithPath:%s", c);
    
    // 从char中获取指定长度的路径
    NSString *s = [fileManager stringWithFileSystemRepresentation:c length:10];
    NSLog(@"stringWithFileSystemRepresentation:%@", s);
}

#pragma mark 当前目录管理
- (void)testManagingTheCurrentDirectory {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 获取当前工作目录
    NSLog(@"currentDirectoryPath:%@", fileManager.currentDirectoryPath);
    // 改变当前工作目录到指定的文件夹
    [fileManager changeCurrentDirectoryPath:NSHomeDirectory()];
    NSLog(@"currentDirectoryPath:%@", fileManager.currentDirectoryPath);
    
}

#pragma mark - 获取应用沙盒根路径
-(void)dirHome {
    NSString *dirHome = NSHomeDirectory();
    NSLog(@"app_home: %@",dirHome);
}

#pragma mark 获取Documents目录路
-(NSString *)dirDoc {
    //[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"app_home_doc: %@",documentsDirectory);
    return documentsDirectory;
}

#pragma mark 获取Library目录路径
-(void)dirLib {
    //[NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = [paths objectAtIndex:0];
    NSLog(@"app_home_lib: %@",libraryDirectory);
}

#pragma mark 获取Cache目录路径
-(void)dirCache {
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    NSLog(@"app_home_lib_cache: %@",cachePath);
}

#pragma mark 获取Tmp目录路径
-(void)dirTmp {
    //[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
    NSString *tmpDirectory = NSTemporaryDirectory();
    NSLog(@"app_home_tmp: %@",tmpDirectory);
}

@end
