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
    return CGFLOAT_MIN;
}

@end
