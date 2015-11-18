//
//  User.m
//  UIWebView
//
//  Created by yangjun on 15/11/5.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "User.h"

@implementation User

// 由于属性在代理里面，需要通知编译器实现getter/setter方法
@synthesize name,qq;

- (NSString *)description {
    return [NSString stringWithFormat:@"name:%@; qq:%@", self.name, self.qq];
}

@end
