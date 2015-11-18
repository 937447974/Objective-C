//
//  User.m
//  Runtime
//
//  Created by yangjun on 15/9/21.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "User.h"

@implementation User

+ (id)userWithUserName:(NSString *)userName
{
    User *user = [[User alloc] init];
    user.userName = userName;
    return userName;
}

#pragma mark 初始化
- (id)initWithUserName:(NSString *)userName
{
    self = [super init];
    if (self) {
        self.userName = userName;
    }
    return self;
}

@end
