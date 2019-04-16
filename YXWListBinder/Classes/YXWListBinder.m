//
//  YXWListBinder.m
//  YXWListBinder
//
//  Created by 原晓文 on 2018/2/22.
//  Copyright © 2018年 xiaowinner. All rights reserved.
//

#import "YXWListBinder.h"
#import "NSError+YXWBinder.h"
#import "UIView+YXWBinder.h"
#import "YXWBaseHeaderModel.h"
#import "YXWBaseViewModel.h"

@interface YXWListBinder() <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) RACCommand *commend;
@property (nonatomic, assign) BOOL hasSection;

@end


@implementation YXWListBinder

#pragma mark InitCollectionViewBinder

- (instancetype)initBinder:(UICollectionView *)collectionView
                  nibsItem:(NSArray *)nibsItem
                nibHeaders:(NSArray *)nibHeaders
           itemIdentifiers:(NSArray *)itemIdentifiers
         headerIdentifiers:(NSArray *)headerIdentifiers
               dataCommand:(RACCommand *)dataCommand {
    
    self = [super init];
    if (self) {
        
        if (nibHeaders) {
            _hasSection = YES;
        }else {
            _hasSection = NO;
        }
        
        _collectionView = collectionView;
        _commend = dataCommand;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        @weakify(self);
        [nibHeaders enumerateObjectsUsingBlock:^(UINib *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            if (idx < headerIdentifiers.count) {
                [self.collectionView registerNib:obj forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifiers[idx]];
            }
        }];
        
        [nibsItem enumerateObjectsUsingBlock:^(UINib *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            if (idx < itemIdentifiers.count) {
                [self.collectionView registerNib:obj forCellWithReuseIdentifier:itemIdentifiers[idx]];
            }
        }];
    }
    return self;
    
}


- (instancetype)initBinder:(UICollectionView *)collectionView
            itemClassNames:(NSArray *)itemClassNames
          headerClassNames:(NSArray *)headerClassNames
               dataCommand:(RACCommand *)dataCommand {
    
    self = [super init];
    if (self) {
        
        if (headerClassNames) {
            _hasSection = YES;
        }else {
            _hasSection = NO;
        }
        
        _collectionView = collectionView;
        _commend = dataCommand;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        @weakify(self);
        [headerClassNames enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            Class headerClass = NSClassFromString(name);
            [self.collectionView registerClass:headerClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(headerClass)];
        }];
        
        [itemClassNames enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            Class itemClass = NSClassFromString(name);
            [self.collectionView registerClass:itemClass forCellWithReuseIdentifier:NSStringFromClass(itemClass)];
        }];
    }
    return self;
}


#pragma mark InitTableViewBinder

- (instancetype)initBinder:(UITableView *)tableView
                  nibsCell:(NSArray *)nibsCell
          nibHeaderFooters:(NSArray *)nibHeaderFooters
           cellIdentifiers:(NSArray *)cellIdentifiers
   headerFooterIdentifiers:(NSArray *)headerFooterIdentifiers
               dataCommand:(RACCommand *)dataCommand {
    
    self = [super init];
    if (self) {
        
        if (nibHeaderFooters) {
            _hasSection = YES;
        }else {
            _hasSection = NO;
        }
        
        _tableView = tableView;
        _commend = dataCommand;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            
        }
        
        @weakify(self);
        [nibHeaderFooters enumerateObjectsUsingBlock:^(UINib *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            if (idx < headerFooterIdentifiers.count) {
                [self.tableView registerNib:obj forHeaderFooterViewReuseIdentifier:headerFooterIdentifiers[idx]];
            }
        }];
        
        [nibsCell enumerateObjectsUsingBlock:^(UINib *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            if (idx < cellIdentifiers.count) {
                [self.tableView registerNib:obj
                     forCellReuseIdentifier:cellIdentifiers[idx]];
            }
        }];
    }
    return self;
}

- (instancetype)initBinder:(UITableView *)tableView
            cellClassNames:(NSArray *)cellClassNames
    headerFooterClassNames:(NSArray *)headerFooterClassNames
               dataCommand:(RACCommand *)dataCommand {

    self = [super init];
    if (self) {
        
        if (headerFooterClassNames) {
            _hasSection = YES;
        }else {
            _hasSection = NO;
        }
        
        _tableView = tableView;
        _commend = dataCommand;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        
        @weakify(self);
        [headerFooterClassNames enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            Class headerClass = NSClassFromString(name);
            [self.tableView registerClass:headerClass forHeaderFooterViewReuseIdentifier:NSStringFromClass(headerClass)];
        }];
        
        [cellClassNames enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            Class cellClass = NSClassFromString(name);
            [self.tableView registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
        }];
    }
    return self;
}


#pragma mark Util Method
- (void)addTableViewDatasSubscribe:(YXWListRefreshSuccessBlock)successBlock errorSubcribe:(YXWListRefreshErrorBlock)errorSubcribe {
    
    if (!self.commend) {
        return;
    }
    
    @weakify(self);
    [self.commend.executionSignals subscribeNext:^(RACSignal *execution) {
        [[[execution dematerialize] deliverOnMainThread]
         subscribeNext:^(NSArray *x) {
             @strongify(self);
             self.data = x;
             if (self.customRefreshBlock) {
                 self.customRefreshBlock();
             }else {
                 [self.tableView reloadData];
             }
             if (successBlock) {
                 successBlock();
             }
         } error:^(NSError *error) {
             if (errorSubcribe) {
                 errorSubcribe(error);
             }
         }];
    }];
    
}

- (void)addCollectionViewDatasSubscribe:(YXWListRefreshSuccessBlock)successBlock errorSubcribe:(YXWListRefreshErrorBlock)errorSubcribe {
    
    if (!self.commend) {
        return;
    }

    @weakify(self);
    [self.commend.executionSignals subscribeNext:^(RACSignal *execution) {
        [[[execution dematerialize] deliverOnMainThread]
         subscribeNext:^(NSArray *x) {
             @strongify(self);
             self.data = x;
             if (self.customRefreshBlock) {
                 self.customRefreshBlock();
             }else {
                 [self.collectionView reloadData];
             }
             if (successBlock) {
                 successBlock();
             }
         } error:^(NSError *error) {
             if (errorSubcribe) {
                 errorSubcribe(error);
             }
         }];
    }];
    
}


#pragma mark About UICollectionView && TableView Method

- (id<YXWListBinderViewModelProtocol>)gainCurrentViewModel:(NSIndexPath *)indexPath
                                                      type:(YXWLineType)type {
    switch (type) {
        case LineSection:
        {
            return self.data[indexPath.section];
            break;
        }
        case LineRow:
        {
            if (self.hasSection) {
                id <YXWListBinderViewModelProtocol> sectionViewModel = self.data[indexPath.section];
                return [sectionViewModel gainSubData:indexPath.row];
            }else {
                id <YXWListBinderViewModelProtocol> rowViewModel = self.data[indexPath.row];
                return rowViewModel;
            }
            break;
        }
    }
}

- (NSInteger)gainCurrentCount:(YXWLineType)type section:(NSInteger)section {
    if (!self.data) {
        return 0;
    }
    switch (type) {
        case LineSection:
            if (self.hasSection) {
                return self.data.count;
            }
            else {
                return 1;
            }
            break;
        case LineRow:
            if (self.hasSection) {
                id <YXWListBinderViewModelProtocol> sectionViewModel = self.data[section];
                return [sectionViewModel gainSubDataCount:section];
            }
            else {
                return [self.data count];
            }
            break;
    }
}


#pragma mark ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.offsetBlock) {
        self.offsetBlock(scrollView.contentOffset);
    }
}

#pragma mark UICollectionViewDelegate & DataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id <YXWListBinderViewModelProtocol> itemViewModel = [self gainCurrentViewModel:indexPath
                                                                              type:LineRow];
    id <YXWListBinderWidgetProtocol> item = [collectionView dequeueReusableCellWithReuseIdentifier:[itemViewModel identifier] forIndexPath:indexPath];
    [item bindViewModel:itemViewModel atIndexPath:indexPath];
    return (UICollectionViewCell *)item;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (self.hasSection) {
        id <YXWListBinderViewModelProtocol> headerViewModel = [self gainCurrentViewModel:[NSIndexPath indexPathForRow:0 inSection:indexPath.section] type:LineSection];
        id <YXWListBinderWidgetProtocol> header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[headerViewModel identifier] forIndexPath:indexPath];
        [header bindViewModel:headerViewModel atIndexPath:indexPath];
        return (UICollectionReusableView *)header;
    }else {
        return nil;
    }
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self gainCurrentCount:LineSection
                          section:0];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self gainCurrentCount:LineRow
                          section:section];
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.collectionViewDelegate) {
        id <YXWListBinderViewModelProtocol> itemViewModel = [self gainCurrentViewModel:indexPath
                                                                                  type:LineRow];
        [self.collectionViewDelegate YXWCollectionViewSelected:collectionView indexPath:indexPath model:itemViewModel];
    }
}

#pragma mark UITableViewDelegate & DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id <YXWListBinderViewModelProtocol> cellViewModel = [self gainCurrentViewModel:indexPath
                                                                              type:LineRow];
    id <YXWListBinderWidgetProtocol> cell =
    [tableView dequeueReusableCellWithIdentifier:[cellViewModel identifier]
                                    forIndexPath:indexPath];
    [cell bindViewModel:cellViewModel atIndexPath:indexPath];
    return (UITableViewCell *)cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.hasSection) {
        id <YXWListBinderViewModelProtocol> headerViewModel = [self gainCurrentViewModel:[NSIndexPath indexPathForRow:0 inSection:section] type:LineSection];
        
        id <YXWListBinderWidgetProtocol> header =
        [tableView dequeueReusableHeaderFooterViewWithIdentifier:[headerViewModel identifier]];
        
        [header bindViewModel:headerViewModel atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
        
        return (UITableViewHeaderFooterView *)header;
    }else {
        return nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self gainCurrentCount:LineSection
                          section:0];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self gainCurrentCount:LineRow
                          section:section];
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.hasSection) {
        id <YXWListBinderViewModelProtocol> headerViewModel = [self gainCurrentViewModel:[NSIndexPath indexPathForRow:0 inSection:section] type:LineSection];
        return headerViewModel.widgetHeight;
    }else {
        return 0.01;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id <YXWListBinderViewModelProtocol> viewModel = [self gainCurrentViewModel:indexPath type:LineRow];
    return viewModel.widgetHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (self.tableViewDelegate) {
        id <YXWListBinderViewModelProtocol> cellViewModel = [self gainCurrentViewModel:indexPath
                                                                                  type:LineRow];
        [self.tableViewDelegate YXWTableViewSelected:tableView indexPath:indexPath model:cellViewModel];
    }
}

#pragma mark Lazy init

- (NSArray *)data {
    if (!_data) {
        _data = [NSArray array];
    }
    return _data;
}

- (BOOL)needAnimation {
    if (!_needAnimation) {
        _needAnimation = NO;
    }
    return _needAnimation;
}

@end
