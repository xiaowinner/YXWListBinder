//
//  YXWClassTableViewCell.m
//  YXWListBinder_Example
//
//  Created by 原晓文 on 2019/6/17.
//  Copyright © 2019 原晓文. All rights reserved.
//

#import "YXWClassTableViewCell.h"

@implementation YXWClassTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.contentView setBackgroundColor:[UIColor blueColor]];
}

- (void)bindViewModel:(id<YXWListBinderViewModelProtocol>)viewModel atIndexPath:(NSIndexPath *)indexPath {
    
}
    
@end
