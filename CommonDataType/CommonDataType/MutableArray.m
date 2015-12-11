//
//  MutableArray.m
//  CommonDataType
//
//  Created by yangjun on 15/10/14.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "MutableArray.h"

/** sortedArrayUsingFunction排序*/
NSInteger mSortByFunction(NSString * obj1, NSString * obj2, void * context) {
    return [obj1 compare:obj2];
}

@implementation MutableArray

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self testCreatingAndInitializing];
        [self testAdding];
        [self testRemoving];
        [self testReplacing]; // 对象替换
        [self testFiltering]; // 过滤
        [self testSorting]; // 排序
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

#pragma mark 初始化
- (void)testCreatingAndInitializing {
    
    NSString *filePath = [self testData];
    
    // (+)创建
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:1];
    // 根据文件路径创建数组
    mArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    mArray = [NSMutableArray arrayWithContentsOfURL:[NSURL fileURLWithPath:filePath]];
    
    // (-)创建
    mArray = [[NSMutableArray alloc] initWithCapacity:1];
    mArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    mArray = [[NSMutableArray alloc] initWithContentsOfURL:[NSURL fileURLWithPath:filePath]];
    
}

#pragma mark 增加数据
- (void)testAdding {
    
    NSMutableArray *mArray = [NSMutableArray array];
    
    // 增加单一数据
    [mArray addObject:@"阳君"];
    
    // 批量添加数据
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", nil];
    [mArray addObjectsFromArray:array];
    
    // 指定位置插入单一数据
    [mArray insertObject:@"IOS" atIndex:1];
    
    // 指定位置插入多个数据
    NSRange range = {1, array.count};
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:range];
    [mArray insertObjects:array atIndexes:indexSet];
    
}

#pragma mark 删除数据
- (void)testRemoving {
    
    NSMutableArray *mArray = [NSMutableArray arrayWithObjects:@"阳君", @"937447974", @"IOS", nil];
    
    // 删除所有元素
    [mArray removeAllObjects];
    
    // 删除最后一个元素
    mArray = [NSMutableArray arrayWithObjects:@"阳君", @"937447974", @"IOS", nil];
    [mArray removeLastObject];
    
    // 根据位置删除对象
    mArray = [NSMutableArray arrayWithObjects:@"阳君", @"937447974", @"IOS", nil];
    [mArray removeObjectAtIndex:0];
    
    // 根据数组删除对象
    mArray = [NSMutableArray arrayWithObjects:@"阳君", @"IOS", @"937447974", @"IOS", nil];
    NSArray *array = [NSArray arrayWithObjects:@"IOS",@"阳君", nil];
    [mArray removeObjectsInArray:array];
    
    // 根据对象删除
    mArray = [NSMutableArray arrayWithObjects:@"阳君", @"IOS", @"937447974", @"IOS", nil];
    [mArray removeObject:@"IOS"];
    // 或
    mArray = [NSMutableArray arrayWithObjects:@"阳君", @"IOS", @"937447974", @"IOS", nil];
    [mArray removeObjectIdenticalTo:@"IOS"];
    
    // 删除指定范围内的对象
    NSRange range = {0, 2};// 第0个位置开始，连续2个
    mArray = [NSMutableArray arrayWithObjects:@"阳君", @"IOS", @"937447974", @"IOS", nil];
    [mArray removeObject:@"IOS" inRange:range];
    // 或
    mArray = [NSMutableArray arrayWithObjects:@"阳君", @"IOS", @"937447974", @"IOS", nil];
    [mArray removeObjectIdenticalTo:@"IOS" inRange:range];

    // 删除指定NSRange范围内的对象，批量删除
    mArray = [NSMutableArray arrayWithObjects:@"阳君", @"937447974", @"IOS", nil];
    [mArray removeObjectsInRange:range];
    // 或
    mArray = [NSMutableArray arrayWithObjects:@"阳君", @"937447974", @"IOS", nil];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
    [mArray removeObjectsAtIndexes:indexSet];

}

#pragma mark 替换对象
- (void)testReplacing {
    
    NSMutableArray *mArray = [NSMutableArray arrayWithObjects:@"阳君", @"937447974", @"IOS", nil];
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
    NSRange range = {0, array.count};// 第0个位置开始，连续count个
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
    
    // 指定位置替换对象
    [mArray replaceObjectAtIndex:0 withObject:@"yangj"];
    // or
    [mArray setObject:@"yangj" atIndexedSubscript:0];
    
    // 数组替换
    [mArray setArray:array];
    
    // 用array替换数组中指定位置的所有元素
    mArray = [NSMutableArray arrayWithObjects:@"阳君", @"937447974", @"IOS", nil];
    [mArray replaceObjectsInRange:range withObjectsFromArray:array];
    // or
    mArray = [NSMutableArray arrayWithObjects:@"阳君", @"937447974", @"IOS", nil];
    [mArray replaceObjectsAtIndexes:indexSet withObjects:array];
    
    // 局部替换，使用array中的部分元素替换目标数组指定位置的元素
    mArray = [NSMutableArray arrayWithObjects:@"阳君", @"937447974", @"IOS", nil];
    range.length = 2;
    [mArray replaceObjectsInRange:range withObjectsFromArray:array range:range];
    
}

#pragma mark 数组过滤
- (void)testFiltering {
    
    NSMutableArray *mArray = [NSMutableArray arrayWithObjects:@"阳君", @"937447974", @"IOS", nil];
    
    // 使用过滤器过滤数组中的元素
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        NSLog(@"%@", evaluatedObject);
        if ([@"937447974" isEqualToString:evaluatedObject]) {
            return YES;
        }
        return NO;
    }];
    [mArray filterUsingPredicate:predicate];
    
}

#pragma mark 排序
- (void)testSorting {
    
    NSMutableArray *mArray = [NSMutableArray arrayWithObjects:@"阳君", @"937447974", @"IOS", nil];
    
    // 交换两个位置的数据
    [mArray exchangeObjectAtIndex:0 withObjectAtIndex:1];
    
    // 对象自带的方法排序
    [mArray sortUsingSelector:@selector(compare:)];
    
    // Function排序
    [mArray sortUsingFunction:mSortByFunction context:nil];
    
    // block排序
    [mArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    [mArray sortWithOptions:NSSortConcurrent usingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
  
}

@end
