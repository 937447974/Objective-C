//
//  DefaultVC.m
//  Photo
//
//  Created by yangjun on 15/6/5.
//  Copyright (c) 2015年 阳君. All rights reserved.
//

#import "DefaultVC.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface DefaultVC () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

/** 照片*/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation DefaultVC

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

#pragma mark 点击查询按钮
- (IBAction)onClickSearch:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
    actionSheet = [actionSheet initWithTitle:@"照片选择器" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    // 添加按钮
    [actionSheet addButtonWithTitle:@"相机"];
    [actionSheet addButtonWithTitle:@"照片"];
  
    // 添加取消按钮
    [actionSheet addButtonWithTitle:@"取消"];
    actionSheet.cancelButtonIndex = actionSheet.numberOfButtons-1;
    // 样式
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    // 显示到window，防止底部出现toolbar时，取消按钮点击失效
    [actionSheet showInView: self.view.window];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    switch (buttonIndex) {
        case 0:// 相机
            [self pickMediaFromSource:UIImagePickerControllerSourceTypeCamera];
            break;
        case 1:// 照片
            [self pickMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
            break;
        default:
            break;
    }
}

#pragma mark 创建并配置一个图像选取器，通过传入的sourceType判断是应该显示照相机，还是媒体库
- (void)pickMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    NSLog(@"显示照相机，还是媒体库？");
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if ([UIImagePickerController isSourceTypeAvailable:sourceType] && [mediaTypes count] > 0) {
        NSLog(@"显示照相机，还是媒体库");
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"视频错误" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - UIImagePickerControllerDelegate
#pragma mark 选取器视图的委托,检查用户是否选中了一张照片或者一个视频
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"检查用户是否选中了一张照片或者一个视频");
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        UIImage *chosenImage = [info objectForKey:UIImagePickerControllerEditedImage];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"backgroundImage"]];
        NSLog(@"%@",filePath);
        // 保存文件的名称
        [UIImagePNGRepresentation(chosenImage) writeToFile:filePath atomically:YES]; // 保存成功会返回YES
        self.imageView.image = chosenImage;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
