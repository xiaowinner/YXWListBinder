#import "YXWBaseHeaderModel.h"

@interface YXWBaseHeaderModel ()

/** 真正使用的数据源*/
@property (strong, nonatomic) NSMutableArray *realSubDatas;

@end

@implementation YXWBaseHeaderModel

- (NSString *)identifier {
    return @"Error:错误的identifier 没有实现子类identifier";
}

- (CGFloat)widgetHeight {
    return 0;
}

- (YXWLineType)lineType {
    return LineSection;
}

- (NSInteger)gainSubDataCount:(NSInteger)section {
    return self.realSubDatas.count;
}

- (id <YXWListBinderViewModelProtocol>)gainSubData:(NSInteger)index {
    NSAssert(index < self.realSubDatas.count, @"Error: Header获取subData 越界, index:%ld",index);
    return self.realSubDatas[index];
}

- (void)exchangeViewModelRealDatas {
    self.realSubDatas = [self.subData mutableCopy];
}

- (id)showWidget {
    return nil;
}


@end
