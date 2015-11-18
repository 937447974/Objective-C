//
//  BaseVC.m
//  GestureRecognizer
//
//  Created by yangjun on 15/11/8.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@property (weak, nonatomic) IBOutlet UIView *gestureView;     ///< 手势界面(视图添加)
@property (weak, nonatomic) IBOutlet UIView *gestureCodeView; ///< 手势界面(代码添加)

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    BOOL codeHidden = NO; // YES视图测试，NO代码测试
    self.gestureView.hidden = !codeHidden;
    self.gestureCodeView.hidden = codeHidden;
    self.gestureCodeView.userInteractionEnabled = YES; // 开启手势响应
    
    //UITapGestureRecognizer 短点击
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];// 初始化指定回调target和方法action
    tapGR.numberOfTapsRequired = 1; // 手指连续点击的次数，默认1
    tapGR.numberOfTouchesRequired = 1; // 有几个手指点击，默认1
    [self.gestureCodeView addGestureRecognizer:tapGR];
    
    // UILongPressGestureRecognizer长点击
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    longPressGR.numberOfTapsRequired = 1; // 长点击点击次数,默认0
    longPressGR.numberOfTouchesRequired = 1; // 手指数,默认1
    longPressGR.minimumPressDuration = 0.5; // 长按最低时间,默认0.5秒
    longPressGR.allowableMovement = 10; // 手指长按时可移动的区域，默认10像素
    [self.gestureCodeView addGestureRecognizer:longPressGR];
    
    // UIPinchGestureRecognizer缩放
    UIPinchGestureRecognizer *pinchGR = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
    [self.gestureCodeView addGestureRecognizer:pinchGR];

    // UIRotationGestureRecognizer旋转
    UIRotationGestureRecognizer *rotationGR = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationAction:)];
    [self.gestureCodeView addGestureRecognizer:rotationGR];
    
    // UISwipeGestureRecognizer 固定方向滑动
    UISwipeGestureRecognizer *swipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipeGR.numberOfTouchesRequired = 1; // 手指数，默认1
    swipeGR.direction = UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight; // 手势响应
    [self.gestureCodeView addGestureRecognizer:swipeGR];
    
    // UIScreenEdgePanGestureRecognizer 边缘滑动
    UIScreenEdgePanGestureRecognizer *screenEdgePanGR = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(screenEdgePanAction:)];
    screenEdgePanGR.edges = UIRectEdgeAll; // 所有方向
    [self.gestureCodeView addGestureRecognizer:screenEdgePanGR];
    
    // UIPanGestureRecognizer 滑动手势，会影响其他手势的响应
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    panGR.minimumNumberOfTouches = 1; // 最少手指数，默认1.
    panGR.maximumNumberOfTouches = 1; // 最多响应的手指，默认UINT_MAX
    [self.gestureCodeView addGestureRecognizer:panGR];
    [panGR requireGestureRecognizerToFail:swipeGR]; //UISwipeGestureRecognizer失效时才判断UIPanGestureRecognizer
    
}

#pragma mark UITapGestureRecognizer 点击
- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSLog(@"点击数:%lu; 手指数:%lu", (unsigned long)sender.numberOfTapsRequired, (unsigned long)sender.numberOfTouchesRequired);
    CGPoint location = [sender locationInView:self.view];
    NSLog(@"点击的位置:%@", NSStringFromCGPoint(location));
}

#pragma mark UILongPressGestureRecognizer长点击
- (IBAction)longPressAction:(UILongPressGestureRecognizer *)sender {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

#pragma mark UIPinchGestureRecognizer 缩放
- (IBAction)pinchAction:(UIPinchGestureRecognizer *)sender {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    // 放大+；缩小-
    NSLog(@"缩放比例:%f; 缩放速度:%f", sender.scale, sender.velocity);
}

#pragma mark UIRotationGestureRecognizer 旋转
- (IBAction)rotationAction:(UIRotationGestureRecognizer *)sender {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    // 顺时针+；逆时针-
    NSLog(@"旋转角度:%f; 旋转速度:%f", sender.rotation, sender.velocity);
}

#pragma mark UISwipeGestureRecognizer 固定方向滑动
- (IBAction)swipeAction:(UISwipeGestureRecognizer *)sender {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSLog(@"手指数:%ld", (unsigned long)sender.numberOfTouchesRequired);
    switch (sender.direction) {
        case UISwipeGestureRecognizerDirectionRight:
            NSLog(@"向右滑");
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            NSLog(@"向左滑");
            break;
        case UISwipeGestureRecognizerDirectionUp:
            NSLog(@"向上滑");
            break;
        case UISwipeGestureRecognizerDirectionDown:
            NSLog(@"向下滑");
            break;
    }
}

#pragma mark UIScreenEdgePanGestureRecognizer 边缘滑动
- (IBAction)screenEdgePanAction:(UIScreenEdgePanGestureRecognizer *)sender {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    switch (sender.edges) {
        case UIRectEdgeNone:
            NSLog(@"无边缘");
            break;
        case UIRectEdgeTop:
            NSLog(@"上边缘");
            break;
        case UIRectEdgeLeft:
            NSLog(@"左边缘");
            break;
        case UIRectEdgeBottom:
            NSLog(@"下边缘");
            break;
        case UIRectEdgeRight:
            NSLog(@"右边缘");
            break;
        case UIRectEdgeAll:
            NSLog(@"UIRectEdgeTop | UIRectEdgeLeft | UIRectEdgeBottom | UIRectEdgeRight");
            break;
    }
}

#pragma mark UIPanGestureRecognizer 平滑
- (IBAction)panAction:(UIPanGestureRecognizer *)sender {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    CGPoint velocityPoint = [sender translationInView:sender.view]; // 移动的速度
    NSLog(@"移动速度:%@", NSStringFromCGPoint(velocityPoint));
    CGPoint translatedPoint = [sender translationInView:sender.view]; // 移动的位移
    NSLog(@"移动位移:%@", NSStringFromCGPoint(translatedPoint));
}

@end
