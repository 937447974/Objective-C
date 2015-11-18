//
//  MutableSet.m
//  CommonDataType
//
//  Created by yangjun on 15/10/21.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "MutableSet.h"

@implementation MutableSet

- (instancetype)init
{
    self = [super init];
    if (self) {
//        [self testCreating];
//        [self testAddingAndRemoving];
//        [self testCombiningAndRecombining];
    }
    return self;
}

#pragma mark 初始化
- (void)testCreating {
    
    // 创建可变集合，并设置初始的内部元素个数
    NSMutableSet *mSet = [NSMutableSet setWithCapacity:10];
    mSet = [[NSMutableSet alloc] initWithCapacity:10];
    
}

#pragma mark 增加和删除
- (void)testAddingAndRemoving {
    
    NSMutableSet *mSet = [NSMutableSet set];
    
    // 增加
    [mSet addObject:@"阳君"];
    
    // 同时增加多个对象
    NSArray *array = [NSArray arrayWithObjects:@"阳君", @"937447974", @"937447974", nil];
    [mSet addObjectsFromArray:array];

    // 过滤
    NSPredicate *predicate = [NSPredicate predicateWithValue:YES];
    [mSet filterUsingPredicate:predicate];
    
    // 删除单一对象
    [mSet removeObject:@"阳君"];
    
    // 删除全部
    [mSet removeAllObjects];
    
}

#pragma mark 结合和重组
- (void)testCombiningAndRecombining {
    
    NSMutableSet *mSet = [NSMutableSet setWithObjects:@"阳君", @"937447974", nil];
    NSMutableSet *mOtherSet = [NSMutableSet setWithObjects:@"阳君", @"IOS", nil];
    
    // 并集
    [mSet unionSet:mOtherSet];
    
    // 差集
    [mSet minusSet:mOtherSet];
    
    // 交集
    [mSet intersectSet:mOtherSet];
    
    // 全替换
    [mSet setSet:mOtherSet];
    
}

@end
