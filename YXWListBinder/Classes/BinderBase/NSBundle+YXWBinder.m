//
//  NSBundle+YXWBinder.m
//  YXWListBinder
//
//  Created by 原晓文 on 2018/10/25.
//

#import "NSBundle+YXWBinder.h"
#import "YXWListBinder.h"

@implementation NSBundle (YXWBinder)

+ (nonnull NSBundle *)YXWListBinderBundle {
    return [NSBundle bundleWithURL:[[NSBundle bundleForClass:[YXWListBinder class]] URLForResource:@"YXWListBinder" withExtension:@"bundle"]];
}

@end
