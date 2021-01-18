//
//  YXWNibTableViewHeaderView.m
//  YXWListBinder_Example
//
//  Created by 原晓文 on 2021/1/15.
//  Copyright © 2021 原晓文. All rights reserved.
//

#import "YXWNibTableViewHeaderView.h"

@interface YXWNibTableViewHeaderView ()

@property (nonatomic, strong) UILabel *showLabel;

@end


@implementation YXWNibTableViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _showLabel.text = @"我是Header";
        [self.contentView addSubview:_showLabel];
    }
    return self;
}

- (void)bindViewModel:(id<YXWListBinderViewModelProtocol>)viewModel atIndexPath:(NSIndexPath *)indexPath {
    
}

@end
