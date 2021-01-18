//
//  YXWClassTableViewCell.m
//  YXWListBinder_Example
//
//  Created by 原晓文 on 2019/6/17.
//  Copyright © 2019 原晓文. All rights reserved.
//

#import "YXWClassTableViewCell.h"

@interface YXWClassTableViewCell ()



@end

@implementation YXWClassTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.contentView setBackgroundColor:[UIColor blueColor]];
}

- (void)bindViewModel:(id<YXWListBinderViewModelProtocol>)viewModel sectionViewModel:(id<YXWListBinderViewModelProtocol>)sectionViewModel atIndexPath:(NSIndexPath *)indexPath first:(BOOL)first finally:(BOOL)finally extra:(NSDictionary *)extra {
    
}

- (void)didSelectedCell:(id<YXWListBinderViewModelProtocol>)viewModel
              tableView:(UITableView *)tableView
            atIndexPath:(NSIndexPath *)indexPath
                  first:(BOOL)first
                finally:(BOOL)finally
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TBPUSH" object:nil];
}
    
@end
