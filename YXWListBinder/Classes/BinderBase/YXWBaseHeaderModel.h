#import "YXWListBinder.h"

@interface YXWBaseHeaderModel : NSObject<YXWListBinderViewModelProtocol>

/** 存放真实使用的数据*/
@property (strong, nonatomic) NSMutableArray *subData;
/** 请求时中间层缓冲数据*/
@property (strong, nonatomic) NSMutableArray *subDataCache;

@end
