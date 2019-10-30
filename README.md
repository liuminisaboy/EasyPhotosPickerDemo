# EasyPhotosPickerDemo
**简单的系统相册照片选择器**

#实现方式
PhotoKit iOS8之后

```Objective-C
PHFetchResult  资源集合，类似数组
PHAssetCollection 一个相簿
PHAsset 代表照片库中的一个资源，可转化成 UIImage

```

iOS 9.0 以上 / 单选 / 多选 / 简单 

```Objective-C
//默认选择单张
EasyPhotoPickerController* vc = [[EasyPhotoPickerController alloc] init];
[vc showPhotoLibraryWithTarget:self success:^(NSArray * _Nonnull images) {
    [self.headerIconView setImage:images.firstObject forState:UIControlStateNormal];
}];
 
 //多张
 EasyPhotoPickerController* vc = [[EasyPhotoPickerController alloc] init];
 vc.allowsMultipleSelection = YES;
 vc.maxCount = 9-self.photoPreview.listInfo.count+1;
 [vc showPhotoLibraryWithTarget:self success:^(NSArray * _Nonnull images) {
     self.photoPreview.listInfo = [images mutableCopy];
 }];
 ```
 
 ![epp1.png](https://github.com/liuminisaboy/EasyPhotosPickerDemo/blob/master/epp1.png)
