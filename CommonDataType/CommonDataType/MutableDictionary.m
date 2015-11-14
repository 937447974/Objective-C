//
//  MutableDictionary.m
//  CommonDataType
//
//  Created by yangjun on 15/10/13.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "MutableDictionary.h"

@implementation MutableDictionary

- (instancetype)init {
    
    self = [super init];
    if (self) {
//        [self testCreatingAndInitializing]; // 初始化
//        [self testAddingEntries];           // 增加
//        [self testRemovingEntries];         // 删除记录
    }
    return self;
}

#pragma mark 初始化
- (void)testCreatingAndInitializing {
    
    // 创建包含一个key-value的可变字典。
    NSMutableDictionary *mDictionary = [NSMutableDictionary dictionaryWithCapacity:1];
    mDictionary = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    // 空字典
    mDictionary = [NSMutableDictionary dictionary];
    mDictionary = [[NSMutableDictionary alloc] init];
    
}

#pragma mark 增加记录
- (void)testAddingEntries {
    
    NSMutableDictionary *mDictionary = [NSMutableDictionary dictionary];
    
    // 增加单一记录
    [mDictionary setObject:@"阳君" forKey:@"name"];
    [mDictionary setObject:@"937447974" forKeyedSubscript:@"qq"];
    [mDictionary setValue:@"937447974@qq.com" forKey:@"email"];
    
    // 从字典中增加数据
    NSDictionary *dictionary = [NSDictionary dictionaryWithObject:@"IOS" forKey:@"development"];
    [mDictionary addEntriesFromDictionary:dictionary];
    
    // 用新的字典数据覆盖原有字典数据
    [mDictionary setDictionary:dictionary];
    
}

#pragma mark 删除记录
- (void)testRemovingEntries {
    
    NSMutableDictionary *mDictionary = [NSMutableDictionary dictionary];
    
    // 增加单一记录
    [mDictionary setObject:@"阳君" forKey:@"name"];
    [mDictionary setObject:@"937447974" forKeyedSubscript:@"qq"];
    [mDictionary setValue:@"937447974@qq.com" forKey:@"email"];
    [mDictionary setValue:@"IOS" forKey:@"development"];
    
    // 根据key删除单一记录
    [mDictionary removeObjectForKey:@"qq"];
    
    // 批量删除多个key对应的记录
    NSArray *keys = [NSArray arrayWithObject:@"email"];
    [mDictionary removeObjectsForKeys:keys];
    
    // 删除所有记录
    [mDictionary removeAllObjects];
    
}


@end
