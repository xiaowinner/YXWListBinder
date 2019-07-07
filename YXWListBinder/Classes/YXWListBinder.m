//
//  YXWListBinder.m
//  YXWListBinder
//
//  Created by 原晓文 on 2018/2/22.
//  Copyright © 2018年 xiaowinner. All rights reserved.
//

#import "YXWListBinder.h"
#import "YXWListBinderKit.h"

#import "NSError+YXWBinder.h"
#import "UIView+YXWBinder.h"

@interface YXWListBinder() <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) RACCommand *commend;
@property (nonatomic, assign) BOOL hasSection;

@property (nonatomic, copy) NSArray *tableViewPlaceHolderCells;
@property (nonatomic, copy) NSArray *tableViewPlaceHolderHeaders;

@property (nonatomic, copy) NSArray *tableViewPlaceHolderCellNames;
@property (nonatomic, copy) NSArray *tableViewPlaceHolderHeaderNames;

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
        
        //外部控件注册
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
        
        //内部控件注册
        [self.tableViewPlaceHolderHeaders enumerateObjectsUsingBlock:^(UINib *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            if (idx < self.tableViewPlaceHolderHeaderNames.count) {
                [self.tableView registerNib:obj forHeaderFooterViewReuseIdentifier:self.tableViewPlaceHolderHeaderNames[idx]];
            }
        }];
        
        [self.tableViewPlaceHolderCells enumerateObjectsUsingBlock:^(UINib *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            if (idx < self.tableViewPlaceHolderCellNames.count) {
                [self.tableView registerNib:obj forCellReuseIdentifier:self.tableViewPlaceHolderCellNames[idx]];
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
        
        //外部
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
        
        //内部
        [self.tableViewPlaceHolderHeaderNames enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            Class headerClass = NSClassFromString(name);
            [self.tableView registerClass:headerClass forHeaderFooterViewReuseIdentifier:NSStringFromClass(headerClass)];
        }];
        
        [self.tableViewPlaceHolderCellNames enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            Class cellClass = NSClassFromString(name);
            [self.tableView registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
        }];
    }
    return self;
}
    
    
- (instancetype)initBinder:(UITableView *)tableView
                     cells:(NSArray *)cells
             headerFooters:(NSArray *)headerFooters
           cellIdentifiers:(NSArray *)cellIdentifiers
   headerFooterIdentifiers:(NSArray *)headerFooterIdentifiers
               dataCommand:(RACCommand *)dataCommand {
    self = [super init];
    if (self) {
        if (headerFooters) {
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
        
        //外部
        @weakify(self);
        [headerFooters enumerateObjectsUsingBlock:^(id headerFooter, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            if ([headerFooter isKindOfClass:[NSString class]]) {
                Class headerClass = NSClassFromString(headerFooter);
                [self.tableView registerClass:headerClass forHeaderFooterViewReuseIdentifier:NSStringFromClass(headerClass)];
            }else if ([headerFooter isKindOfClass:[UINib class]]) {
                if (idx < headerFooterIdentifiers.count) {
                    [self.tableView registerNib:(UINib *)headerFooter forHeaderFooterViewReuseIdentifier:headerFooterIdentifiers[idx]];
                }
            }
        }];
        
        [cells enumerateObjectsUsingBlock:^(id cell, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            if ([cell isKindOfClass:[NSString class]]) {
                Class cellClass = NSClassFromString(cell);
                [self.tableView registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
            }else if ([cell isKindOfClass:[UINib class]]) {
                if (idx < cellIdentifiers.count) {
                    [self.tableView registerNib:cell
                         forCellReuseIdentifier:cellIdentifiers[idx]];
                }
            }
        }];
        
        //内部控件注册
        [self.tableViewPlaceHolderHeaders enumerateObjectsUsingBlock:^(UINib *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            if (idx < self.tableViewPlaceHolderHeaderNames.count) {
                [self.tableView registerNib:obj forHeaderFooterViewReuseIdentifier:self.tableViewPlaceHolderHeaderNames[idx]];
            }
        }];
        
        [self.tableViewPlaceHolderCells enumerateObjectsUsingBlock:^(UINib *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            if (idx < self.tableViewPlaceHolderCellNames.count) {
                [self.tableView registerNib:obj forCellReuseIdentifier:self.tableViewPlaceHolderCellNames[idx]];
            }
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
    }else if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(YXWScrollViewDidScroll:)]) {
        [self.scrollViewDelegate YXWScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(YXWScrollViewDidZoom:)]) {
        [self.scrollViewDelegate YXWScrollViewDidZoom:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(YXWScrollViewWillBeginDragging:)]) {
        [self.scrollViewDelegate YXWScrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(YXWScrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.scrollViewDelegate YXWScrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(YXWScrollViewDidEndDragging:willDecelerate:)]) {
        [self.scrollViewDelegate YXWScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(YXWScrollViewWillBeginDecelerating:)]) {
        [self.scrollViewDelegate YXWScrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(YXWScrollViewDidEndDecelerating:)]) {
        [self.scrollViewDelegate YXWScrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(YXWScrollViewDidEndScrollingAnimation:)]) {
        [self.scrollViewDelegate YXWScrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(YXWViewForZoomingInScrollView:)]) {
        return [self.scrollViewDelegate YXWViewForZoomingInScrollView:scrollView];
    }else {
        return nil;
    }
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view {
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(YXWScrollViewWillBeginZooming:withView:)]) {
        [self.scrollViewDelegate YXWScrollViewWillBeginZooming:scrollView withView:view];
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(YXWScrollViewDidEndZooming:withView:atScale:)]) {
        [self.scrollViewDelegate YXWScrollViewDidEndZooming:scrollView withView:view atScale:scale];
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(YXWScrollViewShouldScrollToTop:)]) {
        return [self.scrollViewDelegate YXWScrollViewShouldScrollToTop:scrollView];
    }else {
        return YES;
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(YXWScrollViewDidScrollToTop:)]) {
        [self.scrollViewDelegate YXWScrollViewDidScrollToTop:scrollView];
    }
}

#pragma mark UICollectionViewDelegate & DataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id <YXWListBinderViewModelProtocol> itemViewModel = [self gainCurrentViewModel:indexPath
                                                                              type:LineRow];
    id <YXWListBinderWidgetProtocol> item = [collectionView dequeueReusableCellWithReuseIdentifier:[itemViewModel identifier] forIndexPath:indexPath];
    SEL bindSel = @selector(bindViewModel:atIndexPath:);
    if ([(UICollectionViewCell *)item respondsToSelector:bindSel]) {
        [item bindViewModel:itemViewModel atIndexPath:indexPath];
    }
    return (UICollectionViewCell *)item;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (self.hasSection) {
        id <YXWListBinderViewModelProtocol> headerViewModel = [self gainCurrentViewModel:[NSIndexPath indexPathForRow:0 inSection:indexPath.section] type:LineSection];
        id <YXWListBinderWidgetProtocol> header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[headerViewModel identifier] forIndexPath:indexPath];
        SEL bindSel = @selector(bindViewModel:atIndexPath:);
        if ([(UICollectionReusableView *)header respondsToSelector:bindSel]) {
            [header bindViewModel:headerViewModel atIndexPath:indexPath];
        }
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
    if (self.collectionViewDelegate && [self.collectionViewDelegate respondsToSelector:@selector(YXWCollectionViewSelected:indexPath:model:)]) {
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
    SEL bindSel = @selector(bindViewModel:atIndexPath:);
    if ([(UITableViewCell *)cell respondsToSelector:bindSel]) {
        [cell bindViewModel:cellViewModel atIndexPath:indexPath];
    }
    return (UITableViewCell *)cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.hasSection) {
        id <YXWListBinderViewModelProtocol> headerViewModel = [self gainCurrentViewModel:[NSIndexPath indexPathForRow:0 inSection:section] type:LineSection];
        id <YXWListBinderWidgetProtocol> header =
        [tableView dequeueReusableHeaderFooterViewWithIdentifier:[headerViewModel identifier]];
        SEL bindSel = @selector(bindViewModel:atIndexPath:);
        if ([(UITableViewHeaderFooterView *)header respondsToSelector:bindSel]) {
            [header bindViewModel:headerViewModel atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
        }
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
    if (self.tableViewDelegate && [self.tableViewDelegate respondsToSelector:@selector(YXWTableViewSelected:indexPath:model:)]) {
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

- (NSArray *)tableViewPlaceHolderCells {
    if (!_tableViewPlaceHolderCells) {
        _tableViewPlaceHolderCells = @[
                                       [YXWTitleImagePlaceHolderCell nibFromYXWListBinder],
                                       [YXWPlaceHolderImageCell nibFromYXWListBinder],
                                       [YXWTitlePlaceHolderCell nibFromYXWListBinder],
                                       [YXWWhitePlaceHolderCell nibFromYXWListBinder],
                                       ];
    }
    return _tableViewPlaceHolderCells;
}

- (NSArray *)tableViewPlaceHolderHeaders {
    if (!_tableViewPlaceHolderHeaders) {
        _tableViewPlaceHolderHeaders = @[
                                         [YXWPlaceHolderHeaderView nibFromYXWListBinder],
                                         ];
    }
    return _tableViewPlaceHolderHeaders;
}

- (NSArray *)tableViewPlaceHolderCellNames {
    if (!_tableViewPlaceHolderCellNames) {
        _tableViewPlaceHolderCellNames = @[
                                           @"YXWTitleImagePlaceHolderCell",
                                           @"YXWPlaceHolderImageCell",
                                           @"YXWTitlePlaceHolderCell",
                                           @"YXWWhitePlaceHolderCell",
                                           ];
    }
    return _tableViewPlaceHolderCellNames;
}

- (NSArray *)tableViewPlaceHolderHeaderNames {
    if (!_tableViewPlaceHolderHeaderNames) {
        _tableViewPlaceHolderHeaderNames = @[
                                           @"YXWPlaceHolderHeaderView",
                                           ];
    }
    return _tableViewPlaceHolderHeaderNames;
}

@end
