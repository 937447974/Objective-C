//
//  DateFormatter.m
//  CommonDataType
//
//  Created by yangjun on 15/10/15.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "DateFormatter.h"

@implementation DateFormatter

- (instancetype)init {
    
    self = [super init];
    if (self) {
//        [self testConvertingObjects];
//        [self testManagingAMAndPMSymbols];
//        [self testManagingWeekdaySymbols];
//        [self testManagingMonthSymbols];
//        [self testManagingQuarterSymbols];
//        [self testManagingEraSymbols];
    }
    return self;
    
}

#pragma mark 对象转换
- (void)testConvertingObjects {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    
    // NSDate转NSString
    // 设置生成格式,hh(12小时格式) HH(24小时格式)
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";// 设置生成格式
    NSString *dateStr = [dateFormatter stringFromDate:date];
    
    // NSString转NSDate,格式不对时会返回空
    date = [dateFormatter dateFromString:@"2015-10-15 10:12:00"];
    
    // (+) 根据系统指定样式NSDate转NSString
    dateStr = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterFullStyle];
    // 等价
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterFullStyle;
    dateFormatter.timeStyle = NSDateFormatterFullStyle;
    dateStr = [dateFormatter stringFromDate:date];
}

#pragma mark 管理上午和下午的符号
- (void)testManagingAMAndPMSymbols {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 打出的上午样式
    NSString *symbol = dateFormatter.AMSymbol;
    // 下午
    symbol = dateFormatter.PMSymbol;
    
    // 使用举例
    dateFormatter.AMSymbol = @"AM";
    dateFormatter.PMSymbol = @"PM";
    dateFormatter.dateStyle = NSDateFormatterFullStyle;
    dateFormatter.timeStyle = NSDateFormatterFullStyle;
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSLog(@"%@", dateStr);
    
}

#pragma mark 管理周符号
- (void)testManagingWeekdaySymbols {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // 星期日, 星期一, 星期二, 星期三, 星期四, 星期五, 星期六
    NSArray<NSString *> *array =  dateFormatter.weekdaySymbols;
    array =  dateFormatter.standaloneWeekdaySymbols;
    
    // 周日, 周一, 周二, 周三, 周四, 周五, 周六
    array =  dateFormatter.shortWeekdaySymbols;
    array =  dateFormatter.shortStandaloneWeekdaySymbols;
    
    // 日, 一, 二, 三, 四, 五, 六
    array =  dateFormatter.veryShortWeekdaySymbols;
    array =  dateFormatter.veryShortStandaloneWeekdaySymbols;
    
}

#pragma mark 管理月符号
- (void)testManagingMonthSymbols {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // 一月, 二月, 三月, 四月, 五月, 六月, 七月, 八月, 九月, 十月, 十一月, 十二月
    NSArray<NSString *> *array =  dateFormatter.monthSymbols;
    array =  dateFormatter.standaloneMonthSymbols;
    
    // 1月, 2月, 3月, 4月, 5月, 6月, 7月, 8月, 9月, 10月, 11月, 12月
    array =  dateFormatter.shortMonthSymbols;
    array =  dateFormatter.shortStandaloneMonthSymbols;
    
    // 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
    array =  dateFormatter.veryShortMonthSymbols;
    array =  dateFormatter.veryShortStandaloneMonthSymbols;
    
}

#pragma mark 管理季度符号
- (void)testManagingQuarterSymbols {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // 第一季度, 第二季度, 第三季度, 第四季度
    NSArray<NSString *> *array =  dateFormatter.quarterSymbols;
    array =  dateFormatter.standaloneQuarterSymbols;
    
    // 1季度, 2季度, 3季度, 4季度
    array =  dateFormatter.shortQuarterSymbols;
    array =  dateFormatter.shortStandaloneQuarterSymbols;
    
}

#pragma mark 管理时区
- (void)testManagingEraSymbols {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // 公元前, 公元
    NSArray<NSString *> *array =  dateFormatter.eraSymbols;
    array =  dateFormatter.longEraSymbols;
    
}

@end
