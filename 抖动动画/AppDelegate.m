//
//  AppDelegate.m
//  抖动动画
//
//  Created by KnowChat03 on 2019/10/24.
//  Copyright © 2019 KnowChat03. All rights reserved.
//

#import "AppDelegate.h"
#import "AnimationVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [AnimationVC new];
    return YES;
}


@end
