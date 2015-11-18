//
//  KVOTests.m
//  KVOTests
//
//  Created by yangjun on 15/10/10.
//  Copyright © 2015年 六月. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "User.h"

@interface KVOTests : XCTestCase
{
    User *_user;
}

@end

@implementation KVOTests

- (void)setUp {
    [super setUp];
    _user = [[User alloc] init];
    [_user addObserver:self forKeyPath:@"userName" options:NSKeyValueObservingOptionNew context:nil];// 添加监听
    
}

- (void)tearDown {
    [super tearDown];
    _user = nil;
}

- (void)testExample {
    _user.userName = @"yangjun";
    [_user removeObserver:self forKeyPath:@"userName"];// 取消监听
    _user.userName = @"IOS";
}

#pragma mark 监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([@"userName" isEqualToString:keyPath]) {// 这里只处理userName属性
        NSLog(@"userName:%@; change:%@", ((User *)object).userName, change);
    }
}


@end
