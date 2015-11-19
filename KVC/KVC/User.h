//
//  User.h
//  KVC
//
//  Created by yangjun on 15/10/10.
//  Copyright © 2015年 六月. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Address.h"

/** 用户*/
@interface User : NSObject

@property (nonatomic, copy) NSString *userName; ///< 用户名
@property (nonatomic, strong) Address *address; ///< 用户地址

@end
