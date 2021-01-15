#import "YXWListBinder.h"

@interface YXWBaseHeaderModel : NSObject<YXWListBinderViewModelProtocol>

/** 存放接下来需要刷新的数据*/
@property (strong, nonatomic) NSMutableArray *subData;

/** 请求时中间层缓冲数据，已废弃*/
@property (strong, nonatomic) NSMutableArray *subDataCache;

@end
