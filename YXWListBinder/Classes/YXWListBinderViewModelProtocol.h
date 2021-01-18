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
- (NSString *)identifier;
- (CGFloat)widgetHeight;


@optional

- (YXWLineType)lineType;
- (NSInteger)gainSubDataCount:(NSInteger)section;
- (id <YXWListBinderViewModelProtocol>)gainSubData:(NSInteger)index;
/** 请求时中间层缓冲数据，已废弃*/
- (void)exchangeViewModelDatas;
/** 最终转换数据*/
- (void)exchangeViewModelRealDatas;

/** Collection的配置专用*/
- (YXWListBinderCollectionWidgetConfig *)widgetConfig;

@end

