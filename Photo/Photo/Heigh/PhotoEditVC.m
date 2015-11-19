//
//  PhotoEditVC.m
//  Photo
//
//  Created by yangjun on 15/6/8.
//  Copyright (c) 2015年 阳君. All rights reserved.
//

#import "PhotoEditVC.h"
#import "PhotoMaskView.h"

@interface PhotoEditVC () <UIScrollViewDelegate, UIContentContainer, PhotoMaskViewDelegate>

/** 滚动视图*/
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet PhotoMaskView *maskView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, assign) BOOL needAdjustScrollViewZoomScale;
@property (nonatomic, assign) CGRect pickingFieldRect;

@end

@implementation PhotoEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = self.originImage;
    self.maskView.delegate = self;
    self.maskView.maskType = PhotoMaskViewMaskTypeCircle;
    self.pickingFieldRect = CGRectZero;
    self.needAdjustScrollViewZoomScale = YES;
}

#pragma mark - IBAction
- (IBAction)onClickDone:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(passValue:values:)])
    {
        // 获取剪切的位置
        CGRect clipedRect = self.pickingFieldRect;
        CGFloat zoomScale = self.scrollView.zoomScale;
        // 缩放
        clipedRect.size.width = clipedRect.size.width / zoomScale;
        clipedRect.size.height = clipedRect.size.height / zoomScale;
        // 取x,y
        clipedRect.origin.x = (self.scrollView.contentOffset.x + clipedRect.origin.x) / zoomScale;
        clipedRect.origin.y = (self.scrollView.contentOffset.y + clipedRect.origin.y) / zoomScale;
        
        // 截屏
        CGImageRef imageRef = CGImageCreateWithImageInRect([self fixrotation:self.originImage].CGImage, clipedRect);
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        [self.delegate passValue:self values:[NSMutableDictionary dictionaryWithObject:image forKey:@"image"]];
    }
    // 多级页面跳转
    NSInteger currentIndex = [self.navigationController.viewControllers indexOfObject:self];
    [self.navigationController popToViewController:self.navigationController.viewControllers[currentIndex - 2] animated:YES];
}

#pragma mark - PhotoMaskViewDelegate
- (void)pickingFieldRectChangedTo:(CGRect)rect
{
    self.pickingFieldRect = rect;
    CGFloat topGap = rect.origin.y;
    CGFloat leftGap = rect.origin.x;
    self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(topGap, leftGap, topGap, leftGap);
    self.scrollView.contentInset = UIEdgeInsetsMake(topGap, leftGap, topGap, leftGap);
    
    CGFloat maskCircleWidth = rect.size.width;
    CGSize imageSize = self.originImage.size;
    self.scrollView.contentSize = imageSize;
    CGFloat minimunZoomScale = imageSize.width < imageSize.height ? maskCircleWidth / imageSize.width : maskCircleWidth / imageSize.height;
    CGFloat maximumZoomScale = 5;
    self.scrollView.minimumZoomScale = minimunZoomScale;
    self.scrollView.maximumZoomScale = maximumZoomScale;
    self.scrollView.zoomScale = self.scrollView.zoomScale < minimunZoomScale ? minimunZoomScale : self.scrollView.zoomScale;
    
    if (self.needAdjustScrollViewZoomScale) {
        CGFloat temp = self.view.bounds.size.width < self.view.bounds.size.height ? self.view.bounds.size.width : self.view.bounds.size.height;
        minimunZoomScale = imageSize.width < imageSize.height ? temp / imageSize.width : temp / imageSize.height;
        self.scrollView.zoomScale = minimunZoomScale;
        self.needAdjustScrollViewZoomScale = NO;
    }
}

#pragma mark - UIContentContainer protocol
- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    [self.maskView setNeedsDisplay];
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

#pragma mark - 照片处理
- (UIImage *)fixrotation:(UIImage *)image
{
    // See here for detail:
    //http://stackoverflow.com/questions/8915630/ios-uiimageview-how-to-handle-uiimage-image-orientation/15039609#15039609
    if (image.imageOrientation == UIImageOrientationUp) return image;
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
