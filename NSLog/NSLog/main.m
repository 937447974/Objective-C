//
//  main.m
//  NSLog
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/11/17.
//  Copyright © 2015年 阳君. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "NSLog+Extension.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *array = [NSArray arrayWithObjects:@"阳君", nil];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:array, @"name", @"937447974", @"qq", nil];
        array = [NSArray arrayWithObjects:@"阳君", dict, nil];
        dict = [NSDictionary dictionaryWithObjectsAndKeys:array, @"name", @"937447974", @"qq", nil];
        NSLog(@"%@", dict);
    }
    return 0;
}
