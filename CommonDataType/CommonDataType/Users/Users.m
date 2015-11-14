//
//  Users.m
//  测试机
//
//  Created by 阳君 on 14-2-26.
//  Copyright (c) 2014年 阳君. All rights reserved.
//

#import "Users.h"

@implementation Users

//userName的get和set方法
-(void)setUserName:(NSString *)userName{
    _userName = userName;
}
-(NSString *)userName{
    return _userName;
}

//password的get和set方法
-(void)setPassword:(int)password{
    _password = password;
}
-(int)password{
    return _password;
}

//等效age的get和set方法
@synthesize age;

-(id)initWithUserName:(NSString *)userName andPassword:(int)password{
    if (self = [super init]) {
        self.userName = userName;
        self.password = password;
    }
    return self;
}

//重写父类的toString方法
-(NSString *)description {
    NSString *str = [NSString stringWithFormat:@"账号：%@,密码：%i",self.userName,self.password];
    return str;
}

@end
