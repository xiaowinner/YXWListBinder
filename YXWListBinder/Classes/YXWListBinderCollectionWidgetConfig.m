//
//  YXWListBinderCollectionWidgetConfig.m
//
//  Created by 原晓文 on 2020/6/19.
//

#import "YXWListBinderCollectionWidgetConfig.h"

@implementation YXWListBinderCollectionWidgetConfig

- (instancetype)init
{
    self = [self initWithWidgetSize:CGSizeZero sectionInset:UIEdgeInsetsZero lineSpace:0 interItemSpace:0];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithWidgetSize:(CGSize)size {
    self = [self initWithWidgetSize:size sectionInset:UIEdgeInsetsZero lineSpace:0 interItemSpace:0];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithWidgetSize:(CGSize)size sectionInset:(UIEdgeInsets)sectionInset lineSpace:(CGFloat)lineSpace interItemSpace:(CGFloat)interItemSpace
{
    self = [super init];
    if (self) {
        _widgetSize = size;
        _sectionInset = sectionInset;
        _minimumLineSpace = lineSpace;
        _minimumInteritemSpace = interItemSpace;
    }
    return self;
}

@end
