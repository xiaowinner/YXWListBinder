#import "YXWTitleImagePlaceHolderCell.h"
#import "YXWTitleImagePlaceHolderViewModel.h"

@interface YXWTitleImagePlaceHolderCell ()

@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation YXWTitleImagePlaceHolderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)bindViewModel:(id<YXWListBinderViewModelProtocol>)viewModel atIndexPath:(NSIndexPath *)indexPath {
    
    YXWTitleImagePlaceHolderViewModel *model = (YXWTitleImagePlaceHolderViewModel *)viewModel;
    if (model) {
        if (model.title && ![model.title isEqualToString:@""]) {
            self.titleLabel.text = model.title;
        }
        
        if (model.imageName) {
            self.contentImageView.image = [UIImage imageNamed:model.imageName];
        }
        
        if (model.image) {
            self.contentImageView.image = model.image;
        }
    }
    
}


@end
