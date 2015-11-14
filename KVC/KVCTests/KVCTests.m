//
//  KVCTests.m
//  KVCTests
//
//  Created by yangjun on 15/10/10.
//  Copyright © 2015年 六月. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "User.h"

@interface KVCTests : XCTestCase
{
    User *_user;
}

@end

@implementation KVCTests

- (void)setUp {
    [super setUp];
    _user = [[User alloc] init];
}

- (void)testExample {
    
    // 简单路径
    [_user setValue:@"yangjun" forKey:@"userName"];
    NSString *value = [_user valueForKey:@"userName"];
    Address *address = [[Address alloc] init];
    address.addressName = @"BeiJing";
    [_user setValue:address forKey:@"address"];
    value = [_user valueForKey:@"userName"];
    NSLog(@"用户名:%@;地址:%@", _user.userName, _user.address.addressName);
    
    // 复合路径
    [_user setValue:@"君" forKeyPath:@"userName"];
    [_user setValue:@"北京" forKeyPath:@"address.addressName"];
    value = [_user valueForKeyPath:@"address.addressName"];
    NSLog(@"用户名:%@;地址:%@", _user.userName, _user.address.addressName);
    
    // 字典传入
    address = [[Address alloc] init];
    address.addressName = @"北京站";
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"阳", @"userName", address, @"address", nil];
    [_user setValuesForKeysWithDictionary:dict];// 设值
    dict  = [_user dictionaryWithValuesForKeys:[NSArray arrayWithObjects:@"userName", @"address", nil]];// 取值
    NSLog(@"用户名:%@;地址:%@", _user.userName, _user.address.addressName);
    NSLog(@"%@", dict);

}

@end
