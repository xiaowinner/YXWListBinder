#import "YXWPlaceHolderHeaderViewModel.h"
#import "YXWPlaceHolderHeaderView.h"
#import "UIView+YXWBinder.h"

@implementation YXWPlaceHolderHeaderViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _bgColor = [UIColor whiteColor];
    }
    return self;
}

- (instancetype)initWithColor:(UIColor *)color
{
    self = [super init];
    if (self) {
        _bgColor = color;
    }
    return self;
}

- (NSString *)identifier {
    return @"YXWPlaceHolderHeaderView";
}

- (id)showWidget {
    return [YXWPlaceHolderHeaderView nibFromYXWListBinder];
}

- (CGFloat)widgetHeight {
    if (self.headerHeight) {
        return self.headerHeight.floatValue;
    }
    return CGFLOAT_MIN;
}

@end
