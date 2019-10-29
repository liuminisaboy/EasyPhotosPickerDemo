//
//  AppDelegate.m
//  EasyPhotosPickerDemo
//
//  Created by Sen on 2019/10/21.
//  Copyright © 2019 lm. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor blackColor];
    
    ViewController* vc = [[ViewController alloc] init];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
    _window.rootViewController = nav;
    
    [_window makeKeyAndVisible];
    
    return YES;
}



@end
