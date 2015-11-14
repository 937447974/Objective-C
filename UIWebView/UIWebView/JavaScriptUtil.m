//
//  JavaScriptUtil.m
//  UIWebView
//
//  Created by yangjun on 15/11/6.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "JavaScriptUtil.h"

@implementation JavaScriptUtil

- (void)jsCallOC:(NSString *)params {
    if ([self.javaScriptDelegate respondsToSelector:@selector(jsCallOC:)]) {
        [self.javaScriptDelegate jsCallOC:params];
    }
}

@end
