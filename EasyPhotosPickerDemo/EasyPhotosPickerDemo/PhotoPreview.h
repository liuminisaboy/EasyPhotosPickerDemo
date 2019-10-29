//
//  PhotoPreview.h
//  EasyPhotosPickerDemo
//
//  Created by Sen on 2019/10/22.
//  Copyright © 2019 lm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyPhotoManager.h"

NS_ASSUME_NONNULL_BEGIN

@class PhotoPreview;

@protocol PhotoPreviewDelegate <NSObject>

- (void)addPhotoPreview:(PhotoPreview*)preview;

@end

@interface PhotoPreview : UIView
<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) id <PhotoPreviewDelegate> delegate;
@property (nonatomic, strong) UICollectionView* myCollectionView;
@property (nonatomic, strong) NSMutableArray* listInfo;

@end



@interface PhotoCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView* photoView;

@end




NS_ASSUME_NONNULL_END
