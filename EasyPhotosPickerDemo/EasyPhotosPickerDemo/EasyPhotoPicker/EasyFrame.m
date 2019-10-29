//
//  EasyFrame.m
//  EasyPhotosPickerDemo
//
//  Created by Sen on 2019/10/25.
//  Copyright © 2019 lm. All rights reserved.
//

#import "EasyFrame.h"

@implementation EasyFrame


+ (instancetype)share {
    
    static EasyFrame* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[EasyFrame alloc] init];
    });
    
    return manager;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.screen_width = [UIScreen mainScreen].bounds.size.width;
        self.screen_height = [UIScreen mainScreen].bounds.size.height;
        
        if (@available(iOS 13.0, *)) {
            UIStatusBarManager* sm = [UIApplication sharedApplication].delegate.window.windowScene.statusBarManager;
            self.height_statusBar = sm.statusBarFrame.size.height;
        }else {
            self.height_statusBar = [UIApplication sharedApplication].statusBarFrame.size.height;
        }
        
        self.height_navBar = 44+self.height_statusBar;
        
        self.height_bottomBar = self.height_navBar-4;
        
    }
    return self;
}

@end
