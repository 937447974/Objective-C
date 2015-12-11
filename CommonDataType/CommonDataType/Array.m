//
//  Array.m
//  CommonDataType
//
//  Created by yangjun on 15/10/14.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "Array.h"
#import "Users+Category.h"

/** sortedArrayUsingFunction排序*/
NSInteger sortByFunction(NSString * obj1, NSString * obj2, void * context) {
    return [obj1 compare:obj2];
}

@implementation Array

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self testCreating]; // 创建
        [self testInitializing]; // 初始化
        [self testQuerying]; // 查询
        [self testFindingObjects]; //查找对象位置
        [self testSendingMessagesToElements]; // 每个元素发送消息
        [self testComparing]; // 数组比较
        [self testDerivingNewArrays]; // 生成新数组
        [self testSorting]; // 排序
        [self testWorkingWithStringElements]; // 处理字符串数组
        [self testCreatingDescription]; // 存储
    }
    return self;
    
}

#pragma mark 测试数据
- (NSString *)testData {
    
    // 获取应用中Document文件夹
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // 测试数据
    NSArray *array = [NSArray arrayWithObjects:@"阳君", @"937447974", nil];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];
    BOOL write = [array writeToFile:filePath atomically:YES]; // 输入写入
    NSLog(@"writeToFile:%d", write);
    
    return filePath;
    
}

#pragma mark 创建(+)
- (void)testCreating {
    
    // 空数组
    NSArray *array = [NSArray array];
    
    // 根据数组创建数组
    array = [NSArray arrayWithArray:array];
    
    // 从文件获取
    NSString *filePath = [self testData];
    array = [NSArray arrayWithContentsOfFile:filePath];
    array = [NSArray arrayWithContentsOfURL:[NSURL fileURLWithPath:filePath]];
    
    // 包含一个数据的数组
    array = [NSArray arrayWithObject:@"阳君"];
    
    // 包含多个数据的数组
    array = [NSArray arrayWithObjects:@"阳君", @"937447974", nil];
    
}

#pragma mark 初始化(-)
- (void)testInitializing {
    
    // 空数组
    NSArray *array = [[NSArray alloc] init];
    
    // 根据数组创建数组
    array = [[NSArray alloc] initWithArray:array];
    array = [[NSArray alloc] initWithArray:array copyItems:YES];
    
    // 从文件获取
    NSString *filePath = [self testData];
    array = [[NSArray alloc] initWithContentsOfFile:filePath];
    array = [[NSArray alloc] initWithContentsOfURL:[NSURL fileURLWithPath:filePath]];
    
    // 包含多个数据的数组
    array = [[NSArray alloc] initWithObjects:@"阳君", @"937447974", nil];
    
}

#pragma mark 查询
- (void)testQuerying {
    
    NSArray<NSString *> *array = [NSArray arrayWithObjects:@"阳君", @"937447974", nil];
    
    // 数组中是否包含某个数据
    BOOL isContains = [array containsObject:@"阳君"];
    NSLog(@"containsObject:%d", isContains);
    
    // 数组长度
    NSInteger count = array.count; // 数组长度
    NSLog(@"count:%ld", (long)count);
    
    // 第一个数据
    NSString *str = array.firstObject;
    
    // 最后一个数据
    str = array.lastObject;
    
    // 取第0个位置的数据
    str = [array objectAtIndex:0];
    
    // 取第0个位置的数据
    str = [array objectAtIndexedSubscript:0];
    
    // 遍历
    NSEnumerator *enumerator = [array objectEnumerator];
    id anObject;
    while (anObject = [enumerator nextObject]) {
        NSLog(@"objectEnumerator:%@", anObject);
    }
    
    enumerator = [array reverseObjectEnumerator];
    while (anObject = [enumerator nextObject]) {
        NSLog(@"reverseObjectEnumerator:%@", anObject);
    }
    
    // 快速遍历
    for (anObject in array) {
        NSLog(@"forIn:%@", anObject);
    }

}

#pragma mark 查找对象位置
- (void)testFindingObjects {
    
    NSArray<NSString *> *array = [NSArray arrayWithObjects:@"阳君", @"937447974", @"IOS", nil];
    
    // 查找数据存在的位置
    NSInteger index = [array indexOfObject:@"937447974"];
    
    // 从指定的范围查找对象
    NSRange range = {0, array.count};
    index = [array indexOfObject:@"IOS" inRange:range];
    
    index = [array indexOfObjectIdenticalTo:@"937447974"];
    index = [array indexOfObjectIdenticalTo:@"937447974" inRange:range];
    
    // 自定义查找
    // 查找单个
    index = [array indexOfObjectPassingTest:^BOOL(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // *stop 是否停止
        // rutern,是否找到
        if ([@"937447974" isEqualToString:obj]) {
            *stop = YES;
            return YES;
        }
        return NO;
    }];
    
    // 多核查找单个
    index = [array indexOfObjectWithOptions:NSEnumerationConcurrent passingTest:^BOOL(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // *stop 是否停止
        // rutern,是否找到
        if ([@"937447974" isEqualToString:obj]) {
            *stop = YES;
            return YES;
        }
        return NO;
    }];
    
    // 查找多个
    NSIndexSet *set = [array indexesOfObjectsPassingTest:^BOOL(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([@"阳君" isEqualToString:obj] || [@"IOS" isEqualToString:obj]) {
            return YES;
        }
        return NO;
    }];
    
    // 多核查找多个
    set = [array indexesOfObjectsWithOptions:NSEnumerationConcurrent passingTest:^BOOL(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([@"阳君" isEqualToString:obj] || [@"IOS" isEqualToString:obj]) {
            return YES;
        }
        return NO;
    }];
    
}

#pragma mark 每个元素发送消息
- (void)testSendingMessagesToElements {
    
    NSArray *tArray = [NSArray array];
    NSArray *array = [NSArray arrayWithObjects:tArray, tArray, nil];
    
    // 通知数组中的每个元素执行方法
    [array makeObjectsPerformSelector:@selector(count)];
    
    // 携带参数发出通知
    [array makeObjectsPerformSelector:@selector(containsObject:) withObject:@"阳君"];
    
    // 自定义发出通知
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"enumerateObjectsUsingBlock：%lu", (unsigned long)idx);
    }];
    
    // 多核自定义通知
    [array enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"enumerateObjectsWithOptions：%lu", (unsigned long)idx);
    }];
    
    // 根据索引发出通知
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
    [array enumerateObjectsAtIndexes:indexSet options:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"enumerateObjectsAtIndexes：%lu", (unsigned long)idx);
    }];
    
}

#pragma mark 数组比较
- (void)testComparing {
    
    NSArray<NSString *> *array = [NSArray arrayWithObjects:@"阳君", @"937447974", @"IOS", nil];
    NSArray<NSString *> *array2 = [NSArray arrayWithObjects:@"yangj", @"937447974", nil];
    
    // 返回第一个相同的数据
    NSString *str = [array firstObjectCommonWithArray:array2];
    NSLog(@"firstObjectCommonWithArray：%@", str);
    
    // 数组内的内容是否相同
    BOOL isEqual = [array isEqualToArray:array2];
    NSLog(@"isEqual:%d", isEqual);
    
}

#pragma mark 生成新数组
- (void)testDerivingNewArrays {
    
    NSArray<NSString *> *array = [NSArray arrayWithObjects:@"阳君", @"937447974", nil];
    
    // 添加单个数据，并生成一个新的数组
    array = [array arrayByAddingObject:@"IOS"];
    
    // 添加多个数据，并返回一个新的数组
    array = [array arrayByAddingObjectsFromArray:array];
    
    // 通过过滤器筛选数组
    NSPredicate *predicate = [NSPredicate predicateWithValue:YES];
    array = [array filteredArrayUsingPredicate:predicate];
    
    // 通过范围生成数组
    NSRange range = {0, 2};
    array = [array subarrayWithRange:range];
    
}

#pragma mark 排序
- (void)testSorting {
    
    NSArray<NSString *> *array = [NSArray arrayWithObjects:@"阳君", @"937447974", @"IOS", nil];
    
    // Function 排序
    array = [array sortedArrayUsingFunction:sortByFunction context:nil];
    NSData *sortedArrayHint = array.sortedArrayHint;
    array = [array sortedArrayUsingFunction:sortByFunction context:nil hint:sortedArrayHint];
    
    // Selector 排序
    array = [array sortedArrayUsingSelector:@selector(compare:)];
    
    // Block排序
    array = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    // 并发block排序
    array = [array sortedArrayWithOptions:NSSortConcurrent usingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
}

#pragma mark 处理字符串数组
- (void)testWorkingWithStringElements {
    
    NSArray<NSString *> *array = [NSArray arrayWithObjects:@"阳君", @"937447974", @"IOS", nil];
    
    // 数组中的NSString元素拼接
    NSString *str = [array componentsJoinedByString:@","];
    NSLog(@"componentsJoinedByString:%@", str);
    
}

#pragma mark 存储
- (void)testCreatingDescription {
    
    NSArray<NSString *> *array = [NSArray arrayWithObjects:@"阳君", @"937447974", @"IOS", nil];
    
    // 描述信息
    NSString *description = array.description;
    description = [array descriptionWithLocale:nil];
    description = [array descriptionWithLocale:nil indent:1];
    
    // 获取应用中Document文件夹
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // 存储的路径
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];
    
    // 写入
    BOOL write = [array writeToFile:filePath atomically:YES];
    write = [array writeToURL:[NSURL fileURLWithPath:filePath] atomically:YES];
    
}

@end




