//
//  YXWListBinderModelProtocol.h
//  YXWListBinder
//
//  Created by 原晓文 on 2018/2/22.
//  Copyright © 2018年 xiaowinner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 用于Header ViewModel 或 Model
 */

@protocol YXWListBinderViewModelProtocol <NSObject>

@required
- (NSString *)identifier;
- (CGFloat)widgetHeight;


@optional
- (NSInteger)gainSubDataCount:(NSInteger)section;
- (id <YXWListBinderViewModelProtocol>)gainSubData:(NSInteger)index;

@end

