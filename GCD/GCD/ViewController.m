//
//  ViewController.m
//  GCD
//
//  Created by yangjun on 15/7/10.
//  Copyright (c) 2015年 阳君. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    dispatch_queue_t queue = dispatch_get_main_queue();// 主线程
    queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);// 后台执行
    // 异步执行队列任务
    dispatch_async(queue, ^{
        NSLog(@"开新线程执行");
    });
    
    
    // 2s后执行
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
    dispatch_after(when, queue, ^{
        NSLog(@"dispatch_after");
    });
    [self performSelector:@selector(after) withObject:nil afterDelay:2];
    
    
    // 多线程模式下只new一次
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        NSLog(@"dispatch_once");
    });
    dispatch_once(&predicate, ^{
        NSLog(@"dispatch_once");
    });
    
    
    // 分组执行
    queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);// 默认优先级执行
    dispatch_group_t group = dispatch_group_create();
    for (int i = 0; i<10; i++) {
        //异步执行队列任务
        dispatch_group_async(group, queue, ^{
            NSLog(@"dispatch_group_async:%d", i);
        });
    }
    dispatch_group_notify(group, queue, ^{
        NSLog(@"dispatch_group_notify");
    });
    
    
    // 串行队列：只有一个线程，加入到队列中的操作按添加顺序依次执行。
    queue = dispatch_queue_create("yangj", DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i<10; i++) {
        //异步执行队列任务
        dispatch_async(queue, ^{
            NSLog(@"dispatch_queue_create:%d", i);
        });
    }
    
    
    // 并发队列：有多个线程，操作进来之后它会将这些队列安排在可用的处理器上，同时保证先进来的任务优先处理。
    queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i<10; i++) {
        //异步执行队列任务
        dispatch_async(queue, ^{
            NSLog(@"dispatch_get_global_queue:%d", i);
        });
    }
    
}

- (void)after
{
     NSLog(@"performSelector");
}

@end
