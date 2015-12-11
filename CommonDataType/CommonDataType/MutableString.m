//
//  MutableString.m
//  CommonDataType
//
//  Created by yangjun on 15/10/21.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "MutableString.h"

@implementation MutableString

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self testCreatingAndInitializing];
        [self testModifying];
    }
    return self;
}

#pragma mark 初始化
- (void)testCreatingAndInitializing {
    
    // 初始化字符串，并设置存储的大概长度
    NSMutableString *mString = [NSMutableString stringWithCapacity:10];
    mString = [[NSMutableString alloc] initWithCapacity:10];
    
}

#pragma mark 修改字符串
- (void)testModifying {
    
    NSMutableString *mString = [NSMutableString stringWithCapacity:10];
    
    // Format添加
    [mString appendFormat:@"%@;", @"阳君"];
    
    // 添加单一字符串
    [mString appendString:@"937447974"];
    
    // 删除指定范围的字符串
    NSRange range = {0, 3};
    [mString deleteCharactersInRange:range];
    
    // 指定位置后插入字符串
    [mString insertString:@"555555" atIndex:0];
    
    // 替换指定范围的字符串
    [mString replaceCharactersInRange:range withString:@"111"];
    
    // 将指定范围内的字符串替换为指定的字符串，并返回替换了几次
    NSUInteger index =  [mString replaceOccurrencesOfString:@"1" withString:@"23" options:NSCaseInsensitiveSearch range:range];
    NSLog(@"replaceOccurrencesOfString:%lu", (unsigned long)index);
    
    // 字符串全替换
    [mString setString:@"阳君"];
    
}

@end
