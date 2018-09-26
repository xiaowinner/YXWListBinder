@interface YXWBaseCollectionViewController : UIViewController

@property (strong, nonatomic) YXWListBinder *listBinder;
@property (strong, nonatomic) UICollectionView *collectionView;

- (void)requestAndCombinedData;

- (void)initBase;

@end
