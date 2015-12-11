
//  String.m
//  CommonDataType
//
//  Created by yangjun on 15/10/19.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "String.h"

@implementation String

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self testCreatingAndInitializingStrings]; // 初始化字符串
        [self testCreatingAndInitializingFromFile]; // 通过NSString路径读取文件内容
        [self testCreatingAndInitializingFromURL]; // 通过NSURL路径读取文件内容
        [self testWritingFileOrURL]; // 写入
        [self testGettingLength]; // 获取字符串长度
        [self testGettingCharactersAndBytes]; // 获取Characters和Bytes
        [self testGettingCStrings]; // 获取C字符串
        [self testCombiningStrings]; // 增加字符串
        [self testDividingStrings]; // 分割字符串
        [self testFindingCharactersAndSubstrings]; // 查找字符串
        [self testReplacingSubstrings]; // 替换字符串
        [self testIdentifyingAndComparingStrings]; // 识别和比较字符串
        [self testFoldingStrings]; // 字符串折叠
        [self testGettingSharedPrefix]; // 获得共享的前缀
        [self testChangingCase]; // 大小写变化
        [self testGettingNumericValues]; // 得到数值
        [self testWorkingWithPaths]; // 使用路径
        [self testWorkingWithURLs]; // 使用URL
        
    }
    return self;
    
}

#pragma mark 测试数据
- (NSString *)testData {
    
    // 获取应用中Document文件夹
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // 测试数据
    NSString *string = @"阳君；937447974";
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];
    NSError *error;
    [string writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"错误：%@", error.localizedDescription);
    }
    return filePath;
    
}

#pragma mark - 初始化字符串
- (void)testCreatingAndInitializingStrings {
    
    // 空字符串
    NSString *string = [NSString string];
    string = [[NSString alloc] init];
    string = @"";
    
    // 通过字符串生成字符串
    string = [NSString stringWithString:string];
    string = [[NSString alloc] initWithString:string];
    string = string;
        
    // 组合生成NSString
    string = [NSString stringWithFormat:@"%@", @"阳君"];
    string = [[NSString alloc] initWithFormat:@"%@", @"阳君"];
    
    // 通过utf-8字符串
    string = [NSString stringWithUTF8String:string.UTF8String];
    string = [[NSString alloc] initWithUTF8String:string.UTF8String];
    
    // 通过C字符串
    const char *cStr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    string = [NSString stringWithCString:cStr encoding:NSUTF8StringEncoding];
    string = [[NSString alloc] initWithCString:cStr encoding:NSUTF8StringEncoding];
    
}

#pragma mark - 通过NSString路径读取文件内容
- (void)testCreatingAndInitializingFromFile {
    
    NSString *filePath = [self testData];
    NSError *error;
    
    // 指定编码格式读取
    NSString *string = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    string = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    // 自动打开，并返回解析的编码模式
    NSStringEncoding enc;
    string = [NSString stringWithContentsOfFile:filePath usedEncoding:&enc error:&error];
    string = [[NSString alloc] initWithContentsOfFile:filePath usedEncoding:&enc error:&error];
    
    if (error) {
        NSLog(@"错误：%@", error.localizedDescription);
    }
    
}

#pragma mark 通过NSURL路径读取文件内容
- (void)testCreatingAndInitializingFromURL {
    
    NSString *filePath = [self testData];
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    NSError *error;
    
    // 指定编码格式读取
    NSString *string = [NSString stringWithContentsOfURL:fileUrl encoding:NSUTF8StringEncoding error:&error];
    string = [[NSString alloc] initWithContentsOfURL:fileUrl encoding:NSUTF8StringEncoding error:&error];
    
    // 自动打开，并返回解析的编码模式
    NSStringEncoding enc;
    string = [NSString stringWithContentsOfURL:fileUrl usedEncoding:&enc error:&error];
    string = [[NSString alloc] initWithContentsOfURL:fileUrl usedEncoding:&enc error:&error];

    if (error) {
        NSLog(@"错误：%@", error.localizedDescription);
    }
    
}

#pragma mark 通过NSString或NSURL路径写入NSString
- (void)testWritingFileOrURL {
    
    NSString *filePath = [self testData];
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    NSError *error;
    NSString *string = @"阳君;937447974";
    
    // 指定编码格式写入
    BOOL write = [string writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    write = [string writeToURL:fileUrl atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        NSLog(@"错误：%@", error.localizedDescription);
    }
    
}

#pragma mark - 获取字符串长度
- (void)testGettingLength {
    
    NSString *string = @"阳君;937447974";
    
    // 长度
    NSInteger length = string.length;
    
    // 指定编码格式后的长度
    length = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];

    // 返回存储时需要指定的长度
    length  = [string maximumLengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    
}

#pragma mark 获取Characters和Bytes
- (void)testGettingCharactersAndBytes {
    
    NSString *string = @"YangJun;937447974";
    
    // 提取指定位置的character
    unichar uch = [string characterAtIndex:1];
    
    // 提取Bytes，并返回使用的长度
    NSUInteger length = [string maximumLengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    const void *bytes;
    NSRange range = {0, 5};
    BOOL gByte = [string getBytes:&bytes maxLength:length usedLength:&length encoding:NSUTF8StringEncoding options:NSStringEncodingConversionAllowLossy range:range remainingRange:nil];
    NSLog(@"%d", gByte);
    
    // 有问题
    //[string getCharacters:&uch range:range];
    
}

#pragma mark 获取C字符串
- (void)testGettingCStrings {
    
    NSString *string = @"阳君;937447974";
    
    // 指定编码格式,获取C字符串
    const char *c = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%s", c);
    
    // 获取通过UTF-8转码的字符串
    const char *UTF8String = [string UTF8String];
    NSLog(@"%s", UTF8String);

    /** 有线程问题
    char *cString;
    NSUInteger length = [string maximumLengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    BOOL bGet = [string getCString:cString maxLength:length encoding:NSUTF8StringEncoding];
    NSLog(@"%d, %s", bGet, cString);
     */
   
}

#pragma mark - 增加字符串
- (void)testCombiningStrings {
    
    NSString *string = @"阳君;937447974";
    
    // string后增加字符串并生成一个新的字符串
    string = [string stringByAppendingString:@";IOS"];
    
    // string后增加组合字符串并生成一个新的字符串
    string = [string stringByAppendingFormat:@";%@", @"OC"];
    
    // string后增加循环字符串，stringByPaddingToLength：完毕后截取的长度；startingAtIndex：从增加的字符串第几位开始循环增加。
    string = [string stringByPaddingToLength:30 withString:@";Swift" startingAtIndex:3];
    
}

#pragma mark 分割字符串
- (void)testDividingStrings {
    
    NSString *string = @"阳君;Yj937447974";
    
    // 根据指定的字符串分割成数组
    NSArray<NSString *> *array = [string componentsSeparatedByString:@";"];
    
    // 通过系统自带的分割方式分割字符串
    NSCharacterSet *set = [NSCharacterSet lowercaseLetterCharacterSet];
    array = [string componentsSeparatedByCharactersInSet:set];
    // 没啥用
    string = [string stringByTrimmingCharactersInSet:set];
    
    // 返回指定位置后的字符串
    string = @"阳君;937447974";
    string = [string substringFromIndex:3];
    
    // 返回指定范围的字符串
    string = @"阳君;937447974";
    NSRange range = {1, 3};
    string = [string substringWithRange:range];
    
    // 返回指定位置钱的字符串
    string = @"阳君;937447974";
    string = [string substringToIndex:3];
    
}

#pragma mark - 查找字符串
- (void)testFindingCharactersAndSubstrings {
    
    NSString *string = @"阳君;937447974";
    NSRange searchRange = {0, string.length};
    
    NSCharacterSet *set = [NSCharacterSet uppercaseLetterCharacterSet];
    // 根据NSCharacterSet查找
    NSRange range = [string rangeOfCharacterFromSet:set];
    
    // 根据NSCharacterSet查找,并选择查找模式
    range = [string rangeOfCharacterFromSet:set options:NSCaseInsensitiveSearch];
    
    // 根据NSCharacterSet查找,并选择查找模式，以及范围
    range = [string rangeOfCharacterFromSet:set options:NSCaseInsensitiveSearch range:searchRange];
    
    // 根据字符串查找
    range = [string rangeOfString:@"93"];
    range = [string rangeOfString:@"93" options:NSCaseInsensitiveSearch];
    range = [string rangeOfString:@"93" options:NSCaseInsensitiveSearch range:searchRange];
    range = [string rangeOfString:@"93" options:NSCaseInsensitiveSearch range:searchRange locale:nil];
    
    // block 查找
    [string enumerateLinesUsingBlock:^(NSString * _Nonnull line, BOOL * _Nonnull stop) {
        NSLog(@"%@", line);
        if ([@"93" isEqualToString:line]) {
            NSLog(@"search");
            *stop = YES;
        }
    }];
    
    // block查找，可设置查找方式，并得到找到的位置
    [string enumerateSubstringsInRange:searchRange options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        NSLog(@"%@", substring);
        if ([@"9" isEqualToString:substring]) {
            NSLog(@"location:%lu; length:%lu", (unsigned long)substringRange.location, (unsigned long)substringRange.length);
            NSLog(@"location:%lu; length:%lu", (unsigned long)enclosingRange.location, (unsigned long)enclosingRange.length);
            *stop = YES;
        }
    }];
    
}

#pragma mark 替换字符串
- (void)testReplacingSubstrings {
    
    NSString *string = @"阳君;937447974";
    NSRange searchRange = {0, string.length};
    
    // 全局替换
    string = [string stringByReplacingOccurrencesOfString:@";" withString:@";;"];
    
    // 设置替换的模式，并设置范围
    string = [string stringByReplacingOccurrencesOfString:@";" withString:@"-" options:NSCaseInsensitiveSearch range:searchRange];
    
    // 将指定范围的字符串替换为指定的字符串
    string = [string stringByReplacingCharactersInRange:searchRange withString:@"1"];
    
}

#pragma mark - 识别和比较字符串
- (void)testIdentifyingAndComparingStrings {
    
    NSString *string = @"阳君;937447974";
    NSString *compareStr = @"阳君;837447974";
    NSRange searchRange = {0, string.length};

    // 比较大小
    NSComparisonResult result = [string compare:compareStr];
    
    // 前缀比较
    BOOL isHas = [string hasPrefix:@"阳君"];
    
    // 后缀比较
    isHas = [string hasSuffix:@"4"];
    
    // 全比较是否相同
    isHas = [string isEqualToString:compareStr];
    
    // 通过指定的比较模式，比较字符串
     result = [string compare:compareStr options:NSCaseInsensitiveSearch];
    // 等价
    result = [string caseInsensitiveCompare:compareStr];
    // 添加比较范围
    result = [string compare:compareStr options:NSCaseInsensitiveSearch range:searchRange];
    // 增加比较地域
    result = [string compare:compareStr options:NSCaseInsensitiveSearch range:searchRange locale:nil];
    
    // 本地化字符串，再比较
    result = [string localizedCompare:compareStr];
    result = [string localizedStandardCompare:compareStr];
    // NSCaseInsensitiveSearch模式
    result = [string localizedCaseInsensitiveCompare:compareStr];
    
    // hash值
    NSUInteger hash = string.hash;
    NSLog(@"hash:%lu", (unsigned long)hash);
    
}

#pragma mark 字符串折叠
- (void)testFoldingStrings {
    
    NSString *string = @"阳君;937447974";
    
    // 前缀检验，如果相同，就返回前缀
    string = [string commonPrefixWithString:@"君;" options:NSCaseInsensitiveSearch];
    
}

#pragma mark 获得共享的前缀
- (void)testGettingSharedPrefix {
    
    NSString *string = @"阳君;937447974";
    NSString *compareStr = @"阳君;837447974";
    
    // 返回两个字符串相同的前缀
    string = [string commonPrefixWithString:compareStr options:NSCaseInsensitiveSearch];
    
}

#pragma mark - 大小写变化
- (void)testChangingCase {
    
    NSString *string = @"阳君;y937447974J";
    NSLocale *locale = [NSLocale currentLocale];
    
    // 全变大写
    NSString *result = string.capitalizedString;
    // 指定系统环境变化
    result =  [string capitalizedStringWithLocale:locale];
    
    // 全变大写
    result = string.uppercaseString;
    result = [string uppercaseStringWithLocale:locale];
    
    // 全变小写
    result = string.lowercaseString;
    result = [string lowercaseStringWithLocale:locale];

}

#pragma mark 得到数值
- (void)testGettingNumericValues {
    
    NSString *string = @"123";
    
    NSLog(@"doubleValue:%f", string.doubleValue);
    NSLog(@"floatValue:%f", string.floatValue);
    NSLog(@"intValue:%d", string.intValue);
    NSLog(@"integerValue:%ld", (long)string.integerValue);
    NSLog(@"longLongValue:%lld", string.longLongValue);
    NSLog(@"boolValue:%d", string.boolValue);
    
}

#pragma mark - 使用路径
- (void)testWorkingWithPaths {
    
    // 获取应用中Document文件夹
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    // 路径拆分为数组中的元素
    NSArray<NSString *> *pathComponents = documentsDirectory.pathComponents;
    // 将数组中的元素拼接为路径
    documentsDirectory = [NSString pathWithComponents:pathComponents];
   
    // 加载测试数据
    NSString *string = @"阳君；937447974";
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];
    [string writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    filePath = [documentsDirectory stringByAppendingPathComponent:@"test1.plist"];
    [string writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    // 寻找文件夹下包含指定扩展名的文件路径
    NSString *outputName;// 相同的前缀
    NSArray *filterTypes = [NSArray arrayWithObjects:@"txt", @"plist", nil];
    NSUInteger matches = [documentsDirectory completePathIntoString:&outputName caseSensitive:YES matchesIntoArray:&pathComponents filterTypes:filterTypes];
    NSLog(@"找到：%lu", (unsigned long)matches);
   
    // 添加路径
    filePath = [documentsDirectory stringByAppendingPathComponent:@"test"];
    // 添加扩展名
    filePath = [filePath stringByAppendingPathExtension:@"plist"];
    
    // 是否绝对路径
    NSLog(@"absolutePath:%d", filePath.absolutePath);
    
    // 最后一个路径名
    NSLog(@"lastPathComponent:%@", filePath.lastPathComponent);
    
    // 扩展名
    NSLog(@"pathExtension:%@", filePath.pathExtension);
    
    // 去掉扩展名
    string = filePath.stringByDeletingPathExtension;
    
    // 去掉最后一个路径
    string = filePath.stringByDeletingLastPathComponent;
    
    // 批量增加路径，并返回生成的路径
    pathComponents = [filePath stringsByAppendingPaths:pathComponents];
    
    // 没啥用
    string = filePath.stringByExpandingTildeInPath;
    string = filePath.stringByResolvingSymlinksInPath;
    string = filePath.stringByStandardizingPath;

}

#pragma mark 使用URL
- (void)testWorkingWithURLs {
    
    NSString *path = @"阳君/937447974";
    
    NSCharacterSet *set = [NSCharacterSet controlCharacterSet];
    
    // 转%格式码
    NSString *string = [path stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    // 转可见
    string = string.stringByRemovingPercentEncoding;
    
}

@end
