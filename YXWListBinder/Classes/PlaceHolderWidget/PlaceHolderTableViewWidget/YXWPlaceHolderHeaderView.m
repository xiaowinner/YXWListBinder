#import "YXWPlaceHolderHeaderView.h"

@implementation YXWPlaceHolderHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
}

- (void)bindViewModel:(id<YXWListBinderViewModelProtocol>)viewModel atIndexPath:(NSIndexPath *)indexPath {
    
}


@end
