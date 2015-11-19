//
//  PhotoSelectVC.h
//  Photo
//
//  Created by yangjun on 15/6/5.
//  Copyright (c) 2015年 阳君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocol.h"

@interface PhotoSelectVC : UIViewController

@property (nonatomic, weak) id <Protocol> delegate;

@end
