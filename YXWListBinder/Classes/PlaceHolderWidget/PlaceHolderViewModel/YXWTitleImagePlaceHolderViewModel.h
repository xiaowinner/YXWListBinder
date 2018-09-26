#import "YXWListBinderViewModelProtocol.h"
#import "YXWBaseViewModel.h"

@interface YXWTitleImagePlaceHolderViewModel : NSObject<YXWListBinderViewModelProtocol>

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) NSString *imageName;

@end
