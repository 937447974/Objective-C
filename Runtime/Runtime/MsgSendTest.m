//
//  MsgSendTest.m
//  Runtime
//
//  Created by yangjun on 15/9/23.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "MsgSendTest.h"
#import "SuperUser.h"
#import <objc/message.h>

@implementation MsgSendTest

#pragma mark 消息发送
- (void)sendTest
{
    User *user = [[User alloc] init];
    user.userName = @"IOS";
    NSLog(@"%@", user.userName);
    // 等价
    [user performSelector:@selector(setUserName:) withObject:@"performSelector"];
     NSLog(@"%@", user.userName);
    
#if OBJC_OLD_DISPATCH_PROTOTYPES // Runtime时

    // objc_msgSend发送一个消息并返回一个id类型的数据
    fprintf(stdout, "\nobjc_msgSend\n");
    objc_msgSend(user, @selector(setUserName:), @"objc_msgSend");
    NSLog(@"%@",  objc_msgSend(user, @selector(userName)));
    
    // objc_msgSend_fpret只能在i386处理器上运行,否则返回NaN
    fprintf(stdout, "\nobjc_msgSend_fpret\n");
    double sendFpret = objc_msgSend_fpret(self, @selector(getDouble));
    NSLog(@"%f", sendFpret);
   
    // objc_msgSendSuper和objc_msgSend一样，主要是调用父类的方法的。
    SuperUser *sUser = [[SuperUser alloc] init];
    fprintf(stdout, "\nobjc_msgSend_stret\n");
    struct objc_super objcSuper = {sUser, objc_getClass("User")};
    objc_msgSendSuper(&objcSuper, sel_registerName("setUserName:"), @"objc_msgSendSuper");
    NSLog(@"%@", objc_msgSendSuper(&objcSuper, sel_registerName("userName")));
    
#endif
    
}

#pragma mark 返回doule类型数据
- (double)getDouble
{
    return 24;
}

@end
