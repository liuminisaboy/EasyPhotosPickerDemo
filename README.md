# EasyPhotosPickerDemo
## 简单的系统相册照片选择器
## 实现方式
```Objective-C
<Photos/Photos.h>
PHFetchResult  资源集合，类似数组
PHAssetCollection 一个相簿
PHAsset 代表照片库中的一个资源，可转化成缩略图 UIImage
```
## 获取所有相簿目录
```Objective-C
//获取一个相簿，内容是所有照片
//配置获取参数：按创建时间升序
PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init]; 
allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]]; 
//获取资源集合通过可选条件
PHFetchResult<PHAsset *> *allPhotos = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
//转换成相簿Model
AlbumsModel* allPhotosModel = [[AlbumsModel alloc] initWithTitle:@"所有照片" assets:allPhotos];
```
```Objective-C
//获取所有的内置相簿
PHFetchResult<PHAssetCollection *> *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
[smartAlbums enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    PHFetchResult<PHAsset *> *tmpresult = [PHAsset fetchAssetsInAssetCollection:obj options:nil];
    if (tmpresult.count > 0)
    {
        AlbumsModel* tmpModel = [[AlbumsModel alloc] initWithTitle:obj.localizedTitle assets:tmpresult];
        [all addObject:tmpModel];
    }
}];
```
```Objective-C
//获取所有用户自建相簿
PHFetchResult<PHAssetCollection *> *userAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];    
[userAlbums enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    PHFetchResult<PHAsset *> *tmpresult = [PHAsset fetchAssetsInAssetCollection:obj options:nil];
    if (tmpresult.count > 0)
    {
        AlbumsModel* tmpModel = [[AlbumsModel alloc] initWithTitle:obj.localizedTitle assets:tmpresult];
        [all addObject:tmpModel];
    }
}];
```

## 获取资源缩略图
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
