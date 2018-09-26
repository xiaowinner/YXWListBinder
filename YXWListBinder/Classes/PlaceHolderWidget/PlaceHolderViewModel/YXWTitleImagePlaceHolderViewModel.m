#import "YXWTitleImagePlaceHolderViewModel.h"


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

@end
