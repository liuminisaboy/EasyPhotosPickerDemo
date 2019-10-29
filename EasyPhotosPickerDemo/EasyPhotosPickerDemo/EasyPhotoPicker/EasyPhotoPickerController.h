//
//  EasyPhotoPickerController.h
//  EasyPhotosPickerDemo
//
//  Created by Sen on 2019/10/22.
//  Copyright © 2019 lm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyPhotoManager.h"
#import "EasyFrame.h"


NS_ASSUME_NONNULL_BEGIN

typedef void (^BlockSelectedImages)(NSArray* images);

@interface EasyPhotoPickerController : UIViewController

@property (nonatomic, assign) BOOL allowsMultipleSelection;     //YES-多选 NO-单选，默认NO
@property (nonatomic, assign) NSInteger maxCount;               //可选最大数量，配合多选模式使用，单选模式不必设置

@property (nonatomic, copy) BlockSelectedImages selectImagesBlock;

- (void)showPhotoLibraryWithTarget:(UIViewController*)target success:(BlockSelectedImages)success;

@end


@interface PhotoPickerCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView* photoView;
@property (nonatomic, strong) UIButton* chooseIcon;

@property (nonatomic, assign) BOOL enabled;

@end

NS_ASSUME_NONNULL_END
