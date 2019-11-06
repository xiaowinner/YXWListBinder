#import "YXWPlaceHolderHeaderView.h"
#import "YXWPlaceHolderHeaderViewModel.h"

@implementation YXWPlaceHolderHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
}

- (void)bindViewModel:(id<YXWListBinderViewModelProtocol>)viewModel atIndexPath:(NSIndexPath *)indexPath {
    if ([(NSObject *)viewModel isKindOfClass:[YXWPlaceHolderHeaderViewModel class]]) {
        self.backgroundColor = ((YXWPlaceHolderHeaderViewModel *)viewModel).bgColor;
    }
}

@end
