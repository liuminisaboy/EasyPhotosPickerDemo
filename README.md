# EasyPhotosPickerDemo
**简单的系统相册照片选择器**

iOS 9.0 以上
支持选择单张/多张

```ios
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


