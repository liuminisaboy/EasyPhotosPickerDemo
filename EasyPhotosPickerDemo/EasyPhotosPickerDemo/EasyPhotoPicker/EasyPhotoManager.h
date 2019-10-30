//
//  EasyPhotoManager.h
//  EasyPhotosPickerDemo
//
//  Created by Sen on 2019/10/22.
//  Copyright © 2019 lm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN


@interface AlbumsModel : NSObject

@property (nonatomic, copy) NSString* title;
@property (nonatomic, strong) PHFetchResult<PHAsset *> * assets;

- (instancetype)initWithTitle:(NSString*)title assets:(PHFetchResult<PHAsset *> *)assets;

@end

@interface EasyPhotoManager : NSObject

+ (NSArray*)fetchAllAlbums;  //获取所有相簿

+ (AlbumsModel*)fetchDefaultPhotos; //获取默认显示的所有照片

//asset 转 image
+ (void)requestImageForAsset:(PHAsset *)asset success:(void (^)(UIImage * image))success;

@end

NS_ASSUME_NONNULL_END
