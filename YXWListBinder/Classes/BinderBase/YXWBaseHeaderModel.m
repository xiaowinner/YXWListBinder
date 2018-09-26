#import "YXWBaseHeaderModel.h"

@implementation YXWBaseHeaderModel

- (NSString *)identifier {
    return @"Error:错误的identifier 没有实现子类identifier";
}

- (CGFloat)widgetHeight {
    return 0;
}


- (NSInteger)gainSubDataCount:(NSInteger)section {
    return self.subData.count;
}

- (id <YXWListBinderViewModelProtocol>)gainSubData:(NSInteger)index {
    if (index >= self.subData.count) {
        NSLog(@"Error:获取subData 越界");
    }
    return self.subData[index];
}


@end
