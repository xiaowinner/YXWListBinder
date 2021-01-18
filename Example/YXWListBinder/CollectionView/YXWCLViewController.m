//
//  YXWCLViewController.m
//  YXWListBinder_Example
//
//  Created by 原晓文 on 2021/1/18.
//  Copyright © 2021 原晓文. All rights reserved.
//

#import "YXWCLViewController.h"
#import "YXWCLViewModel.h"

@interface YXWCLViewController ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) YXWCLViewModel *viewModel;
@property (nonatomic, strong) YXWListBinder *collectionBinder;

@end

@implementation YXWCLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [[YXWCLViewModel alloc] init];
    
    CGFloat useWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat useHeight = [UIScreen mainScreen].bounds.size.height;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, useWidth, useHeight) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.collectionView];
    
    self.collectionBinder = [[YXWListBinder alloc] initBinderWithCollectionView:self.collectionView hasSection:YES command:self.viewModel.dataCommand];
    
    [self.collectionBinder addCollectionViewDatasSubscribe:^{
        
    } errorSubcribe:^(NSError * _Nonnull error) {
        
    }];

    [self.viewModel.dataCommand execute:@(1)];
}

@end
