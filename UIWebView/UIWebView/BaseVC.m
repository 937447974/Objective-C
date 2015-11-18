//
//  BaseVC.m
//  WebView
//
//  Created by yangjun on 15/11/3.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "BaseVC.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface BaseVC () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView; ///< UIWebView

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 找到index.html的路径
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url]; // url的位置
    self.webView.delegate = self;       // 代理UIWebViewDelegate
    [self.webView loadRequest:urlRequest]; // 加载页面
   
}

#pragma mark - js调OC
- (void)jsCallOC:(NSString *)params {
    NSLog(@"%@:%@", NSStringFromSelector(_cmd), params);
    NSString *jsStr = [NSString stringWithFormat:@"ocCallJS('%@')", params];
    // oc调js
    [self.webView stringByEvaluatingJavaScriptFromString:jsStr];
}

#pragma mark - UIWebViewDelegate
#pragma mark 开始加载网页
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

#pragma mark 网页加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSLog(@"loading:%d", self.webView.loading);
}

#pragma mark 网页加载出错
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    NSLog(@"%@:%@", NSStringFromSelector(_cmd), error.localizedDescription);
}

#pragma mark 网页监听
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@", NSStringFromSelector(_cmd));
//    typedef NS_ENUM(NSInteger, UIWebViewNavigationType) {
//        UIWebViewNavigationTypeLinkClicked, 用户触击了一个链接。
//        UIWebViewNavigationTypeFormSubmitted, 用户提交了一个表单。
//        UIWebViewNavigationTypeBackForward, 用户触击前进或返回按钮。
//        UIWebViewNavigationTypeReload, 用户触击重新加载的按钮。
//        UIWebViewNavigationTypeFormResubmitted, 用户重复提交表单
//        UIWebViewNavigationTypeOther 发生其它行为
//    } __TVOS_PROHIBITED;
    // 过滤
    NSString *requestString = request.URL.absoluteString.stringByRemovingPercentEncoding;
    // 分割
    NSArray *urlComps = [requestString componentsSeparatedByString:@"::"];
    if ([urlComps count] == 3 && [@"ios" isEqualToString:[urlComps objectAtIndex:0]])
    {
        //解析约定的指令
        // 方法名
        NSString *methods = [NSString stringWithFormat:@"%@:", [urlComps objectAtIndex:1]];
        SEL selector = NSSelectorFromString(methods);
        // 判断类是否有方法
        if ( [BaseVC instancesRespondToSelector:selector]) {
            // 携带的参数
            NSString *params = [urlComps objectAtIndex:2];
            NSLog(@"JS调用OC代码->UIWebView\n方法名:%@,参数:%@", methods, params);
            // 执行方法，携带参数
            [self performSelector:selector withObject:params];
        } else {
            NSLog(@"没有提供调用的%@方法名",methods);
        }
        return NO;
    }
    return YES;
}

@end
