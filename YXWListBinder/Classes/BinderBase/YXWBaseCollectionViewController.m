#import "YXWBaseCollectionViewController.h"

@interface YXWBaseCollectionViewController ()

@end


@implementation YXWBaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initBase {
    NSLog(@"没有定义Base方法");
}

- (void)requestAndCombinedData {
    NSLog(@"没有定义网络请求方法");
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewLayout *layout = [[UICollectionViewLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
    }
    return _collectionView;
}

- (YXWListBinder *)listBinder {
    if (!_listBinder) {
        _listBinder = [[YXWListBinder alloc] init];
    }
    return _listBinder;
}

@end
