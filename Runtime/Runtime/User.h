//
//  User.h
//  Runtime
//
//  Created by yangjun on 15/9/21.
//  Copyright © 2015年 六月. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 用户
@interface User : NSObject

@property (nonatomic, copy) NSString *userName;///< 用户名

/**
 *  初始化
 *
 *  @param userName 用户名
 *
 *  @return id
 */
- (id)initWithUserName:(NSString *)userName;

/**
 *  初始化
 *
 *  @param userName 用户名
 *
 *  @return id
 */
+ (id)userWithUserName:(NSString *)userName;

@end
