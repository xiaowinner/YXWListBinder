//
//  UIView+YXWBinder.m
//  YXWListBinder
//
//  Created by 原晓文 on 2018/10/25.
//

#import "UIView+YXWBinder.h"
#import "NSBundle+YXWBinder.h"

@implementation UIView (YXWBinder)

+ (instancetype)viewFromYXWListBinderNib
{
    NSBundle *bundle = [NSBundle YXWListBinderBundle];
    return [[bundle loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

+ (UINib *)nibFromYXWListBinder
{
    NSBundle *bundle = [NSBundle YXWListBinderBundle];
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:bundle];
}


@end
