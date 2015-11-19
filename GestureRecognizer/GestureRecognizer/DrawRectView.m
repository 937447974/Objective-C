//
//  DrawRectView.m
//  GestureRecognizer
//
//  Created by yangjun on 15/11/9.
//  Copyright © 2015年 阳君. All rights reserved.
//

#import "DrawRectView.h"

@implementation DrawRectView

#pragma mark 懒加载
- (NSMutableArray<YJPoint *> *)pointArray {
    if (_pointArray == nil) {
        _pointArray = [NSMutableArray array];
    }
    return _pointArray;
}

#pragma mark 重画
- (void)drawRect:(CGRect)rect {
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //在每次绘制前，清空上下文
    CGContextClearRect(ctx, rect);
    // 添加线条
    BOOL first = YES;
    //绘图（线段）
    for (YJPoint *point in self.pointArray) {
        if (first) {
            first = NO;
            // 设置起点
            CGContextMoveToPoint(ctx, point.x, point.y);
        } else {
            CGContextAddLineToPoint(ctx, point.x, point.y);
        }
    }
    // 设置线条的属性
    CGContextSetLineWidth(ctx, 2);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(ctx, self.lineColor.CGColor);
    CGContextStrokePath(ctx);
}

@end
