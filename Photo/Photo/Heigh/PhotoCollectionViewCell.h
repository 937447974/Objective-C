//
//  PhotoCollectionViewCell.h
//  Photo
//
//  Created by yangjun on 15/6/5.
//  Copyright (c) 2015年 阳君. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

+ (CGSize)collectionViewCellSice;

@end
