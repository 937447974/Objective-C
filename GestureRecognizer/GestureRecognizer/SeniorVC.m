//
//  SeniorVC.m
//  GestureRecognizer
//
//  Created by yangjun on 15/11/8.
//  Copyright © 2015年 六月. All rights reserved.
//

#import "SeniorVC.h"
#import "DrawRectView.h"

/** 屏幕宽度*/
#define UIScreenWeight [[UIScreen mainScreen] bounds].size.width
/** 屏幕高度*/
#define UIScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface SeniorVC ()
{
    CGPoint _currentPoint; ///< 定义一个属性，记录当前点
    NSMutableArray *_buttonArray; ///< 按钮集合
    NSMutableArray *_buttonSelectedArray; ///< 用户点击的按钮
}

@property (weak, nonatomic) IBOutlet UIButton *button1; ///< 按钮1
@property (weak, nonatomic) IBOutlet UIButton *button2; ///< 按钮2
@property (weak, nonatomic) IBOutlet UIButton *button3; ///< 按钮3
@property (weak, nonatomic) IBOutlet DrawRectView *drawRectView; /// 绘画图

@property (nonatomic) BOOL verifySuccess; /** 验证是否成功*/

@end

@implementation SeniorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 动态规划按钮之间的距离
    CGFloat constant = (UIScreenWeight - 3 * self.button2.frame.size.width) / 5;
    for (NSLayoutConstraint *con in self.view.constraints)
    {
        if (con.constant == 50)// 默认距离
        {
            con.constant = constant;
        }
    }
    // 按钮统一管理
    _buttonArray = [NSMutableArray arrayWithCapacity:9];
    _buttonSelectedArray = [NSMutableArray arrayWithCapacity:9];
    [_buttonArray addObject:self.button1];
    [_buttonArray addObject:self.button2];
    [_buttonArray addObject:self.button3];
    
    for (UIButton *button in _buttonArray) {
        // 设置按钮的状态背景
        [button setBackgroundImage:[UIImage imageNamed:@"gestures_white"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"gestures_yellow"] forState:UIControlStateSelected];
        // 禁止按钮的点击事件
        button.userInteractionEnabled = NO;
    }
}

#pragma mark verifySuccess的setter方法
- (void)setVerifySuccess:(BOOL)verifySuccess {
    _verifySuccess = verifySuccess;
    // 按钮显示
    UIImage *image = _verifySuccess ? [UIImage imageNamed:@"gestures_yellow"] : [UIImage imageNamed:@"gestures_red"];
    for (UIButton *button in _buttonArray) {
        [button setBackgroundImage:image forState:UIControlStateSelected];
    }
    // 通知view重新绘制
    [self setNeedsDisplay];
}

#pragma mark - 初始化UI
- (void)initUI
{
    [_buttonSelectedArray removeAllObjects];// 清空
    // 所有按钮未选中
    for (UIButton *button in _buttonArray) {
        [button setSelected:NO];
    }
    [self setNeedsDisplay];
}

#pragma mark - 获取用户触摸的按钮
- (UIButton *)getCurrentButton:(NSSet *)touches {
    // 获取用户点击的坐标
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:touch.view];
    // 根据坐标判断是否触摸到按钮
    for (UIButton *button in _buttonArray) {
        if (CGRectContainsPoint(button.frame, point)) {
            return button;
        }
    }
    return nil;
}

#pragma mark 重绘线条
- (void)setNeedsDisplay {
    // 添加点
    [self.drawRectView.pointArray removeAllObjects];
    for (UIButton *button in _buttonSelectedArray) {
        YJPoint *point = [[YJPoint alloc] initWithPoint:button.center];
        [self.drawRectView.pointArray addObject:point];
    }
    // 当手指在屏幕上时，要连接这个点
    if (!(_currentPoint.x == 0 && _currentPoint.y == 0)) {
        YJPoint *point = [[YJPoint alloc] initWithPoint:_currentPoint];
        [self.drawRectView.pointArray addObject:point];
    }
    // 线条颜色
    if (self.verifySuccess)
        self.drawRectView.lineColor = [UIColor colorWithRed:241/255.0 green:216/255.0 blue:71/255.0 alpha:1.0];
    else
        self.drawRectView.lineColor = [UIColor colorWithRed:255/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
    // 重绘drawRectView
    [self.drawRectView setNeedsDisplay];
}

#pragma mark - 手指触摸开始
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_buttonSelectedArray removeAllObjects];// 清空
    self.verifySuccess = YES;
    _currentPoint = CGPointZero;
    UIButton *button = [self getCurrentButton:touches];
    if (button && button.selected == NO) {
        button.selected = YES;
        [_buttonSelectedArray addObject:button];
    }
}

#pragma mark 手指移动
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UIButton *button = [self getCurrentButton:touches];
    // 已经选中的按钮，不可再选
    if (button && button.selected == NO) {
        button.selected = YES; // 设置按钮的选中状态
        [_buttonSelectedArray addObject:button];
    }
    // 用户未触摸按钮时，记录当前点
    UITouch *touch = touches.anyObject;
    _currentPoint = [touch locationInView:touch.view];
    //通知view重新绘制
    [self setNeedsDisplay];
}

#pragma mark 手指离开
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    _currentPoint = CGPointZero;
    NSMutableString *result=[NSMutableString string];
    for (UIButton *btn in _buttonSelectedArray) {
        [result appendFormat:@"%d", (int)btn.tag];
    }
    NSString *password = @"123"; // 设置密码
    if ([result isEqual:password]) {
        NSLog(@"密码输入正确：%@", result);
        self.verifySuccess = YES;
    } else {
        NSLog(@"密码输入错误：%@", result);
        self.verifySuccess = NO;
    }
    // 0.5秒后初始化UI
    [self performSelector:@selector(initUI) withObject:nil afterDelay:0.5];
}

@end
