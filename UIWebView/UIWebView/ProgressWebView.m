//
//  ProgressWebView.m
//  UIWebView
//
//  Created by yangjun on 15/11/6.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "ProgressWebView.h"

// 暴露UIWebView的私有方法
@interface UIWebView()

- (id)webView:(id)webView identifierForInitialRequest:(id)initialRequest fromDataSource:(id)dataSource;
- (void)webView:(id)webView resource:(id)resource didFinishLoadingFromDataSource:(id)dataSource;

@end

@implementation ProgressWebView

#pragma mark 发出网络资源请求
- (id)webView:(id)webView identifierForInitialRequest:(id)initialRequest fromDataSource:(id)dataSource {
    self.totalCount++;
    return [super webView:webView identifierForInitialRequest:initialRequest fromDataSource:dataSource];
}

#pragma mark 网络资源获取成功
- (void)webView:(id)webView resource:(id)resource didFinishLoadingFromDataSource:(id)dataSource {
    [super webView:webView resource:resource didFinishLoadingFromDataSource:dataSource];
    self.receivedCount++;
    // 代理回调通知加载进度
    if ([self.delegate respondsToSelector:@selector(webView:didReceivedCount:totalCount:)]) {
        // 运用delegate类型转换为ProgressWebViewDelegate完成回调
        id<ProgressWebViewDelegate> pDelegate = (id<ProgressWebViewDelegate>)self.delegate;
        [pDelegate webView:self didReceivedCount:self.receivedCount totalCount:self.totalCount];
    }

}

@end
