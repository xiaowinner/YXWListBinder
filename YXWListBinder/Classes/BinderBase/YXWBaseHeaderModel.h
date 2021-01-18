#import "YXWListBinder.h"

@interface YXWBaseHeaderModel : NSObject<YXWListBinderViewModelProtocol>

/** 存放接下来需要刷新的数据*/
@property (strong, nonatomic) NSMutableArray *subData;

/** 子类需要重写*/
- (NSString *)identifier;

/** 子类需要重写*/
- (CGFloat)widgetHeight;

/** 子类需要重写*/
- (id)showWidget;

@end
