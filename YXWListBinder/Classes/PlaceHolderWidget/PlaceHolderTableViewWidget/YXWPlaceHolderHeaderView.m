#import "YXWPlaceHolderHeaderView.h"
#import "YXWPlaceHolderHeaderViewModel.h"

@implementation YXWPlaceHolderHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)bindViewModel:(id<YXWListBinderViewModelProtocol>)viewModel atIndexPath:(NSIndexPath *)indexPath {
    if ([(NSObject *)viewModel isKindOfClass:[YXWPlaceHolderHeaderViewModel class]]) {
        self.contentView.backgroundColor = ((YXWPlaceHolderHeaderViewModel *)viewModel).bgColor;
    }
}

@end
