//
//  HeighVC.m
//  Photo
//
//  Created by yangjun on 15/6/5.
//  Copyright (c) 2015年 阳君. All rights reserved.
//

#import "HeighVC.h"
#import "Protocol.h"
#import "PhotoSelectVC.h"

@interface HeighVC () <UIActionSheetDelegate, Protocol>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation HeighVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark view即将完毕
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 显示tabBar
    self.tabBarController.tabBar.hidden = NO;
    
}

#pragma mark view显示完毕
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 显示tabBar
    self.tabBarController.tabBar.hidden = NO;

}

#pragma mark view即将消失
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 隐藏tabBar
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - Protocol
-(void)passValue:(id)sender values:(NSMutableDictionary *)values
{
    self.imageView.image = [values objectForKey:@"image"];
    self.imageView.clipsToBounds = YES;
    self.imageView.layer.cornerRadius = self.imageView.bounds.size.width / 2;
    self.imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;// 边的颜色
    self.imageView.layer.borderWidth = 1;// 边大小
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[PhotoSelectVC class]])
    {
        PhotoSelectVC *vc = (PhotoSelectVC *) segue.destinationViewController;
        vc.delegate = self;
    }
}


@end
