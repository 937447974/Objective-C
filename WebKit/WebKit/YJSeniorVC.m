//
//  YJSeniorVC.m
//  WebKit
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 15/11/29.
//  Copyright © 2015年 阳君. All rights reserved.
//

#import "YJSeniorVC.h"
#import <WebKit/WebKit.h>

/** 屏幕宽度*/
#define UIScreenWeight [[UIScreen mainScreen] bounds].size.width
/** 屏幕高度*/
#define UIScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface YJSeniorVC () <WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;                      ///< WKWebView
@property (nonatomic, strong) UIProgressView *progressView;            ///< 进度条
@property (nonatomic, strong) UIBarButtonItem *goBackBarButtonItem;    ///< 上一页按钮
@property (nonatomic, strong) UIBarButtonItem *goForwardBarButtonItem; ///< 下一页按钮

@end

@implementation YJSeniorVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUIBarButtonItem];
    // 进度条监视
    NSLog(@"%f", self.webView.estimatedProgress); // 防止苹果改变属性名时，项目不报错。故这里先打印。
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    // 刷新界面
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest]; // 加载页面
}

#pragma mark 初始化UIBar导航按钮
- (void)initUIBarButtonItem {
    // 左边
    self.goBackBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(goBack:)];
    self.goBackBarButtonItem.enabled = NO; // 不可点
    self.goForwardBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(goForward:)];
    self.goForwardBarButtonItem.enabled = NO;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:self.goBackBarButtonItem, self.goForwardBarButtonItem, nil];
    // 右边
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchBackForwardList:)];
    UIBarButtonItem *reloadItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reload:)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:reloadItem, searchItem, nil];
}

#pragma mark - get方法
- (UIProgressView *)progressView {
    if (_progressView == nil) {
        CGRect rect = CGRectZero;
        rect.origin.y = self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height;
        rect.size.width = UIScreenWeight;
        rect.size.height = 2;
        _progressView = [[UIProgressView alloc] initWithFrame:rect];
        [_progressView setProgressViewStyle:UIProgressViewStyleDefault]; //设置进度条类型
        [self.view addSubview:_progressView];
    }
    return _progressView;
}

- (WKWebView *)webView {
    if (_webView == nil) {
        // WKWebView的配置
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        // 显示网页
        CGRect rect = CGRectZero;
        rect.size.width = UIScreenWeight;
        rect.size.height = UIScreenHeight;
        _webView = [[WKWebView alloc] initWithFrame:rect configuration:configuration];
        _webView.navigationDelegate = self; // 代理设置
        [self.view addSubview:_webView];
    }
    return _webView;
}

#pragma mark - IBAction
#pragma mark 上一页
- (void)goBack:(id)sender {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
}

#pragma mark 下一页
- (void)goForward:(id)sender {
    if ([self.webView canGoForward]) {
        [self.webView goForward];
    }
}

#pragma mark 刷新
- (void)reload:(id)sender {
    if (self.webView.loading) { // 是否正在刷新页面
        [self.webView stopLoading]; // 停止刷新
    }
    // 刷新页面
    [self.webView reload];
}

#pragma mark 浏览记录
- (void)searchBackForwardList:(id)sender {
    // 查询历史记录
    WKBackForwardList *backForwardList = self.webView.backForwardList;
    // 历史
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"浏览记录" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    __weak WKWebView *webView = self.webView;
    // 后退
    for (__weak WKBackForwardListItem *backItem in backForwardList.backList) {
        [alertController addAction:[UIAlertAction actionWithTitle:backItem.title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [webView goToBackForwardListItem:backItem];
        }]];
    }
    // 当前页面
    [alertController addAction:[UIAlertAction actionWithTitle:backForwardList.currentItem.title style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [webView reload];
    }]];
    // 前进
    for (__weak WKBackForwardListItem *forwardItem in backForwardList.forwardList) {
        [alertController addAction:[UIAlertAction actionWithTitle:forwardItem.title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [webView goToBackForwardListItem:forwardItem];
        }]];
    }
    // 取消按钮
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    // 显示
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    // 进度条
    if ([@"estimatedProgress" isEqualToString:keyPath]) {
        NSLog(@"%f", self.webView.estimatedProgress);
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
        // 初始和终止状态
        if (self.progressView.progress == 0) {
            self.progressView.hidden = NO;
        } else if (self.progressView.progress == 1) {
            // 1秒后隐藏
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 再次判断，防止正在加载时隐藏
                if (self.progressView.progress == 1) {
                    self.progressView.progress = 0;
                    self.progressView.hidden = YES;
                }
            });
        }
    }
}

#pragma mark - WKNavigationDelegate 页面跳转
#pragma mark 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"%s",__FUNCTION__);
    /**
     *typedef NS_ENUM(NSInteger, WKNavigationActionPolicy) {
     WKNavigationActionPolicyCancel, // 取消
     WKNavigationActionPolicyAllow,  // 继续
     }
     */
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark 身份验证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler {
    NSLog(@"%s",__FUNCTION__);
    // 不要证书验证
    completionHandler(NSURLSessionAuthChallengeUseCredential, nil);
}

#pragma mark 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"%s",__FUNCTION__);
    decisionHandler(WKNavigationResponsePolicyAllow);
}

#pragma mark 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark WKNavigation导航错误
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark WKWebView终止
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - WKNavigationDelegate 页面加载
#pragma mark 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s",__FUNCTION__);
    self.progressView.hidden = NO;
}

#pragma mark 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s",__FUNCTION__);
    if (!self.webView.loading) {
        self.navigationItem.title = webView.title; // 页面标题
        // 上一页按钮和下一页按钮是否可点
        self.goBackBarButtonItem.enabled = [self.webView canGoBack];
        self.goForwardBarButtonItem.enabled = [self.webView canGoForward];
    }
}

#pragma mark 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"%@", error.localizedDescription);
}

@end
