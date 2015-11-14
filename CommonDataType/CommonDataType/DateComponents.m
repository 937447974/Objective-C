//
//  DateComponents.m
//  CommonDataType
//
//  Created by yangjun on 15/10/19.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "DateComponents.h"

@implementation DateComponents

- (instancetype)init {
    
    self = [super init];
    if (self) {
//        [self testGettingDateValue];
//        [self testValidatingDateValue]; // 验证日期值
//        [self testDateComponents];// 日期组件
    }
    return self;
    
}

#pragma mark 获取时间属性
- (void)testGettingDateValue {
    
    NSCalendar *calendar = [NSCalendar currentCalendar]; // 系统语言环境
    NSDate *date = [NSDate date];// 当前系统时间
    NSTimeZone *timeZone = calendar.timeZone;// 时区
    
    // 根据时区提取所有数据
    NSDateComponents *dateComponents = [calendar componentsInTimeZone:timeZone fromDate:date];
    // 获取NSDate
    date = dateComponents.date;
    // 获取NSCalendar
    calendar = dateComponents.calendar;
    // 获取NSTimeZone
    timeZone = dateComponents.timeZone;

}

#pragma mark 验证日期
- (void)testValidatingDateValue {
    
    NSCalendar *calendar = [NSCalendar currentCalendar]; // 系统语言环境
    NSDate *date = [NSDate date];// 当前系统时间
    NSTimeZone *timeZone = calendar.timeZone;
    NSDateComponents *dateComponents = [calendar componentsInTimeZone:timeZone fromDate:date];
    
    // 能否生成日期
    BOOL isValidDate = dateComponents.validDate;
    // 日期是否存在于日历中，以及判断NSTimeZone是否存在日历中
    isValidDate = [dateComponents isValidDateInCalendar:calendar];

}

#pragma mark 日期组件
- (void)testDateComponents {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [NSDate date];
    NSTimeZone *timeZone = calendar.timeZone;
    NSDateComponents *dateComponents = [calendar componentsInTimeZone:timeZone fromDate:date];
        NSLog(@"%@", [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterFullStyle timeStyle:NSDateFormatterFullStyle]);
    
    NSInteger component = dateComponents.era; // 公元前、公元
    component = dateComponents.year; // 年
    component = dateComponents.month; // 月
    component = dateComponents.day; // 日
    component = dateComponents.hour; // 时
    component = dateComponents.minute; // 分
    component = dateComponents.second; // 秒
    component = dateComponents.nanosecond; // 纳秒
    component = dateComponents.weekday; // 周几
    component = dateComponents.weekdayOrdinal; // 工作日的序数
    component = dateComponents.quarter;
    component = dateComponents.weekOfMonth;// 这一月的第几周
    component = dateComponents.weekOfYear;// 这一年的第几周
    component = dateComponents.yearForWeekOfYear; // 年
    component = dateComponents.leapMonth;
    
    // 通过NSCalendarUnit获取值
    component = [dateComponents valueForComponent:NSCalendarUnitEra];
    // 通过NSCalendarUnit设置值
    [dateComponents setValue:component forComponent:NSCalendarUnitEra];
    
}


@end
