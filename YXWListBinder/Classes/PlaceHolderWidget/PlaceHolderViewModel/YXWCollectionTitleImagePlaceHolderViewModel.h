#import "YXWListBinderViewModelProtocol.h"

@interface YXWCollectionTitleImagePlaceHolderViewModel : NSObject<YXWListBinderViewModelProtocol>

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) NSString *imageName;

@property (nonatomic, strong) UIImage *image;

@end
