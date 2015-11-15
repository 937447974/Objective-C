//
//  main.m
//  Runtime
//
//  Created by yangjun on 15/9/21.
//  Copyright © 2015年 六月. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClassTest.h"
#import "MsgSendTest.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        ClassTest *classTest = [ClassTest new];
//        [classTest test];
        [[[MsgSendTest alloc] init] sendTest];
        
    }
    return 0;
}


