#import "YXWTitlePlaceHolderCell.h"
#import "YXWTitlePlaceHolderViewModel.h"

@interface YXWTitlePlaceHolderCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end


@implementation YXWTitlePlaceHolderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)bindViewModel:(id<YXWListBinderViewModelProtocol>)viewModel atIndexPath:(NSIndexPath *)indexPath {
    YXWTitlePlaceHolderViewModel *vm = (YXWTitlePlaceHolderViewModel *)viewModel;
    if (vm.atrTitle) {
        self.titleLabel.attributedText = vm.atrTitle;
    }else {
        self.titleLabel.text = vm.title;
    }
}

@end
