//
//  YXWCLClassModel.m
//  YXWListBinder_Example
//
//  Created by 原晓文 on 2021/1/18.
//  Copyright © 2021 原晓文. All rights reserved.
//

#import "YXWCLClassModel.h"

@implementation YXWCLClassModel

- (NSString *)identifier {
    return @"YXWCLClassCell";
}

- (YXWLineType)lineType {
    return LineRow;
}

- (id)showWidget {
    return @"YXWCLClassCell";
}

- (YXWListBinderCollectionWidgetConfig *)widgetConfig {
    YXWListBinderCollectionWidgetConfig *config = [[YXWListBinderCollectionWidgetConfig alloc] initWithWidgetSize:CGSizeMake(200, 200) sectionInset:UIEdgeInsetsZero lineSpace:10 interItemSpace:10];
    return config;
}

@end
