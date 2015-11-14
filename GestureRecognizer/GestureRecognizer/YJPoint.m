//
//  YJPoint.m
//  GestureRecognizer
//
//  Created by yangjun on 15/11/9.
//  Copyright © 2015年 阳君. All rights reserved.
//

#import "YJPoint.h"

@implementation YJPoint

- (instancetype)initWithPoint:(CGPoint)point {
    self = [super init];
    if (self) {
        self.x = point.x;
        self.y = point.y;
    }
    return self;
}

@end
