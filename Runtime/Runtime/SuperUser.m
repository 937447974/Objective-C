//
//  SuperUser.m
//  Runtime
//
//  Created by yangjun on 15/9/23.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "SuperUser.h"

@implementation SuperUser

- (id)initWithUserName:(NSString *)userName
{
    self = [super initWithUserName:userName];
    if (self) {
        _ID = 8888;
    }
    return self;
}

@end
