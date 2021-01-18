#import "YXWTitleImagePlaceHolderViewModel.h"
#import "UIView+YXWBinder.h"
#import "YXWTitleImagePlaceHolderCell.h"

@implementation YXWTitleImagePlaceHolderViewModel

- (NSString *)identifier {
    return @"YXWTitleImagePlaceHolderCell";
}

- (CGFloat)widgetHeight {
    if (self.height) {
        return self.height;
    }else {
        return [UIScreen mainScreen].bounds.size.width * 0.5266;
    }
}

- (YXWLineType)lineType {
    return LineRow;
}


- (id)showWidget {
    return [YXWTitleImagePlaceHolderCell nibFromYXWListBinder];
}


@end
