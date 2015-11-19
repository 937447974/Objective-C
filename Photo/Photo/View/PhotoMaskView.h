//
//  PhotoMaskView.h
//  Photo
//
//  Created by yangjun on 15/6/8.
//  Copyright (c) 2015年 阳君. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger{
    PhotoMaskViewMaskTypeCircle,// 圆
    PhotoMaskViewMaskTypeRectangle,// 正方形
} PhotoMaskViewMaskType;

@protocol PhotoMaskViewDelegate <NSObject>

- (void)pickingFieldRectChangedTo:(CGRect) rect;

@end

/** 照片遮罩*/
@interface PhotoMaskView : UIView

@property (nonatomic, weak) id <PhotoMaskViewDelegate> delegate;
@property (nonatomic, assign) PhotoMaskViewMaskType maskType;
@property (nonatomic, assign) CGRect pickingFieldRect;

@end
