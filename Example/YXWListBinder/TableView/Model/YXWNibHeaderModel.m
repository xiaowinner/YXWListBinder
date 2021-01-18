//
//  YXWNibHeaderModel.m
//  YXWListBinder_Example
//
//  Created by 原晓文 on 2021/1/15.
//  Copyright © 2021 原晓文. All rights reserved.
//

#import "YXWNibHeaderModel.h"

@implementation YXWNibHeaderModel

- (CGFloat)widgetHeight {
    return 100;
}
    
- (NSString *)identifier {
    return @"YXWNibTableViewHeaderView";
}

- (id)showWidget {
    return @"YXWNibTableViewHeaderView";
}

@end
