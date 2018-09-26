#import "YXWCollectionTitleImagePlaceHolderCell.h"
#import "YXWCollectionTitleImagePlaceHolderViewModel.h"


@interface YXWCollectionTitleImagePlaceHolderCell ()

@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end



@implementation YXWCollectionTitleImagePlaceHolderCell

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)bindViewModel:(id<YXWListBinderViewModelProtocol>)viewModel atIndexPath:(NSIndexPath *)indexPath {
    YXWCollectionTitleImagePlaceHolderViewModel *model = viewModel;
    if (model) {
        if (model.title && ![model.title isEqualToString:@""]) {
            self.titleLabel.text = model.title;
        }
        if (model.imageName) {
            self.contentImageView.image = [UIImage imageNamed:model.imageName];
        }
    }
}

@end
