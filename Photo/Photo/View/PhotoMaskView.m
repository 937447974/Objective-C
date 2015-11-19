//
//  PhotoMaskView.m
//  Photo
//
//  Created by yangjun on 15/6/8.
//  Copyright (c) 2015年 阳君. All rights reserved.
//

#import "PhotoMaskView.h"

CGFloat const kWidthGap = 80;
CGFloat const kHeightGap = 40;

@implementation PhotoMaskView

-(void)drawRect:(CGRect)rect
{
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGFloat pickingFieldWidth = width < height ? (width - kWidthGap) : (height - kHeightGap);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSaveGState(contextRef);
    
    CGContextSetRGBFillColor(contextRef, 0, 0, 0, 0.35);// 阴影色
    CGContextSetLineWidth(contextRef, 3);
    self.pickingFieldRect = CGRectMake((width - pickingFieldWidth) / 2, (height - pickingFieldWidth) / 2, pickingFieldWidth, pickingFieldWidth);
    
    // 阴影
    UIBezierPath *pickingFieldPath = [self pickingFieldShapePathForType:self.maskType];
    UIBezierPath *bezierPathRect = [UIBezierPath bezierPathWithRect:rect];
    [bezierPathRect appendPath:pickingFieldPath];
    bezierPathRect.usesEvenOddFillRule = YES;
    [bezierPathRect fill];
    
    // 圆圈边
    CGContextSetLineWidth(contextRef, 2);
    CGContextSetRGBStrokeColor(contextRef, 255, 255, 255, 1);
    CGFloat dash[2] = {4,4};
    [pickingFieldPath setLineDash:dash count:2 phase:0];
    [pickingFieldPath stroke];
    CGContextRestoreGState(contextRef);
    self.layer.contentsGravity = kCAGravityCenter;
    
    // 通知圆的位置
    if ([self.delegate respondsToSelector:@selector(pickingFieldRectChangedTo:)])
    {
        [self.delegate pickingFieldRectChangedTo:self.pickingFieldRect];
    }
}

- (UIBezierPath *)pickingFieldShapePathForType:(PhotoMaskViewMaskType)type
{
    switch (self.maskType) {
        case PhotoMaskViewMaskTypeCircle:
            return [UIBezierPath bezierPathWithOvalInRect:self.pickingFieldRect];
            break;
        case PhotoMaskViewMaskTypeRectangle:
            return [UIBezierPath bezierPathWithRect:self.pickingFieldRect];
            break;
        default:
            break;
    }
}

@end
