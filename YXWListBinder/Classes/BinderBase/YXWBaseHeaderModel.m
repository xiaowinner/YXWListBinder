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
    NSAssert(index < self.subData.count, @"Error: Header获取subData 越界, index:%ld",index);
    return self.subData[index];
}

- (void)exchangeViewModelDatas {
    self.subData = self.subDataCache;
}

@end
