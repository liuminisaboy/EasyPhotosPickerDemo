//
//  EasyAlbumsView.h
//  EasyPhotosPickerDemo
//
//  Created by Sen on 2019/10/22.
//  Copyright © 2019 lm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyPhotoManager.h"
#import "EasyFrame.h"

NS_ASSUME_NONNULL_BEGIN

@class EasyAlbumsView;
@protocol EasyAlbumsViewDelegate <NSObject>

- (void)albumsView:(EasyAlbumsView*)albumsView didSelectAlbumsModel:(AlbumsModel *)albumsModel;

@end

@interface EasyAlbumsView : UIVisualEffectView

@property (nonatomic, strong) NSArray* listInfo;
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, weak) id<EasyAlbumsViewDelegate> delegate;

+ (instancetype)albumView;

- (void)show;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
