//
//  Set.m
//  CommonDataType
//
//  Created by yangjun on 15/10/21.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "Set.h"

@implementation Set

- (instancetype)init
{
    self = [super init];
    if (self) {
//        [self testCreating]; // 创建Set
//        [self testInit];     // 初始化Set
//        [self testCountingEntries]; // 计算条目
//        [self testAccessingSetMembers]; // 访问成员变量
//        [self testComparingSets]; // 比较set
//        [self testSorting]; // 排序
    }
    return self;
}

#pragma mark 创建Set
- (void)testCreating {
   
    // 空set
    NSSet *set = [NSSet set];
    
    // 通过数组
    NSArray *array = [NSArray arrayWithObjects:@"阳君", @"937447974", @"937447974", nil];
    set = [NSSet setWithArray:array];
    
    // 只包含一个元素
    set = [NSSet setWithObject:@"阳君"];
   
    // 多个初始化
    set = [NSSet setWithObjects:@"阳君", @"937447974", nil];
    
    // 通过NSSet
    set = [NSSet setWithSet:set];
    
    // 增加一个元素
    set = [set setByAddingObject:@"937447974"];
    
    // 通过NSSet增加元素
    set = [set setByAddingObjectsFromSet:set];
    
    // 通过NSArray增加元素
    set = [set setByAddingObjectsFromArray:array];
    
}

#pragma mark 初始化Set
- (void)testInit {
    
    NSArray *array = [NSArray arrayWithObjects:@"阳君", @"937447974", nil];
    
    // 空set
    NSSet *set = [[NSSet alloc] init];
    
    // 通过数组
    set = [[NSSet alloc] initWithArray:array];
    
    // 多个初始化
    set = [[NSSet alloc] initWithObjects:@"阳君", @"937447974", nil];
    
    // 通过set
    set = [[NSSet alloc] initWithSet:set];
    set = [[NSSet alloc] initWithSet:set copyItems:YES];
    
}

#pragma mark 计算条目
- (void)testCountingEntries {
    
    NSSet *set = [NSSet setWithObjects:@"阳君", @"937447974", nil];
    NSLog(@"count:%lu", (unsigned long)set.count);
    
}

#pragma mark 访问Set成员
- (void)testAccessingSetMembers {
    
     NSSet<NSString *> *set = [NSSet setWithObjects:@"阳君", @"937447974", nil];
    
    // 所有成员
    NSArray *array = set.allObjects;
    NSLog(@"allObjects:%@", array);
    
    // 随机获取
    NSString *anyObject = [set anyObject];
    
    // 是否存在某个对象
    BOOL containsObject = [set containsObject:anyObject];
    NSLog(@"containsObject:%d", containsObject);
    
    // 通过过滤器过滤
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return YES;
    }];
    set = [set filteredSetUsingPredicate:predicate];
    
    // block 过滤
    set = [set objectsPassingTest:^BOOL(NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        return YES;
    }];
    
    // block 过滤, 并设置并发模式
    set = [set objectsWithOptions:NSEnumerationConcurrent passingTest:^BOOL(NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        return YES;
    }];
    
    // 给每个成员发送消息
    [set makeObjectsPerformSelector:@selector(length)];
    
    // 给每个成员发送消息并携带数据
    [set makeObjectsPerformSelector:@selector(hasPrefix:) withObject:@"阳君"];
    
    // 当存在这个对象时，返回这个对象
    NSString *member = @"阳君";
    member = [set member:member];
    
    // forIn 遍历
    for (id value in set) {
        NSLog(@"%@", value);
    }
    
    // enum遍历
    NSEnumerator *enumerator = [set objectEnumerator];
    id value;
    while (value = [enumerator nextObject]) {
        /* code that acts on the set’s values */
        NSLog(@"%@", value);
    }
    
    // block 遍历
    [set enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        
    }];
    
    // block 遍历, 并设置并发模式
    [set enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        
    }];

}

#pragma mark 比较Set
- (void)testComparingSets {
    
    NSSet<NSString *> *set = [NSSet setWithObjects:@"阳君", @"937447974", nil];
    NSSet<NSString *> *set2 = [NSSet setWithObjects:@"阳君", @"937447974", @"9374", nil];
    
    // 是否子集合
    BOOL isBool = [set isSubsetOfSet:set2];
    
    // 是否有交集
    isBool = [set intersectsSet:set2];
    
    // 是否相等
    isBool = [set isEqualToSet:set2];
    
}

#pragma mark 排序
- (void)testSorting {
    
    // 降序排列
    NSSet<NSString *> *set = [NSSet setWithObjects:@"1", @"3", @"2", nil];
    NSSortDescriptor *sortDes = [NSSortDescriptor sortDescriptorWithKey:nil ascending:NO];
    NSArray<NSSortDescriptor *> *sArray = [NSArray arrayWithObjects:sortDes, nil];
    NSArray<NSString *> *array = [set sortedArrayUsingDescriptors:sArray];
    NSLog(@"%@", array);
    
}

@end
