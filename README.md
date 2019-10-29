# EasyPhotosPickerDemo
**简单的系统相册照片选择器**

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
