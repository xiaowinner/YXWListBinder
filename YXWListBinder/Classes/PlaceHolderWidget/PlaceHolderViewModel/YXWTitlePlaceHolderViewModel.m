#import "YXWTitlePlaceHolderViewModel.h"
#import "UIView+YXWBinder.h"
#import "YXWTitlePlaceHolderCell.h"

@implementation YXWTitlePlaceHolderViewModel

- (NSString *)identifier {
    return @"YXWTitlePlaceHolderCell";
}

- (CGFloat)widgetHeight {
    if (self.height) {
        return self.height;
    }else {
        return [UIScreen mainScreen].bounds.size.width * 0.2875;
    }
}

- (YXWLineType)lineType {
    return LineRow;
}

- (id)showWidget {
    return [YXWTitlePlaceHolderCell nibFromYXWListBinder];
}


@end
