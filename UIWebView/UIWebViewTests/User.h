//
//  User.h
//  UIWebView
//
//  Created by yangjun on 15/11/5.
//  Copyright © 2015年 六月. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

/** JavaScript可调的协议*/
@protocol UserProtocol <JSExport>

@property (nonatomic, copy) NSString *name; ///< 姓名
@property (nonatomic, copy) NSString *qq;   ///< qq号码

- (NSString *)description; // 打印信息

@end

/** 用户*/
@interface User : NSObject <UserProtocol>

@end
