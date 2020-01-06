#import "YXWPlaceHolderHeaderViewModel.h"

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

- (CGFloat)widgetHeight {
    if (self.headerHeight) {
        return self.headerHeight.floatValue;
    }
    return 0.01;
}

@end
