//
//  ProgressWebView.h
//  UIWebView
//
//  Created by yangjun on 15/11/6.
//  Copyright © 2015年 六月. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProgressWebView;

@protocol ProgressWebViewDelegate <UIWebViewDelegate>

@optional
/**
 *  接受到的数据
 *
 *  @param webView ProgressWebView
 *  @param receivedCount 总连接数
 *  @param totalCount    已完成连接数
 *
 *  @return void
 */
- (void)webView:(ProgressWebView *)webView didReceivedCount:(NSInteger)receivedCount totalCount:(NSInteger)totalCount;

@end

// 有进度的UIWebView
@interface ProgressWebView : UIWebView

@property (nonatomic) NSInteger totalCount;    ///< 总连接数
@property (nonatomic) NSInteger receivedCount; ///< 已完成连接数

@end
