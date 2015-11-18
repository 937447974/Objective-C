//
//  Users+Category.m
//  测试
//
//  Created by 阳君 on 14-2-27.
//  Copyright (c) 2014年 阳君. All rights reserved.
//

#import "Users+Category.h"

@implementation Users (Category)

-(void)test {
    NSString *str = [NSString stringWithFormat:@"账号：%@,密码：%i",self.userName,self.password];
    NSLog(@"Users的扩展方法,%@", str);
    
}

@end
