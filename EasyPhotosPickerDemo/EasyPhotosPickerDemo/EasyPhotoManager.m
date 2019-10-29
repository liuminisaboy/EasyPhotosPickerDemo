//
//  EasyPhotoManager.m
//  EasyPhotosPickerDemo
//
//  Created by Sen on 2019/10/22.
//  Copyright © 2019 lm. All rights reserved.
//

#import "EasyPhotoManager.h"


@implementation AlbumsModel

- (instancetype)initWithTitle:(NSString*)title assets:(PHFetchResult<PHAsset *> *)assets
{
    self = [super init];
    if (self) {
        _title = title;
        _assets = assets;
    }
    return self;
}

@end

@implementation EasyPhotoManager


+ (NSArray*)fetchAllAsset {
    
    NSMutableArray* all = [NSMutableArray array];
    
    //All photos
    PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
    
    // 按创建时间升序
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    
    PHFetchResult<PHAsset *> *allPhotos = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    
    AlbumsModel* allPhotosModel = [[AlbumsModel alloc] initWithTitle:@"所有照片" assets:allPhotos];
    [all addObject:allPhotosModel];
    
    
    //内置智能相簿
    PHFetchResult<PHAssetCollection *> *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    [smartAlbums enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        PHFetchResult<PHAsset *> *tmpresult = [PHAsset fetchAssetsInAssetCollection:obj options:nil];
        
        if (tmpresult.count > 0)
        {
            AlbumsModel* tmpModel = [[AlbumsModel alloc] initWithTitle:obj.localizedTitle assets:tmpresult];
            [all addObject:tmpModel];
        }
        
    }];
    
    
    //用户自己创建的相簿
    PHFetchResult<PHAssetCollection *> *userAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    
    [userAlbums enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        PHFetchResult<PHAsset *> *tmpresult = [PHAsset fetchAssetsInAssetCollection:obj options:nil];
        
        if (tmpresult.count > 0)
        {
            AlbumsModel* tmpModel = [[AlbumsModel alloc] initWithTitle:obj.localizedTitle assets:tmpresult];
            [all addObject:tmpModel];
        }
    }];
    
    return all;
}

+ (AlbumsModel*)fetchDefaultPhotos {
    
    //All photos
    PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
    
    // 按创建时间升序
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    
    PHFetchResult<PHAsset *> *allPhotos = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    
    AlbumsModel* allPhotosModel = [[AlbumsModel alloc] initWithTitle:@"所有照片" assets:allPhotos];
    
    return allPhotosModel;
}

+ (void)requestImageForAsset:(PHAsset *)asset success:(void (^)(UIImage * image))success {
    
    PHImageRequestOptions* options = [[PHImageRequestOptions alloc] init];
    options.synchronous = NO;
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    options.deliveryMode = PHImageRequestOptionsResizeModeFast;
    
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(200, 200) contentMode:PHImageContentModeAspectFill options:options  resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        success(result);
        
    }];
}

@end
