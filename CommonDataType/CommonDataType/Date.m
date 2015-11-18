//
//  Date.m
//  CommonDataType
//
//  Created by yangjun on 15/10/15.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "Date.h"

@implementation Date

- (instancetype)init {
    
    self = [super init];
    if (self) {
//        [self testCreatingAndInitializing]; // 初始化
//        [self testGettingTemporalBoundaries]; // 时间边界
//        [self testComparing]; // 时间比较
//        [self testGettingTimeIntervals]; // 时间间隔
//        [self testAddingTimeInterval]; // 添加一个时间间隔
//        [self testRepresentingDatesAsStrings];
    }
    return self;
}

#pragma mark 初始化
- (void)testCreatingAndInitializing {
    
    // 初始化(+)
    // 当前系统时间，获取的为美国时区
    NSDate *date = [NSDate date];
    // 以当前系统时间为起点，前进10秒
    date = [NSDate dateWithTimeIntervalSinceNow:10];
    // 以date为起点，前进10秒
    date = [NSDate dateWithTimeInterval:10 sinceDate:date];
    // 以2001-01-01 00:00:00为起点，前进10秒
    date = [NSDate dateWithTimeIntervalSinceReferenceDate:10];
    // 以1970-01-01 00:00:00为起点，前进10秒
    date = [NSDate dateWithTimeIntervalSince1970:10];
   
    // 初始化(-)
    date = [[NSDate alloc] init];
    date = [[NSDate alloc] initWithTimeIntervalSinceNow:10];
    date = [[NSDate alloc] initWithTimeInterval:10 sinceDate:date];
    date = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:10];
    date = [[NSDate alloc] initWithTimeIntervalSince1970:10];
    
}

#pragma mark 时间边界
- (void)testGettingTemporalBoundaries {
    // NSDate生成的时间边界
    
    // 时间最大值，output 4001-01-01 00:00:00 +0000
    NSDate *date = [NSDate distantFuture];
    
    // 时间最小值 output 0000-12-30 00:00:00 +0000
    date = [NSDate distantPast];

}

#pragma mark 时间比较
- (void)testComparing {
    
    NSDate *date1 = [NSDate date];
    NSDate *date2 = [NSDate dateWithTimeInterval:10 sinceDate:date1];
    
    BOOL isEqual = [date1 isEqualToDate:date2];
    NSLog(@"isEqual:%d", isEqual);
    
    // 返回小的时间
    NSDate *date = [date1 earlierDate:date2];
    
    // 返回大的时间
    date = [date1 laterDate:date2];
    
    // 时间比较，<、=、>
    NSComparisonResult result = [date1 compare:date2];
    switch (result) {
        case NSOrderedAscending:
            NSLog(@"<");
            break;
        case NSOrderedSame:
            NSLog(@"=");
            break;
        case NSOrderedDescending:
            NSLog(@">");
            break;
    }
    
}

#pragma mark 时间间隔
- (void)testGettingTimeIntervals {
    
    NSDate *date1 = [NSDate date];
    NSDate *date2 = [NSDate dateWithTimeInterval:10 sinceDate:date1];
    
    // date1与date2间隔的秒数
    NSTimeInterval timeInterval = [date1 timeIntervalSinceDate:date2];
    
    // date2与当前时间间隔的秒数
    timeInterval = [date2 timeIntervalSinceNow];
    
    // date2与2001-01-01 00:00:00间隔的秒数
    timeInterval = [date2 timeIntervalSinceReferenceDate];
    
    // 当前时间与1970-01-01 00:00:00间隔的秒数
    timeInterval = [date2 timeIntervalSince1970];
    
    // 当前时间与2001-01-01 00:00:00间隔的秒数
    timeInterval = [NSDate timeIntervalSinceReferenceDate];
    
}

#pragma mark 添加一个时间间隔
- (void)testAddingTimeInterval {
    
    NSDate *date = [NSDate date];
   
    // 返回一个以date为起点增加10秒的NSDate
    date = [date dateByAddingTimeInterval:10];

}

#pragma mark 时间的描述信息
- (void)testRepresentingDatesAsStrings {
    
    NSDate *date = [NSDate date];
    
    NSString *description = date.description;
    NSLog(@"%@", description);
    
    // 当前用户选择的时区
    NSLocale *locale = [NSLocale autoupdatingCurrentLocale];
    description = [date descriptionWithLocale:locale];
     NSLog(@"%@", description);
    
}

@end
