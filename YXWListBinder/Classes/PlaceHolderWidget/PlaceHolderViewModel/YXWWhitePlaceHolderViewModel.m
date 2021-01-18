#import "YXWWhitePlaceHolderViewModel.h"
#import "UIView+YXWBinder.h"
#import "YXWWhitePlaceHolderCell.h"

@implementation YXWWhitePlaceHolderViewModel

- (NSString *)identifier {
    return @"YXWWhitePlaceHolderCell";
}

- (CGFloat)widgetHeight {
    return 228;
}

- (YXWLineType)lineType {
    return LineRow;
}

- (id)showWidget {
    return [YXWWhitePlaceHolderCell nibFromYXWListBinder];
}

@end
