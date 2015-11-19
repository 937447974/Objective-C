//
//  PhotoCollectionViewCell.m
//  Photo
//
//  Created by yangjun on 15/6/5.
//  Copyright (c) 2015年 阳君. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 初始化时加载collectionCell.xib文件
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"PhotoCollectionViewCell" owner:self options:nil];
        // 加载nib
        self = [nibs lastObject];
    }
    return self;
}

+ (CGSize)collectionViewCellSice
{
    return CGSizeMake(100, 100);
}

@end
