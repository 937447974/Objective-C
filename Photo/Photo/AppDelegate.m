//
//  AppDelegate.m
//  Photo
//
//  Created by yangjun on 15/6/5.
//  Copyright (c) 2015年 阳君. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self customizeAppearance];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark 设置主题风格
- (void)customizeAppearance
{
    // 设置状态栏
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UIColor *color = [UIColor colorWithRed:246/255.0 green:68/255.0 blue:56/255.0 alpha:1.0];
    
    // UINavigationBar设置
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    navigationBar.barTintColor = color;// 背景色
    navigationBar.translucent = NO;//取消透明效果
    // 字体设置
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    navigationBar.titleTextAttributes = dict;
    
    // UIToolbar设置
    UIToolbar *toolbar = [UIToolbar appearance];
    toolbar.barTintColor = color;// 背景色
    toolbar.tintColor = [UIColor whiteColor];
    
    // UITabBar设置
    [[UITabBar appearance] setTintColor:color];// 点击后的颜色
    
    // 设置navigationBar背景色
    //contoroller.navigationController.navigationBar.barTintColor = color;
    // 设置toolbar背景色
    //contoroller.navigationController.toolbar.barTintColor = color;
    // 设置tabBar背景色
    //contoroller.tabBarController.view.backgroundColor = color;
    // 取消透明效果，默认是透明的
    //contoroller.navigationController.toolbar.translucent = NO;
    
    //UIImage *image = [[UIImage imageNamed:@"bg1"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    //[contoroller.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    //[[UINavigationBar appearance].backItem.backBarButtonItem setTintColor:[UIColor whiteColor]];
    //[UINavigationBar appearance].tintColor = [UIColor whiteColor];
    //设定Tabbar的颜色
    //[[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    //[UINavigationBar appearance].tintColor = color;
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bg1"] forBarMetrics:UIBarMetricsDefault];
}

@end
