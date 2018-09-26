#import "YXWCollectionTitleImagePlaceHolderViewModel.h"

@implementation YXWCollectionTitleImagePlaceHolderViewModel

- (NSString *)identifier {
    return @"YXWCollectionTitleImagePlaceHolderCell";
}

- (CGFloat)widgetHeight {
    if (self.height) {
        return self.height;
    }else {
        return [UIScreen mainScreen].bounds.size.width * 0.5266;
    }
}

@end
