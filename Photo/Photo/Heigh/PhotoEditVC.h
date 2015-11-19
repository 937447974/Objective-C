//
//  PhotoEditVC.h
//  Photo
//
//  Created by yangjun on 15/6/8.
//  Copyright (c) 2015年 阳君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocol.h"

/** 编辑照片*/
@interface PhotoEditVC : UIViewController

@property (nonatomic, weak) id <Protocol> delegate;
/** 编辑的照片*/
@property (nonatomic, strong) UIImage *originImage;

@end
