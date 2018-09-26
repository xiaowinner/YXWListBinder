#import "YXWNormalBaseTabbleViewController.h"

@implementation YXWNormalBaseTabbleViewController


- (instancetype)init {
    self = [super init];
    if (self) {
        _IDNumber = @"";
    }
    return self;
}

- (instancetype)initWithIDNumber:(NSString *)IDNumber {
    self = [super init];
    if (self) {
        _IDNumber = IDNumber;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBase];
    [self requestAndCombinedData];
}

- (void)initBase {
    
}

// 重写父类请求方法
- (void)paginationBeginLoad {
    [self requestAndCombinedData];
}


- (void)paginationBeginLoadMore {
    [self requestAndCombinedData];
}

- (void)requestAndCombinedData {
    
}

- (void)initBinderAndRegisterNibs {
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
