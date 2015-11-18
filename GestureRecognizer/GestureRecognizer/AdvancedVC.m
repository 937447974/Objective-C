//
//  AdvancedVC.m
//  GestureRecognizer
//
//  Created by yangjun on 15/11/8.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "AdvancedVC.h"

@interface AdvancedVC ()
{
    CGFloat _scale;    // 缩放比例
    CGFloat _rotation; // 旋转比例
    CGPoint _translatedPoint; // 移动的位置
}

@property (weak, nonatomic) IBOutlet UIView *gestureView;     ///< 手势界面(视图添加)

@end

@implementation AdvancedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _scale = 1.0;
    _rotation = 0;
    _translatedPoint = CGPointMake(0, 0);
}

#pragma mark UIPinchGestureRecognizer 缩放
- (IBAction)pinchAction:(UIPinchGestureRecognizer *)sender {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    // 放大+；缩小-
    NSLog(@"缩放比例:%f; 缩放速度:%f", sender.scale, sender.velocity);
    CGFloat scale = _scale * sender.scale; // 在上次的缩放比例上进行缩放
    [self setTransform:scale rotation:_rotation translatedPoint:_translatedPoint]; // 缩放手势控制的view
    // 结束时记录缩放比例
    if (sender.state == UIGestureRecognizerStateEnded) {
        _scale = scale;
    }
}

#pragma mark UIRotationGestureRecognizer 旋转
- (IBAction)rotationAction:(UIRotationGestureRecognizer *)sender {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    // 顺时针+；逆时针-
    NSLog(@"旋转比例:%f; 旋转速度:%f", sender.rotation, sender.velocity);
    CGFloat rotation = _rotation + sender.rotation; // 在上次的旋转比例上进行旋转
    // 角度缩到-2M_PI到2M_PI，优化旋转所需内存。M_PI代表顺时针旋转180度
    while (rotation < -2 * M_PI && 2 * M_PI < rotation) {
        if (rotation > 0) {
            rotation -= 2 * M_PI;
        } else {
            rotation += 2 * M_PI;
        }
    }
    [self setTransform:_scale rotation:rotation translatedPoint:_translatedPoint]; // 旋转手势控制的view
    // 结束时记录旋转比例
    if (sender.state == UIGestureRecognizerStateEnded) {
        _rotation = rotation;
    }
}

#pragma mark UIPanGestureRecognizer 平滑
- (IBAction)panAction:(UIPanGestureRecognizer *)sender {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    CGPoint translatedPoint = [sender translationInView:sender.view]; // 移动的位移
    NSLog(@"移动位移:%@", NSStringFromCGPoint(translatedPoint));
    translatedPoint.x += _translatedPoint.x;
    translatedPoint.y += _translatedPoint.y;
    [self setTransform:_scale rotation:_rotation translatedPoint:translatedPoint];
    if (sender.state == UIGestureRecognizerStateEnded) {
        _translatedPoint = translatedPoint;
        [sender setTranslation:CGPointMake(0, 0) inView:self.view];
    }
}

#pragma mark 根据scale缩放比例、rotation旋转比例、translatedPoint移动的位置改变视图
- (void)setTransform:(CGFloat)scale rotation:(CGFloat)rotation translatedPoint:(CGPoint)translatedPoint {
    // 平移的速度会受到缩放比例和旋转比例的影响
    CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale); // 缩放
    transform = CGAffineTransformRotate(transform, rotation); // 旋转
    transform = CGAffineTransformTranslate(transform, translatedPoint.x, translatedPoint.y); // 平移
    // 改变transform
    self.gestureView.transform = transform;
}

@end
