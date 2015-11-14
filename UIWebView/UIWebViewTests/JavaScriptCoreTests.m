//
//  JavaScriptCoreTests.m
//  UIWebView
//
//  Created by yangjun on 15/11/5.
//  Copyright © 2015年 六月. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "User.h"

@interface JavaScriptCoreTests : XCTestCase

@property (nonatomic, strong) JSContext *context;///< JavaScript运行环境

@end

@implementation JavaScriptCoreTests

- (void)setUp {
    [super setUp];
    self.context = [[JSContext alloc] init];
    // self.context = [JSContext currentContext];
    
}

- (void)tearDown {
    [super tearDown];
}

#pragma mark 类型转换
- (void)testType {
    // 计算2+2
    JSValue *result = [self.context evaluateScript:@"2 + 2"];
    NSLog(@"2 + 2 = %d", [result toInt32]);
    // 数组操作
    [self.context evaluateScript:@"var array = [\"阳君\", 937447974 ];"];
    JSValue *jsArray = self.context[@"array"];// 下标获取值
    // 判断是否为数组
    if (![jsArray isArray]) {
        return;
    }
    NSLog(@"JS Array: %@; Length: %@", jsArray, jsArray[@"length"]);
    jsArray[1] = @"blog"; // 修改
    jsArray[7] = @YES; // 数组越界时自动添加
    NSLog(@"JS Array: %@; Length: %d", jsArray, [jsArray[@"length"] toInt32]);
    // 转换为array
    NSArray *nsArr = [jsArray toArray];
    NSLog(@"NSArray: %@", nsArr);
}

#pragma mark 函数测试
- (void)testFunctions {
    /* js代码
     var factorial = function(n) {
        if (n < 0)
            return;
        if (n === 0)
            return 1;
        return n * factorial(n - 1);
     };
     */
    // 计算1*2*3....*n
    NSMutableString *factorialScript = [NSMutableString stringWithCapacity:10];
    [factorialScript appendString:@"var factorial = function(n) { "];
    [factorialScript appendString:@"if (n < 0) return; "];
    [factorialScript appendString:@"if (n === 0) return 1; "];
    [factorialScript appendString:@"return n * factorial(n - 1); };"];
    [_context evaluateScript:factorialScript];
    JSValue *function = _context[@"factorial"]; // 提取函数
    JSValue *result = [function callWithArguments:@[@5]];
    NSLog(@"factorial(5) = %d", [result toInt32]);
}

#pragma mark Blocks测试
- (void)testBlocks {
    
    // 设计一个user类，其中有name和qq属性
    self.context[@"user"] = ^{
        // 如果想使用JSContext，必须使用[JSContext currentContext]，避免循环引用
        JSValue *object = [JSValue valueWithNewObjectInContext:[JSContext currentContext]];
        // 属性传入
        [object setValue:@"阳君" forProperty:@"name"];
        // 通过下标传入
        object[@"qq"] = @"937447974";
        return object;
    };
    JSValue *user = [self.context evaluateScript:@"user()"];
    NSLog(@"name:%@, qq:%@", user[@"name"], [user valueForProperty:@"qq"]);
    
    // 修改name值
    self.context[@"setName"] = ^(JSValue *user, JSValue *name) {
        // 也可以这样获得传入参数
        NSArray *args = [JSContext currentArguments];
        NSLog(@"currentArguments:%@", args);
        user[@"name"] = name;
    };
    JSValue *setName = self.context[@"setName"];
    [setName callWithArguments:[NSArray arrayWithObjects:user, @"YangJun",nil]];
    NSLog(@"name:%@", user[@"name"]);
    
}

#pragma mark 异常捕获
- (void)testError {
    // 通过exceptionHandler捕获js错误
    self.context.exceptionHandler = ^(JSContext *con, JSValue *exception) {
        NSLog(@"%@", exception);
        con.exception = exception;
    };
    [self.context evaluateScript:@"阳君-937447974"];
}

- (void)testJSExport {
    
    User *user = [[User alloc] init];
    self.context[@"user"] = user; // 对象绑定
    // 修改值
    user.name = @"阳君";
    [self.context evaluateScript:@"user.qq = 937447974"];
    // 打印
    NSLog(@"oc %@", user); //由于继承NSObJect，会自动调用description方法
    JSValue *description = [self.context evaluateScript:@"user.description()"];
    NSLog(@"js %@", description);
    
}

@end
