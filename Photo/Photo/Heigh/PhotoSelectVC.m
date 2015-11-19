//
//  PhotoSelectVC.m
//  Photo
//
//  Created by yangjun on 15/6/5.
//  Copyright (c) 2015年 阳君. All rights reserved.
//

#import "PhotoSelectVC.h"
#import "PhotoCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PhotoEditVC.h"

@interface PhotoSelectVC () <UICollectionViewDelegate, UICollectionViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
/** 照片数组*/
@property (nonatomic, strong) NSMutableArray *photos;
/** 照片库*/
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
/** 照片信息*/
@property (nonatomic, strong) ALAssetsGroup *assetsGroup;
/** 用户点击的照片*/
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation PhotoSelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photos = [NSMutableArray new];
    self.selectedIndex = NSIntegerMax;
    // 在ViewDidLoad方法中声明Cell的类，在ViewDidLoad方法中添加，此句不声明，将无法加载，程序崩溃
    [self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"PhotoCollectionViewCell"];
    [self loadAssetsGroup];
}

#pragma mark - IBAction
#pragma mark 启动相机
- (IBAction)onClickCamera:(id)sender
{
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"当前相机不可用" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
        [alertView show];
    }
    else
    {
        UIImagePickerController *imagePickerController = [UIImagePickerController new];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.delegate = self;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    // 保存照片
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    // 关闭
    [picker dismissViewControllerAnimated:YES completion:^{
        // 跳转
        [self performSegueWithIdentifier:@"edit" sender:image];
    }];
}

#pragma mark - 加载手机内的照片
- (void)loadAssetsGroup
{
    self.assetsLibrary = [ALAssetsLibrary new];
    typeof(self) weakSelf = self;
    // 单线程执行
    @autoreleasepool {
        [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            // 刷新
            if (*stop || !group) {
                [weakSelf loadPhotosFromAssetGroup];
            }
            // 加载照片库
            if ([[group valueForProperty:ALAssetsGroupPropertyType] intValue] == ALAssetsGroupSavedPhotos) {
                weakSelf.assetsGroup = group;
            }
        } failureBlock:^(NSError *error) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请进入系统“设置”>“隐私”>“照片”，允许“两万番茄”访问你的照片" preferredStyle:UIAlertControllerStyleAlert];
            [weakSelf showViewController:alertController sender:nil];
        }];
    }
}

- (void)loadPhotosFromAssetGroup
{
    if (self.assetsGroup) {
        [self.assetsGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
        [self.assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (*stop || !result) {
                return ;
            }
            [self.photos addObject:result];
        }];
        // 刷新
        [self.collectionView reloadData];
        // 设置过滤器
        [self.assetsGroup setAssetsFilter:[ALAssetsFilter allAssets]];
        // 输出照片
        [self.assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (*stop || !result) {
                return ;
            }
            NSLog(@"%@", result);
        }];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionViewCell" forIndexPath:indexPath];
    ALAsset *asset = self.photos[indexPath.row];
    cell.imageView.image = [UIImage imageWithCGImage:asset.thumbnail];
    return cell;
}

#pragma mark - UICollectionViewDelegate
#pragma mark 定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [PhotoCollectionViewCell collectionViewCellSice];
}

#pragma mark 点击UICollectionViewCell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"edit" sender:nil];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[PhotoEditVC class]]) {
        PhotoEditVC *vc = (PhotoEditVC *) segue.destinationViewController;
        vc.delegate = self.delegate;
        if (sender) {
            vc.originImage = (UIImage *)sender;
        } else {
            ALAsset *selectedAsset = self.photos[self.selectedIndex];
            ALAssetRepresentation *representation = [selectedAsset defaultRepresentation];
            UIImageOrientation orientation = UIImageOrientationUp;
            NSInteger orientationCount = representation.orientation;
            orientation = orientationCount;
            vc.originImage = [UIImage imageWithCGImage:[[selectedAsset defaultRepresentation] fullResolutionImage] scale:1.0 orientation:orientationCount];
        }
    }
}

@end
