//
//  YJPoint.h
//  GestureRecognizer
//
//  Created by yangjun on 15/11/9.
//  Copyright © 2015年 阳君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** CGPoint转为对象*/
@interface YJPoint : NSObject

@property (nonatomic) CGFloat x; ///< x坐标
@property (nonatomic) CGFloat y; ///< y坐标

/**
 *  初始化
 *
 *  @param point CGPoint点
 *
 *  @return YJPoint
 */
- (instancetype)initWithPoint:(CGPoint)point;

@end
