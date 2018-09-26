#import "YXWListBinder.h"

@interface YXWNormalBaseTabbleViewController : UIViewController

@property (strong, nonatomic) YXWListBinder *tableViewBinder;
@property (strong, nonatomic) UITableView *tableView;
@property (copy, nonatomic) NSString *IDNumber;

- (instancetype)initWithIDNumber:(NSString *)IDNumber;

- (void)requestAndCombinedData;

- (void)initBase;

- (void)initBinderAndRegisterNibs;

@end
