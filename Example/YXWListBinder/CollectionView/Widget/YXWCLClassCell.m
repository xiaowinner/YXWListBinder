//
//  YXWCLClassCell.m
//  YXWListBinder_Example
//
//  Created by 原晓文 on 2021/1/18.
//  Copyright © 2021 原晓文. All rights reserved.
//

#import "YXWCLClassCell.h"

@interface YXWCLClassCell ()



@end

@implementation YXWCLClassCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (void)bindViewModel:(id<YXWListBinderViewModelProtocol>)viewModel sectionViewModel:(id<YXWListBinderViewModelProtocol>)sectionViewModel atIndexPath:(NSIndexPath *)indexPath first:(BOOL)first finally:(BOOL)finally extra:(NSDictionary *)extra {
    
}

- (void)didSelectedCell:(id<YXWListBinderViewModelProtocol>)viewModel collectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath first:(BOOL)first finally:(BOOL)finally {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CLPUSH" object:nil];
}

@end
