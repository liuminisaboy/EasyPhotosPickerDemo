# EasyPhotosPickerDemo
**简单的系统相册照片选择器**

iOS 9.0 以上
支持选择单张/多张

```EasyPhotoPickerController* vc = [[EasyPhotoPickerController alloc] init];
    [vc showPhotoLibraryWithTarget:self success:^(NSArray * _Nonnull images) {
        [self.headerIconView setImage:images.firstObject forState:UIControlStateNormal];
    }];


