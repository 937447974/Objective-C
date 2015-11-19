//
//  NSLog+Extension.m
//  NSLog
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/11/17.
//  Copyright © 2015年 阳君. All rights reserved.
//

#import "NSLog+Extension.h"

#pragma mark -  NSLog打印辅助方法
id logExtension(id obj) {
    id tempObj = obj;
    // 遇到NSArray或NSDictionary的子类，内容后移\t
    if ([obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSArray class]]) {
        NSString *str = [NSString stringWithFormat:@"%@", obj];
        str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"];
        tempObj = str;
    }
    return tempObj;
}


#pragma mark - 数组NSLog打印扩展
@implementation NSArray (NSLogExtension)

#pragma mark 数组打印
- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *str = [NSMutableString stringWithString:@"(\n"];
    // 遍历数组的所有元素
    for (id obj in self) {
        [str appendFormat:@"\t%@,\n", logExtension(obj)];
    }
    [str appendString:@")"];
    return str;
}

@end

#pragma mark - 字典NSLog打印扩展
@implementation NSDictionary (NSLogExtension)

#pragma mark 字典打印
- (NSString *)descriptionWithLocale:(id)locale {
    __block NSMutableString *str = [NSMutableString stringWithString:@"{\n"];
    // 遍历字典的所有键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [str appendFormat:@"\t%@ = %@,\n", key, logExtension(obj)];
    }];
    [str appendString:@"}"];
    // 删掉最后一个,
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    // 保护机制找到才删除
    if (range.location > 0 && range.location < str.length) {
        [str deleteCharactersInRange:range];
    }
    return str;
}

@end
