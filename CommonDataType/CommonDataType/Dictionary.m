//
//  Dictionary.m
//  CommonDataType
//
//  Created by yangjun on 15/10/13.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "Dictionary.h"

@implementation Dictionary

- (instancetype)init {
    
    self = [super init];
    if (self) {
        // NSDictionary测试
//        [self testCreating]; // 创建字典(+)
//        [self testInitializing]; // 初始化字典(-)
//        [self testCountingEntries]; // 计算个数
//        [self testComparingDictionaries]; // 字典比较
//        [self testAccessingKeysAndValues];  // 访问键和值
//        [self testEnumerating];             // 遍历
//        [self testSorting]; // 排序
//        [self testFiltering]; // 过滤
//        [self testStoring]; // 存储
//        [self testAccessingFileAttributes]; // 访问文件属性
    }
    return self;
    
}

#pragma mark 测试数据
- (NSString *)testData {
    
    // 获取应用中Document文件夹
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // 测试数据
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"阳君", @"name", @"937447974", @"qq", nil];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];
    [dict writeToFile:filePath atomically:YES]; // 输入写入
    return filePath;
    
}

#pragma mark - 创建字典(+)
- (void)testCreating {
    
    // 空字典
    NSDictionary *dictionary = [NSDictionary dictionary];
    
    // 测试数据
    NSString *filePath = [self testData];
    
    // 通过文件路径创建字典
    dictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
    dictionary = [NSDictionary dictionaryWithContentsOfURL:[NSURL fileURLWithPath:filePath]];
    
    // 通过字典生成一个新的字典
    dictionary = [NSDictionary dictionaryWithDictionary:dictionary];
    
    // 生成只有一个键-值对的字典
    dictionary = [NSDictionary dictionaryWithObject:@"value" forKey:@"key"];
    
    // 根据两个数组合并生成包含多个键-值对的字典
    NSArray *values = [NSArray arrayWithObjects:@"阳君", @"937447974", nil];
    NSArray *keys = [NSArray arrayWithObjects:@"name", @"qq", nil];
    dictionary = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    
    // 坑，不建议使用了
    dictionary = [NSDictionary dictionaryWithObjects:&values forKeys:&keys count:2];
    
    // 生成包含多个键-值对的字典。数据的顺序为value，key，nil
    dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"阳君", @"name", @"937447974", @"qq", nil];
    
}

#pragma mark 初始化字典(-)
- (void)testInitializing {
    
    // 空字典
    NSDictionary *dictionary = [[NSDictionary alloc] init];
    
    // 测试数据
    NSString *filePath = [self testData];
    
    // 通过文件路径创建字典
    dictionary = [[NSDictionary alloc] initWithContentsOfURL:[NSURL fileURLWithPath:filePath]];
    dictionary = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    
    // 通过字典生成一个新的字典
    dictionary = [[NSDictionary alloc] initWithDictionary:dictionary];
    dictionary = [[NSDictionary alloc] initWithDictionary:dictionary copyItems:YES];
    
    // 根据两个数组合并生成包含多个键-值对的字典
    NSArray *values = [NSArray arrayWithObjects:@"阳君", @"937447974", nil];
    NSArray *keys = [NSArray arrayWithObjects:@"name", @"qq", nil];
    dictionary = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
    
    // 坑，不建议使用了
    dictionary = [[NSDictionary alloc] initWithObjects:&values forKeys:&keys count:2];
    
    // 生成包含多个键-值对的字典。数据的顺序为value，key，nil
    dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"阳君", @"name", @"937447974", @"qq", nil];
    
}

#pragma mark 计算个数
- (void)testCountingEntries {
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"阳君", @"name", @"937447974", @"qq", nil];
    
    // 字典内的key-value个数,
    NSUInteger count = dictionary.count; // output:2
    NSLog(@"count:%lu", (unsigned long)count);
    
}

#pragma mark 比较
- (void)testComparingDictionaries {
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"阳君", @"name", @"937447974", @"qq", nil];
    NSDictionary *dictionary1 = [NSDictionary dictionaryWithObjectsAndKeys:@"阳君", @"name", @"937447974", @"qq", nil];
    
    // 比较字典中的数据是否一致
    BOOL isEqual = [dictionary isEqualToDictionary:dictionary1];
    NSLog(@"isEqualToDictionary:%d", isEqual);// out 1
    
}

#pragma mark 访问键和值
- (void)testAccessingKeysAndValues {
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"阳君", @"name", @"阳君", @"name1", @"937447974", @"qq", nil];
    
    // 所有的keys
    NSArray *keys = dictionary.allKeys; // output:[qq,name,name1]
    
    // 根据value获取keys，可能多个key指向
    keys = [dictionary allKeysForObject:@"阳君"]; // output:[name,name1]
    
    // 所有的keys
    NSArray *values = dictionary.allValues; // output:[937447974, 阳君, 阳君]
    
    // 根据key提取value,，
    NSString *value = [dictionary objectForKey:@"name"]; // output:阳君
    value = [dictionary valueForKey:@"name"]; // output:阳君
    value = [dictionary objectForKeyedSubscript:@"name"];// output:阳君
    
    // 根据多个key获取多个value,如果没找到
    values = [dictionary objectsForKeys:keys notFoundMarker:@""];// output:[阳君, 阳君]
    
}

#pragma mark 遍历
- (void)testEnumerating {
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"阳君", @"name", @"937447974", @"qq", nil];
    
    // 遍历keys
    NSEnumerator *enumerator = [dictionary keyEnumerator];
    id key;
    while (key = [enumerator nextObject]) {
        NSLog(@"key:%@", key);
    }
    
    // 遍历values
    enumerator = [dictionary objectEnumerator];
    id value;
    while (value = [enumerator nextObject]) {
        NSLog(@"value:%@", value);
    }
    
    // 快速遍历key
    for (id key in dictionary) {
        id value = [dictionary objectForKey:key];
        NSLog(@"%@=%@", key, value);
    }
    
    // key-value遍历
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"key:%@; value:%@", key, obj);
        *stop = YES;// 当stop设为YES时，会停止遍历
    }];
    
    [dictionary enumerateKeysAndObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"key:%@; value:%@", key, obj);
        *stop = YES;// 当stop设为YES时，会停止遍历,必须设NSEnumerationReverse
    }];
    
}

#pragma mark 排序
- (void)testSorting {
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"阳君", @"name", @"937447974", @"qq", nil];
    
    // 使用Selector比较获取key, compare:由对象去实现
    NSArray *array = [dictionary keysSortedByValueUsingSelector:@selector(compare:)];
    
    // 使用block比较value,排序key
    array = [dictionary keysSortedByValueUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    
    array = [dictionary keysSortedByValueWithOptions:NSSortStable usingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
}

#pragma mark 过滤
- (void)testFiltering {
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"阳君", @"name", @"937447974", @"qq", nil];
    
    // 返回过滤后的keys
    NSSet *set = [dictionary keysOfEntriesPassingTest:^BOOL(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        // stop 是否停止过滤
        // return 通过yes，禁止no
        return YES;
    }];
    
    // 多核过滤
    set = [dictionary keysOfEntriesWithOptions:NSEnumerationConcurrent passingTest:^BOOL(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        // stop 是否停止过滤
        // return 通过yes，禁止no
        return YES;
    }];
    
}

#pragma mark 存储
- (void)testStoring {
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"阳君", @"name", @"937447974", @"qq", nil];
    
    NSString *filePath = [self testData];
    
    // 根据路径存储字典
    BOOL write = [dictionary writeToFile:filePath atomically:YES];
    
    write = [dictionary writeToURL:[NSURL fileURLWithPath:filePath] atomically:YES];
    
    [dictionary fileCreationDate];
    
}

#pragma mark 访问文件属性
- (void)testAccessingFileAttributes {
    
    NSString *filePath = [self testData];
    
    // 不懂NSFileManager的可研读http://blog.csdn.net/y550918116j/article/details/49095679
    NSError *error;
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:&error];
    
    NSLog(@"创建时间:%@", dictionary.fileCreationDate);
    NSLog(@"是否可见:%d", dictionary.fileExtensionHidden);
    NSLog(@"组ID:%@", dictionary.fileGroupOwnerAccountID);
    NSLog(@"组名:%@", [dictionary fileGroupOwnerAccountName]);
    NSLog(@"HFS编码:%u", (unsigned int)dictionary.fileHFSCreatorCode);
    NSLog(@"HFS类型编码:%u", (unsigned int)dictionary.fileHFSTypeCode);
    NSLog(@"是否只读:%d", dictionary.fileIsAppendOnly);
    NSLog(@"是否可修改:%d", dictionary.fileIsImmutable);
    NSLog(@"修改时间:%@", dictionary.fileModificationDate);
    NSLog(@"所有者ID:%@", dictionary.fileOwnerAccountID);
    NSLog(@"所有者名:%@", dictionary.fileOwnerAccountName);
    NSLog(@"Posix权限:%lu", (unsigned long)dictionary.filePosixPermissions);
    NSLog(@"大小:%llu", dictionary.fileSize);
    NSLog(@"系统文件数量:%lu", (unsigned long)dictionary.fileSystemFileNumber);
    NSLog(@"文件系统的数量:%ld", (long)dictionary.fileSystemNumber);
    NSLog(@"文件类型:%@", dictionary.fileType);
    
}

@end
