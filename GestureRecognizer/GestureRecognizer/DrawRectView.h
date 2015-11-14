//
//  DrawRectView.h
//  GestureRecognizer
//
//  Created by yangjun on 15/11/9.
//  Copyright © 2015年 阳君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJPoint.h"

/** DrawRect监听*/
@interface DrawRectView : UIView

@property (nonatomic, strong) NSMutableArray<YJPoint *> *pointArray; ///< 线条的节点
@property (nonatomic, strong) UIColor *lineColor; ///< 线条的颜色

@end


