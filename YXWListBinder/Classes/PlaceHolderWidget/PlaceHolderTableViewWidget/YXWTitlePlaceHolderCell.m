#import "YXWTitlePlaceHolderCell.h"

@interface YXWTitlePlaceHolderCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation YXWTitlePlaceHolderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)bindViewModel:(id<YXWListBinderViewModelProtocol>)viewModel atIndexPath:(NSIndexPath *)indexPath {
    
}

@end
