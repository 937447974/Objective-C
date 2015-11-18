//
//  SeniorVC.m
//  UIWebView
//
//  Created by yangjun on 15/11/5.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "SeniorVC.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "JavaScriptUtil.h"
#import "ProgressWebView.h"

@interface SeniorVC () <UIWebViewDelegate, JavaScriptDelegate>
{
    CGFloat _startLoadingCount;  ///< 要加载的链接数
    CGFloat _finishLoadingCount; ///< 已加载的链接数
}

@property (weak, nonatomic) IBOutlet ProgressWebView *webView;     ///< UIWebView
@property (weak, nonatomic) IBOutlet UIProgressView *progressView; ///< 进度条
@property (nonatomic, strong) JSContext *jsContext;                ///< JSContext

@end

@implementation SeniorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 获取JSContext
    self.jsContext = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    // 通过exceptionHandler捕获js错误
    self.jsContext.exceptionHandler = ^(JSContext *con, JSValue *exception) {
        NSLog(@"exception:%@", exception);
        con.exception = exception;
    };
    // 注入JavaScriptUtil
    JavaScriptUtil *jSUtil = [[JavaScriptUtil alloc] init];
    jSUtil.javaScriptDelegate = self;
    self.jsContext[@"app"] = jSUtil;
   
    self.webView.delegate = self;// 代理
    
    // 1. JavaScriptCore交互
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Senior" withExtension:@"html"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url]; // url的位置
    [self.webView loadRequest:urlRequest]; // 加载页面

    // 2.进度条
    url = [NSURL URLWithString:@"https://www.baidu.com"];
    urlRequest = [NSURLRequest requestWithURL:url]; // url的位置
//    [self.webView loadRequest:urlRequest]; // 加载页面
    
}

#pragma mark 刷新
- (IBAction)reload:(id)sender {
    NSLog(@"%d", self.webView.loading);
    // 正在刷新界面时，停止刷新后重新刷新界面
    if (self.webView.loading) {
        [self.webView stopLoading]; // 停止刷新
    }
    [self.webView reload]; // 刷新界面
}

#pragma mark 去上一页
- (IBAction)goBack:(id)sender {
    // 可以去上一页时，执行去上一页操作
    if (self.webView.canGoBack) {
        _startLoadingCount = _finishLoadingCount = 0;
        [self.webView goBack];
    }
}

#pragma mark 去下一页
- (IBAction)goForward:(id)sender {
    // 可以去下一页时，执行去下一页操作
    if (self.webView.canGoForward) {
        _startLoadingCount = _finishLoadingCount = 0;
        [self.webView goForward];
    }
}

#pragma mark - JavaScriptDelegate
- (void)jsCallOC:(NSString *)params {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSString *js = [NSString stringWithFormat:@"ocCallJS('%@')", params];
    [self.jsContext evaluateScript:js];
    // 或
    // [self.webView stringByEvaluatingJavaScriptFromString:js];
}

#pragma mark - ProgressWebViewDelegate
- (void)webView:(ProgressWebView *)webView didReceivedCount:(NSInteger)receivedCount totalCount:(NSInteger)totalCount {
     // 网络加载时显示进度
    if ([UIApplication sharedApplication].networkActivityIndicatorVisible) {
        CGFloat progress = (CGFloat)receivedCount / totalCount;
        NSLog(@"%ld:%ld,%f", (long)receivedCount, (long)totalCount, progress);
        [self.progressView setProgress:progress animated:YES];
    } else {
        // 还原状态
        webView.receivedCount = 0;
        webView.totalCount = 0;
    }
}

#pragma mark - UIWebViewDelegate
#pragma mark 开始加载网页
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    // 开启网络加载提示
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    if (_startLoadingCount == 0) {
        self.webView.receivedCount = 0;
        self.webView.totalCount = 0;
    }
    _startLoadingCount++;
}

#pragma mark 网页加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    _finishLoadingCount++;
    // 获取document.readyState状态
    NSString *readyState = [webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
    BOOL complete = [readyState isEqualToString:@"complete"];
    if (complete && _finishLoadingCount == _startLoadingCount) {
        NSLog(@"加载完成");
        // 网页显示完毕时，初始化相关状态
        _startLoadingCount = _finishLoadingCount = 0;
        [self.progressView setProgress:1.0 animated:YES];
        // 关闭网络加载提示
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}

#pragma mark 网页加载出错
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    NSLog(@"%@:%@", NSStringFromSelector(_cmd), error.localizedDescription);
}

#pragma mark 网页监听
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSLog(@"%@", request.URL.absoluteString.stringByRemovingPercentEncoding);
    return YES;
}

@end
