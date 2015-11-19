//
//  Protocol.h
//  Photo
//
//  Created by yangjun on 15/6/8.
//  Copyright (c) 2015年 阳君. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 核心代理类*/
@protocol Protocol <NSObject>

@optional

/**
 *  viewcontroller之间的传值回调
 *
 *  @param sender 发送数据的视图
 *  @param values 下个视图回传的数据
 *
 *  @return void
 */
-(void)passValue:(id)sender values:(NSMutableDictionary *)values;

@end
