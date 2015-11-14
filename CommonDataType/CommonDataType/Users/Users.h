//
//  Users.h
//  测试
//
//  Created by 阳君 on 14-2-27.
//  Copyright (c) 2014年 阳君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Users : NSObject{
@private
    NSString *_userName;
@private
    int _password;
    // 默认是@producted
    int age;
}

-(void)setUserName:(NSString *) userName;
-(NSString *)userName;

-(void)setPassword:(int) password;
-(int)password;

// 等效getter和setter方法
@property int age;

// 构造方法
-(id)initWithUserName:(NSString *)userName andPassword:(int)password;

@end

