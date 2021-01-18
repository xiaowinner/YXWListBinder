//
//  YXWCLModel.m
//  YXWListBinder_Example
//
//  Created by 原晓文 on 2021/1/18.
//  Copyright © 2021 原晓文. All rights reserved.
//

#import "YXWCLModel.h"

@implementation YXWCLModel

- (NSString *)identifier {
    return @"YXWCLCell";
}

- (YXWLineType)lineType {
    return LineRow;
}

- (id)showWidget {
    UINib *aNib = [UINib nibWithNibName:@"YXWCLCell" bundle:[NSBundle mainBundle]];
    return aNib;
}

- (YXWListBinderCollectionWidgetConfig *)widgetConfig {
    YXWListBinderCollectionWidgetConfig *config = [[YXWListBinderCollectionWidgetConfig alloc] initWithWidgetSize:CGSizeMake(200, 200) sectionInset:UIEdgeInsetsZero lineSpace:10 interItemSpace:10];
    return config;
}

@end
