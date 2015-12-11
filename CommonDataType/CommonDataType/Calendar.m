//
//  Calendar.m
//  CommonDataType
//
//  Created by yangjun on 15/10/16.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "Calendar.h"

@implementation Calendar

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self testSystemLocaleInformation]; //系统语言环境
        [self testCreatingAndInitializing]; // 初始化
        [self testGettingInformation];      // 获取重要信息
        [self testCalendricalCalculations]; // 日历计算
        [self testComparing];               // 时间比较
        [self testExtractingComponents];    // 提取组件
        [self testAMAndPMSymbols]; // 上午下午符号
        [self testWeekdaySymbols]; // < 周符号
        [self testMonthSymbols];   // 月符号
        [self testQuarterSymbols]; // 季度符号
        [self testEraSymbols];     // 公元前、公元符号
    }
    return self;
    
}

#pragma mark 获取系统语言环境
- (void)testSystemLocaleInformation {
    
    // 系统环境、NSCalendarIdentifierGregorian
    //  第一次用此方法实例化对象后，即使修改了系统日历设定，这个对象也不会改变。
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 修改系统日历设定，其实例化的对象也会随之改变。
    calendar = [NSCalendar autoupdatingCurrentCalendar];
    
}

#pragma mark 初始化
- (void)testCreatingAndInitializing {
    
    // (+) 自定义语言环境
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    // (-)
    calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
}

#pragma mark 获取重要信息
- (void)testGettingInformation {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [NSDate date];
    
    NSLog(@"calendarIdentifier:%@", calendar.calendarIdentifier);
    
    // 设置每周的第一天从星期几开始，比如：1代表星期日开始，2代表星期一开始，以此类推。默认值是1
    NSLog(@"firstWeekday:%lu", (unsigned long)calendar.firstWeekday);
    
    // 设置每年及每月第一周必须包含的最少天数，比如：设定第一周最少包括3天，则value传入3
    NSLog(@"minimumDaysInFirstWeek:%lu", (unsigned long)calendar.minimumDaysInFirstWeek);
    
    // 设置本地化信息
    NSLog(@"locale:%@", calendar.locale);
    
    // 获取最大和最小范围
    NSRange range = [calendar maximumRangeOfUnit:NSCalendarUnitYear];
    range = [calendar minimumRangeOfUnit:NSCalendarUnitYear];
    
    // 获取一个小的单位在一个大的单位里面的序数，获取当日是这一周的第几天
    NSUInteger day = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:date];
    NSLog(@"ordinalityOfUnit:%lu", (unsigned long)day);
    
    // 根据参数提供的时间点，得到一个小的单位在一个大的单位里面的取值范围
    range = [calendar rangeOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:date];
    
    // 根据参数提供的时间点，返回所在日历单位的开始时间。如果startDate和interval均可以计算，则返回YES；否则返回NO
    NSTimeInterval count = 0;
    NSDate *dateOut = nil;
    // 获取时间所处的月份，起始时间点
    BOOL rangeOfUnit = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&dateOut interval:&count forDate:date];
    if (rangeOfUnit) {
        //得到本地时间，避免时区问题
        NSInteger interval = [calendar.timeZone secondsFromGMTForDate:dateOut];
        NSDate *localeDate = [dateOut dateByAddingTimeInterval:interval];
        NSLog(@"%@", dateOut);
        NSLog(@"%@",localeDate);
        NSLog(@"%f",count);
    } else {
        NSLog(@"无法计算");
    }
    
    // 返回某个给定的日期是否在一个周末期间,如果startDate和interval均可以计算，则返回YES；否则返回NO
    rangeOfUnit = [calendar rangeOfWeekendStartDate:&dateOut interval:&count containingDate:date];
    if (rangeOfUnit) {
        //得到本地时间，避免时区问题
        NSInteger interval = [calendar.timeZone secondsFromGMTForDate:dateOut];
        NSDate *localeDate = [dateOut dateByAddingTimeInterval:interval];
        NSLog(@"%@", dateOut);
        NSLog(@"%@",localeDate);
        NSLog(@"%f",count);
    } else {
        NSLog(@"无法计算");
    }
    
}

#pragma mark 日历计算
- (void)testCalendricalCalculations {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [NSDate date];
    
    // 在参数date基础上，增加一个NSDateComponents类型的时间增量
    NSDateComponents *compt = [[NSDateComponents alloc] init];
    [compt setHour:1];// 增加1小时
    NSLog(@"%@", [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle]);
    date = [calendar dateByAddingComponents:compt toDate:date options:0];
    NSLog(@"%@", [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle]);
    
    // 根据NSCalendarUnit增加一个常量的时间增量
    date = [calendar dateByAddingUnit:NSCalendarUnitHour value:1 toDate:date options:0];
    NSLog(@"%@", [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle]);
    
    // NSDateComponents转NSDate
    date = [calendar dateFromComponents:compt];
    NSLog(@"%@", [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle]);
    
    // 生成当前日期不变，指定时、分、秒的日期
    date = [NSDate date];
    date = [calendar dateBySettingHour:1 minute:3 second:4 ofDate:date options:0];
    NSLog(@"%@", [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle]);
    
    // 根据NSCalendarUnit和设置的值，生成日期
    date = [calendar dateBySettingUnit:NSCalendarUnitHour value:2 ofDate:date options:0];
    NSLog(@"%@", [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle]);
    
    // 根据时代、年、月、日、时、分、秒、毫 生成日期
    date = [calendar dateWithEra:1 year:2015 month:10 day:18 hour:15 minute:6 second:8 nanosecond:100];
    NSLog(@"%@", [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle]);
    
    // 根据时代、年、周、星期、时、分、秒、毫 生成NSDate
    date = [calendar dateWithEra:1 yearForWeekOfYear:2015 weekOfYear:2 weekday:3 hour:1 minute:6 second:8 nanosecond:0];
    NSLog(@"%@", [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterFullStyle timeStyle:NSDateFormatterMediumStyle]);
    
    // 使用指定NSDateComponents匹配指定的NSDate，如果全部匹配成成功，则返回YES，否则No
    BOOL matchesComponents = [calendar date:date matchesComponents:compt];
    NSLog(@"matchesComponents:%d", matchesComponents);
    
    // 寻找下一个时间节点，且此节点完全匹配NSDateComponents
    date = [calendar nextDateAfterDate:date matchingComponents:compt options:NSCalendarMatchNextTime];
    NSLog(@"%@", [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle]);
    
    // 寻找下一个时间点，且匹配指定的时、分、秒
    date = [calendar nextDateAfterDate:date matchingHour:15 minute:0 second:0 options:NSCalendarMatchNextTime];
    NSLog(@"%@", [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle]);
    
    // 寻找下一个时间点，且匹配NSCalendarUnit和指定的值
    date = [calendar nextDateAfterDate:date matchingUnit:NSCalendarUnitHour value:16 options:NSCalendarMatchNextTime];
    NSLog(@"%@", [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle]);
    
    // 返回给定日期的当日起始时间
    date = [calendar startOfDayForDate:date];
    NSLog(@"%@", [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle]);
    
}

#pragma mark 时间比较
- (void)testComparing {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [NSDate date];
    NSDate *toDate = [date dateByAddingTimeInterval:-10];// 增加10秒
    
    // 比较两个日期的NSCalendarUnitDay大小
    NSComparisonResult result = [calendar compareDate:date toDate:toDate toUnitGranularity:NSCalendarUnitDay];
    NSLog(@"compareDate:%ld", (long)result);
    
    // 比较两个日期的NSCalendarUnitDay 是否相等
    BOOL compare = [calendar isDate:date equalToDate:toDate toUnitGranularity:NSCalendarUnitDay];
    
    // 两个日期是否在同一天
    compare = [calendar isDate:date inSameDayAsDate:toDate];
    
    // 指定的日期是否在今天
    compare = [calendar isDateInToday:date];
    
    // 指定的日期是否在明天
    compare = [calendar isDateInTomorrow:date];
    
    // 指定的日期是否在周末
    compare = [calendar isDateInWeekend:date];
    
    // 指定的日期是否在昨天
    compare = [calendar isDateInYesterday:date];
    
}

#pragma mark 提取组件
- (void)testExtractingComponents {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [NSDate date];
    NSDate *toDate = [calendar dateByAddingUnit:NSCalendarUnitHour value:1 toDate:date options:0];
    
    // 提取NSDate对应的NSCalendarUnit的数值,只能提取一个值
    NSInteger component = [calendar component:NSCalendarUnitHour fromDate:date];
    NSLog(@"NSCalendarUnitHour:%ld", (long)component);
    
    // 提取多个数据
    NSCalendarUnit unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute;// 提取时和分
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    
    // 根据指定NSCalendarUnit参数，比较两个NSDate之间的差异
    components = [calendar components:unitFlags fromDate:date toDate:toDate options:NSCalendarWrapComponents];
    
    // 根据指定NSCalendarUnit参数，比较两个NSDate之间的差异
    NSDateComponents *fromDateComponents = [[NSDateComponents alloc] init];
    fromDateComponents.hour = 13;
    NSDateComponents *toDateComponents = [[NSDateComponents alloc] init];
    fromDateComponents.hour = 14;
    components = [calendar components:unitFlags fromDateComponents:fromDateComponents toDateComponents:toDateComponents options:NSCalendarWrapComponents];
    
    // 根据时区提取所有数据
    components = [calendar componentsInTimeZone:calendar.timeZone fromDate:date];
    
    // 提取时代、年、月、日
    NSInteger era, year, month, day;
    [calendar getEra:&era year:&year month:&month day:&day fromDate:date];
    
    // 提取时代、年、第几周、周几
    NSInteger weekOfYear, weekday;
    [calendar getEra:&era yearForWeekOfYear:&year weekOfYear:&weekOfYear weekday:&weekday fromDate:date];
    
    // 提取时、分、秒、毫
    NSInteger hour, minute, second, nanosecond;
    [calendar getHour:&hour minute:&minute second:&second nanosecond:&nanosecond fromDate:date];
    
}

#pragma mark - 上午下午符号
- (void)testAMAndPMSymbols {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 上午
    NSString *symbol = calendar.AMSymbol;
    
    // 下午
    symbol = calendar.PMSymbol;
    
}

#pragma mark 周符号
- (void)testWeekdaySymbols {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 星期日, 星期一, 星期二, 星期三, 星期四, 星期五, 星期六
    NSArray<NSString *> *array =  calendar.weekdaySymbols;
    array =  calendar.standaloneWeekdaySymbols;
    
    // 周日, 周一, 周二, 周三, 周四, 周五, 周六
    array =  calendar.shortWeekdaySymbols;
    array =  calendar.shortStandaloneWeekdaySymbols;
    
    // 日, 一, 二, 三, 四, 五, 六
    array =  calendar.veryShortWeekdaySymbols;
    array =  calendar.veryShortStandaloneWeekdaySymbols;
    
    // 举例, NSDate提取星期几
    NSDate *date = [NSDate date];
    NSInteger component = [calendar component:NSCalendarUnitWeekday fromDate:date];
    component--;// 周是从1开头的
    NSString *symbol = [calendar.weekdaySymbols objectAtIndex:component];
    NSLog(@"NSCalendarUnitWeekday:%@", symbol);
    
}

#pragma mark 管理月符号
- (void)testMonthSymbols {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 一月, 二月, 三月, 四月, 五月, 六月, 七月, 八月, 九月, 十月, 十一月, 十二月
    NSArray<NSString *> *array =  calendar.monthSymbols;
    array =  calendar.standaloneMonthSymbols;
    
    // 1月, 2月, 3月, 4月, 5月, 6月, 7月, 8月, 9月, 10月, 11月, 12月
    array =  calendar.shortMonthSymbols;
    array =  calendar.shortStandaloneMonthSymbols;
    
    // 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
    array =  calendar.veryShortMonthSymbols;
    array =  calendar.veryShortStandaloneMonthSymbols;
    
}

#pragma mark 管理季度符号
- (void)testQuarterSymbols {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 第一季度, 第二季度, 第三季度, 第四季度
    NSArray<NSString *> *array =  calendar.quarterSymbols;
    array =  calendar.standaloneQuarterSymbols;
    
    // 1季度, 2季度, 3季度, 4季度
    array =  calendar.shortQuarterSymbols;
    array =  calendar.shortStandaloneQuarterSymbols;
    
}

#pragma mark 公元前/公元
- (void)testEraSymbols {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 公元前, 公元
    NSArray<NSString *> *array =  calendar.eraSymbols;
    array =  calendar.longEraSymbols;
    
}

@end
