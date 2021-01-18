//
//  YXWListBinderCollectionWidgetConfig.h
//
//  Created by 原晓文 on 2020/6/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXWListBinderCollectionWidgetConfig : NSObject

/** 控件Size，可以是Header，Footer，Item*/
@property (nonatomic, assign) CGSize widgetSize;

/** Section 专用*/
/** Section Inset*/
@property (nonatomic, assign) UIEdgeInsets sectionInset;

/** Section 专用*/
/** Line Space*/
@property (nonatomic, assign) CGFloat minimumLineSpace;

/** Section 专用*/
/** Interitem Space*/
@property (nonatomic, assign) CGFloat minimumInteritemSpace;

/** Section 用*/
/** 控件配置初始化方法*/
- (instancetype)initWithWidgetSize:(CGSize)size sectionInset:(UIEdgeInsets)sectionInset lineSpace:(CGFloat)lineSpace interItemSpace:(CGFloat)interItemSpace;

/** Item 用*/
- (instancetype)initWithWidgetSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
