#import "YXWListBinderViewModelProtocol.h"

@interface YXWTitlePlaceHolderViewModel : NSObject<YXWListBinderViewModelProtocol>

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSAttributedString *atrTitle;

@property (nonatomic, assign) CGFloat height;

@end
