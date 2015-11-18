//
//  AdvancedVC.m
//  UIWebView
//
//  Created by yangjun on 15/11/4.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "AdvancedVC.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface AdvancedVC () <UIWebViewDelegate>
{
    CGFloat _startLoadingCount;  ///< 要加载的链接数
    CGFloat _finishLoadingCount; ///< 已加载的链接数
}

@property (weak, nonatomic) IBOutlet UIWebView *webView; ///< UIWebView
@property (weak, nonatomic) IBOutlet UIProgressView *progressView; ///< 进度条

@end

@implementation AdvancedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"清除cookies");
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    NSLog(@"清除UIWebView的缓存");
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url]; // url的位置
    self.webView.delegate = self;
    [self.webView loadRequest:urlRequest]; // 加载页面
    
    self.webView.backgroundColor = [UIColor lightGrayColor]; // 设置背景色
    self.webView.scalesPageToFit = YES; // 能否放大缩小，默认no
    self.webView.scrollView.bounces = YES ; // 是否禁止阻力效果
    [self managingMediaPlayback];
}

#pragma mark 媒体播放管理
- (void)managingMediaPlayback {
    self.webView.allowsInlineMediaPlayback = YES; // 视频能否全屏
    self.webView.allowsPictureInPictureMediaPlayback = YES; // 是否支持画中画
    self.webView.mediaPlaybackAllowsAirPlay = YES; // 是否运行AirPlay功能
    self.webView.mediaPlaybackRequiresUserAction = NO;// 视频能否自动播放
}

#pragma mark 刷新
- (IBAction)reload:(id)sender {
    NSLog(@"%d", self.webView.loading);
    // 正在刷新界面时，停止刷新后重新刷新界面
    if (self.webView.loading) {
        [self.webView stopLoading]; // 停止刷新
         _startLoadingCount = _finishLoadingCount = 0;
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

#pragma mark - UIWebViewDelegate
#pragma mark 开始加载网页
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    _startLoadingCount++;
    // 起始设置0.1，让用户感觉在加载
    CGFloat progress = _startLoadingCount == 1 ? 0.1 : self.progressView.progress;
    [self.progressView setProgress:progress animated:YES];
}

#pragma mark 网页加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    _finishLoadingCount++;
    [self.progressView setProgress:_finishLoadingCount / _startLoadingCount animated:YES];
    // 获取document.readyState状态
    NSString *readyState = [webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
    BOOL complete = [readyState isEqualToString:@"complete"];
    if (complete && _finishLoadingCount == _startLoadingCount) {
        NSLog(@"加载完成");
        // 还原状态
        _startLoadingCount = _finishLoadingCount = 0;
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
