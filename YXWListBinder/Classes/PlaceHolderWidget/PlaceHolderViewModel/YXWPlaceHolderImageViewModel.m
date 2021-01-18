//
//  YXWPlaceHolderImageViewModel.m
//  AFNetworking
//
//  Created by 原晓文 on 2019/3/29.
//

#import "YXWPlaceHolderImageViewModel.h"
#import "UIView+YXWBinder.h"
#import "YXWPlaceHolderImageCell.h"

@implementation YXWPlaceHolderImageViewModel

- (NSString *)identifier {
    return @"YXWPlaceHolderImageCell";
}

- (CGFloat)widgetHeight {
    return 100.f;
}

- (YXWLineType)lineType {
    return LineRow;
}


- (id)showWidget {
    return [YXWPlaceHolderImageCell nibFromYXWListBinder];
}

@end
