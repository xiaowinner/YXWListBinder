//
//  YXWListBinderModelProtocol.h
//  YXWListBinder
//
//  Created by 原晓文 on 2018/2/22.
//  Copyright © 2018年 xiaowinner. All rights reserved.
//

#import "YXWListBinderGeneralType.h"
#import "YXWListBinderCollectionWidgetConfig.h"

/**
 用于Header ViewModel 或 Model
 */
@protocol YXWListBinderViewModelProtocol

@required

/** 需要展示的cell，可以返回class名或者nib*/
- (id)showWidget;

/** 控件标识*/
- (NSString *)identifier;

/** 需要展示的cell高度*/
- (CGFloat)widgetHeight;

@optional

/** 展示类型*/
- (YXWLineType)lineType;

/** section专用，用于获取section子row的数量*/
- (NSInteger)gainSubDataCount:(NSInteger)section;

/** section专用，用于获取section子row的数据*/
- (id <YXWListBinderViewModelProtocol>)gainSubData:(NSInteger)index;

/** 即将刷新之前把section的子数据映射到真正使用的数组上，Binder内部已经调用，自定义SectionViewModel建议实现realSubDatas，防止崩溃*/
- (void)exchangeViewModelRealDatas;

/** Collection的配置专用*/
- (YXWListBinderCollectionWidgetConfig *)widgetConfig;

@end

