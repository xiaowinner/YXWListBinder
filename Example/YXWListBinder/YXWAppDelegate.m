//
//  YXWAppDelegate.m
//  YXWListBinder
//
//  Created by 原晓文 on 09/21/2018.
//  Copyright (c) 2018 原晓文. All rights reserved.
//

#import "YXWAppDelegate.h"
#import <DoraemonKit/DoraemonKit.h>

@implementation YXWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //在Main.storyboard切换控制器即可
    [[DoraemonManager shareInstance] install];
    return YES;
}

@end
