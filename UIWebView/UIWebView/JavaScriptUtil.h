//
//  JavaScriptUtil.h
//  UIWebView
//
//  Created by yangjun on 15/11/6.
//  Copyright © 2015年 六月. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

/// 暴露给js使用的协议
@protocol JavaScriptDelegate <NSObject, JSExport>

- (void)jsCallOC:(NSString *)params;

@end

/// js对应的oc实现类
@interface JavaScriptUtil : NSObject <JavaScriptDelegate>

@property (nonatomic, weak) id<JavaScriptDelegate> javaScriptDelegate; ///< 代理

@end
