//
//  EasyFrame.h
//  EasyPhotosPickerDemo
//
//  Created by Sen on 2019/10/25.
//  Copyright © 2019 lm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define kAPPFrame       [EasyFrame share]

NS_ASSUME_NONNULL_BEGIN

@interface EasyFrame : NSObject

@property (nonatomic, assign) CGFloat screen_width;
@property (nonatomic, assign) CGFloat screen_height;

@property (nonatomic, assign) CGFloat height_statusBar;
@property (nonatomic, assign) CGFloat height_navBar;
@property (nonatomic, assign) CGFloat height_bottomBar;

+ (instancetype)share;

@end

NS_ASSUME_NONNULL_END
