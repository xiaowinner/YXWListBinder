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

@interface YXWListBinder() <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) RACCommand *commend;
@property (nonatomic, assign) BOOL hasSection;

@property (nonatomic, copy) NSArray *tableViewPlaceHolderCells;
@property (nonatomic, copy) NSArray *tableViewPlaceHolderHeaders;

@property (nonatomic, copy) NSArray *tableViewPlaceHolderCellNames;
@property (nonatomic, copy) NSArray *tableViewPlaceHolderHeaderNames;

/**
 请求成功的 Block
 */
@property (nonatomic, copy) YXWListRefreshSuccessBlock _Nullable refreshSuccessBlock;

/**
 请求失败的 Block
 */
@property (nonatomic, copy) YXWListRefreshErrorBlock _Nullable refreshErrorBlock;

@end

@implementation YXWListBinder

#pragma mark InitCollectionViewBinder
- (instancetype)initBinder:(UICollectionView *)collectionView commend:(RACCommand *)commend {
    self = [super init];
    if (self) {
        _collectionView = collectionView;
        _commend = commend;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return self;
}



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
- (instancetype)initBinder:(UITableView *)tableView command:(RACCommand *)command {
    self = [super init];
    if (self) {
        _tableView = tableView;
        _commend = command;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;

        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {

        }
    }
    return self;
}


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


- (void)registerTableViewCellWithDatas:(NSArray *)datas {
    SEL lineSel = @selector(lineType);
    for (id <YXWListBinderViewModelProtocol> model in datas) {
        YXWLineType type = LineRow;
        if ([((NSObject *)model) respondsToSelector:lineSel]) {
            type = [model lineType];
        }
        
        if (type == LineRow) {
            
        }else if (type == LineSection) {
            
        }else {
            return;
        }
    }
}

- (void)registerCollectionViewCellWithDatas:(NSArray *)datas {
    
}

#pragma mark Util Method
- (void)addTableViewDatasSubscribe:(YXWListRefreshSuccessBlock)successBlock errorSubcribe:(YXWListRefreshErrorBlock)errorSubcribe {
    if (!self.commend) {
        return;
    }
    self.refreshSuccessBlock = successBlock;
    self.refreshErrorBlock = errorSubcribe;
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
             if (self.refreshSuccessBlock) {
                 self.refreshSuccessBlock();
             }
         } error:^(NSError *error) {
             @strongify(self);
             if (self.refreshErrorBlock) {
                 self.refreshErrorBlock(error);
             }
         }];
    }];
}

- (void)addCollectionViewDatasSubscribe:(YXWListRefreshSuccessBlock)successBlock errorSubcribe:(YXWListRefreshErrorBlock)errorSubcribe {
    if (!self.commend) {
        return;
    }
    self.refreshSuccessBlock = successBlock;
    self.refreshErrorBlock = errorSubcribe;
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
             if (self.refreshSuccessBlock) {
                 self.refreshSuccessBlock();
             }
         } error:^(NSError *error) {
             @strongify(self);
             if (self.refreshErrorBlock) {
                 self.refreshErrorBlock(error);
             }
         }];
    }];
}

- (BOOL)judgeSelector:(SEL)selector object:(NSObject *)object {
    if ([object respondsToSelector:selector]) {
        return YES;
    }else {
        return NO;
    }
}

#pragma mark About UICollectionView && TableView Method

- (BOOL)gainLastJudgeWithIndexPath:(NSIndexPath *)indexPath type:(YXWLineType)type {
    SEL headerCountSel = @selector(gainSubDataCount:);
    switch (type) {
        case LineSection:
        {
            if (indexPath.section == self.data.count - 1) {
                return YES;
            }
            break;
        }
        case LineRow:
        {
            if (self.hasSection) {
                id <YXWListBinderViewModelProtocol> sectionViewModel = self.data[indexPath.section];
                if ([(NSObject *)sectionViewModel respondsToSelector:headerCountSel]) {
                    NSInteger lastCount = [sectionViewModel gainSubDataCount:indexPath.section];
                    if (indexPath.row == lastCount - 1) {
                        return YES;
                    }
                }
            }else {
                if (indexPath.row == self.data.count - 1) {
                    return YES;
                }
            }
            break;
        }
    }
    return NO;
}

- (id<YXWListBinderViewModelProtocol>)gainCurrentViewModel:(NSIndexPath *)indexPath
                                                      type:(YXWLineType)type {
    SEL headerDataSel = @selector(gainSubData:);
    id <YXWListBinderViewModelProtocol> model = nil;
    switch (type) {
        case LineSection:
        {
            if (indexPath.section < self.data.count) {
                model = self.data[indexPath.section];
            }
            break;
        }
        case LineRow:
        {
            if (self.hasSection) {
                id <YXWListBinderViewModelProtocol> sectionViewModel = self.data[indexPath.section];
                if ([(NSObject *)sectionViewModel respondsToSelector:headerDataSel]) {
                    model = [sectionViewModel gainSubData:indexPath.row];
                }
            }else {
                model = self.data[indexPath.row];
            }
            break;
        }
    }
    return model;
}

- (id<YXWListBinderViewModelProtocol>)gainCurrentSectionViewModel:(NSIndexPath *)indexPath {
    id <YXWListBinderViewModelProtocol> model = nil;
    if (self.hasSection) {
        model = self.data[indexPath.section];
    }
    return model;
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
                return self.data.count;
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
    NSAssert([self judgeSelector:@selector(identifier) object:itemViewModel], @"model的identifier参数不正确,model:%@",itemViewModel);
    id <YXWListBinderWidgetProtocol> item = [collectionView dequeueReusableCellWithReuseIdentifier:[itemViewModel identifier] forIndexPath:indexPath];
    SEL bindSel = @selector(bindViewModel:atIndexPath:);
    SEL bindExtSel = @selector(bindViewModel:atIndexPath:first:finally:extra:);
    SEL bindExtSectionSel = @selector(bindViewModel:sectionViewModel:atIndexPath:first:finally:extra:);

    id <YXWListBinderViewModelProtocol> itemSectionViewModel = [self gainCurrentSectionViewModel:indexPath];
    
    BOOL first = indexPath.row == 0 ? : NO;
    BOOL last = [self gainLastJudgeWithIndexPath:indexPath type:LineRow];
    
    if ([(UICollectionView *)item respondsToSelector:bindExtSel]) {
        [item bindViewModel:itemViewModel atIndexPath:indexPath first:first finally:last extra:self.extra];
    }else if ([(UICollectionViewCell *)item respondsToSelector:bindSel]) {
        [item bindViewModel:itemViewModel atIndexPath:indexPath];
    }else if ([(UICollectionViewCell *)item respondsToSelector:bindExtSectionSel]) {
        [item bindViewModel:itemViewModel sectionViewModel:itemSectionViewModel atIndexPath:indexPath first:first finally:last extra:self.extra];
    }
    return (UICollectionViewCell *)item;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(willDisplayCollectionCell:viewModel:indexPath:)]) {
        id <YXWListBinderWidgetProtocol> listCell = cell;
        id <YXWListBinderViewModelProtocol> model = [self gainCurrentViewModel:indexPath type:LineRow];
        [listCell willDisplayCollectionCell:collectionView viewModel:model indexPath:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(didEndDisplayingCollectionCell:viewModel:indexPath:)]) {
        id <YXWListBinderWidgetProtocol> listCell = cell;
        [listCell didEndDisplayingCollectionCell:collectionView viewModel:nil indexPath:indexPath];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (self.hasSection && kind == UICollectionElementKindSectionHeader) {
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
    }else {
        id <YXWListBinderWidgetProtocol> cell = [collectionView cellForItemAtIndexPath:indexPath];
        if ([(NSObject *)cell respondsToSelector:@selector(didSelectedCell:collectionView:atIndexPath:first:finally:)]) {
            id <YXWListBinderViewModelProtocol> model = [self gainCurrentViewModel:indexPath type:LineRow];
            BOOL first = indexPath.row == 0 ? : NO;
            BOOL last = [self gainLastJudgeWithIndexPath:indexPath type:LineRow];
            [cell didSelectedCell:model collectionView:collectionView atIndexPath:indexPath first:first finally:last];
        }
    }
}

#pragma mark UICollectionView Layout Delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    id <YXWListBinderViewModelProtocol> itemViewModel = [self gainCurrentViewModel:indexPath
                                                                              type:LineRow];
    if ([(NSObject *)itemViewModel respondsToSelector:@selector(widgetConfig)]) {
        YXWListBinderCollectionWidgetConfig *config = [itemViewModel widgetConfig];
        return config.widgetSize;
    }else {
        if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
            CGSize itSize = ((UICollectionViewFlowLayout *)collectionViewLayout).itemSize;
            return itSize;
        }else {
            UICollectionViewLayoutAttributes *atr = [collectionViewLayout layoutAttributesForItemAtIndexPath:indexPath];
            return atr.size;
        }
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    if (self.hasSection) {
        id <YXWListBinderViewModelProtocol> itemViewModel = [self gainCurrentViewModel:[NSIndexPath indexPathForItem:0 inSection:section]
                                                                                  type:LineSection];
        if ([(NSObject *)itemViewModel respondsToSelector:@selector(widgetConfig)]) {
            YXWListBinderCollectionWidgetConfig *config = [itemViewModel widgetConfig];
            return config.sectionInset;
        }
    }else {
        if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
            UIEdgeInsets secInset = ((UICollectionViewFlowLayout *)collectionViewLayout).sectionInset;
            return secInset;
        }
    }
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.hasSection) {
        id <YXWListBinderViewModelProtocol> itemViewModel = [self gainCurrentViewModel:[NSIndexPath indexPathForItem:0 inSection:section]
                                                                                  type:LineSection];
        if ([(NSObject *)itemViewModel respondsToSelector:@selector(widgetConfig)]) {
            YXWListBinderCollectionWidgetConfig *config = [itemViewModel widgetConfig];
            return config.minimumLineSpace;
        }
    }else {
        if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
            CGFloat minimumLineSpacing = ((UICollectionViewFlowLayout *)collectionViewLayout).minimumLineSpacing;
            return minimumLineSpacing;
        }
    }
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.hasSection) {
        id <YXWListBinderViewModelProtocol> itemViewModel = [self gainCurrentViewModel:[NSIndexPath indexPathForItem:0 inSection:section]
                                                                                  type:LineSection];
        if ([(NSObject *)itemViewModel respondsToSelector:@selector(widgetConfig)]) {
            YXWListBinderCollectionWidgetConfig *config = [itemViewModel widgetConfig];
            return config.minimumInteritemSpace;
        }
    }else {
        if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
            CGFloat minimumInteritemSpace = ((UICollectionViewFlowLayout *)collectionViewLayout).minimumInteritemSpacing;
            return minimumInteritemSpace;
        }
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (self.hasSection) {
        id <YXWListBinderViewModelProtocol> itemViewModel = [self gainCurrentViewModel:[NSIndexPath indexPathForItem:0 inSection:section]
                                                                                  type:LineSection];
        if ([(NSObject *)itemViewModel respondsToSelector:@selector(widgetConfig)]) {
            YXWListBinderCollectionWidgetConfig *config = [itemViewModel widgetConfig];
            return config.widgetSize;
        }
    }else {
        if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
            CGSize headerSize = ((UICollectionViewFlowLayout *)collectionViewLayout).headerReferenceSize;
            return headerSize;
        }
    }
    return CGSizeZero;
}

#pragma mark UITableViewDelegate & DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SEL bindSel = @selector(bindViewModel:atIndexPath:);
    SEL bindExtSel = @selector(bindViewModel:atIndexPath:first:finally:extra:);
    SEL bindExtSectionSel = @selector(bindViewModel:sectionViewModel:atIndexPath:first:finally:extra:);

    id <YXWListBinderViewModelProtocol> cellViewModel = [self gainCurrentViewModel:indexPath
                                                                              type:LineRow];
    
    id <YXWListBinderViewModelProtocol> cellSectionViewModel = [self gainCurrentSectionViewModel:indexPath];
    
    NSAssert([self judgeSelector:@selector(identifier) object:cellViewModel], @"model的identifier参数不正确,model:%@",cellViewModel);
    id <YXWListBinderWidgetProtocol> cell =
    [tableView dequeueReusableCellWithIdentifier:[cellViewModel identifier]
                                    forIndexPath:indexPath];
    
    BOOL last = [self gainLastJudgeWithIndexPath:indexPath type:LineRow];
    BOOL first = indexPath.row == 0 ? : NO;
    if ([(UITableViewCell *)cell respondsToSelector:bindExtSectionSel]) {
        [cell bindViewModel:cellViewModel sectionViewModel:cellSectionViewModel atIndexPath:indexPath first:first finally:last extra:self.extra];
    }else if ([(UITableViewCell *)cell respondsToSelector:bindExtSel]) {
        [cell bindViewModel:cellViewModel atIndexPath:indexPath first:first finally:last extra:self.extra];
    }else if ([(UITableViewCell *)cell respondsToSelector:bindSel]) {
        [cell bindViewModel:cellViewModel atIndexPath:indexPath];
    }
    return (UITableViewCell *)cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.hasSection) {
        id <YXWListBinderViewModelProtocol> headerViewModel = [self gainCurrentViewModel:[NSIndexPath indexPathForRow:0 inSection:section] type:LineSection];
        NSAssert([self judgeSelector:@selector(identifier) object:headerViewModel], @"model的identifier参数不正确,model:%@",headerViewModel);
        id <YXWListBinderWidgetProtocol> header =
        [tableView dequeueReusableHeaderFooterViewWithIdentifier:[headerViewModel identifier]];
        SEL bindSel = @selector(bindViewModel:atIndexPath:);
        SEL bindExtSel = @selector(bindViewModel:atIndexPath:first:finally:extra:);
        SEL bindExtSectionSel = @selector(bindViewModel:sectionViewModel:atIndexPath:first:finally:extra:);
        BOOL last = [self gainLastJudgeWithIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] type:LineSection];
        BOOL first = section == 0 ? : NO;
        if ([(UITableViewHeaderFooterView *)header respondsToSelector:bindExtSectionSel]) {
            [header bindViewModel:headerViewModel sectionViewModel:headerViewModel atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] first:first finally:last extra:self.extra];
        }else if ([(UITableViewHeaderFooterView *)header respondsToSelector:bindExtSel]) {
            [header bindViewModel:headerViewModel atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] first:first finally:last extra:self.extra];
        }else if ([(UITableViewHeaderFooterView *)header respondsToSelector:bindSel]) {
            [header bindViewModel:headerViewModel atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
        }
        return (UITableViewHeaderFooterView *)header;
    }else {
        return nil;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    SEL editSel = @selector(YXWTableView:canEditRowAtIndexPath:);
    if (self.tableViewDelegate && [self.tableViewDelegate respondsToSelector:editSel]) {
        return [self.tableViewDelegate YXWTableView:tableView canEditRowAtIndexPath:indexPath];
    }else {
        return NO;
    }
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    SEL editActionSel = @selector(YXWTableView:editActionsForRowAtIndexPath:);
    if (self.tableViewDelegate && [self.tableViewDelegate respondsToSelector:editActionSel]) {
        return [self.tableViewDelegate YXWTableView:tableView editActionsForRowAtIndexPath:indexPath];
    }else {
        return [NSArray array];
    }
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    SEL willBeginEditing = @selector(YXWTableView:willBeginEditingRowAtIndexPath:);
    if (self.tableViewDelegate && [self.tableViewDelegate respondsToSelector:willBeginEditing]) {
        [self.tableViewDelegate YXWTableView:tableView willBeginEditingRowAtIndexPath:indexPath];
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
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.hasSection) {
        id <YXWListBinderViewModelProtocol> headerViewModel = [self gainCurrentViewModel:[NSIndexPath indexPathForRow:0 inSection:section] type:LineSection];
        return headerViewModel.widgetHeight;
    }else {
        return CGFLOAT_MIN;
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
    }else {
        id <YXWListBinderWidgetProtocol> cell = [tableView cellForRowAtIndexPath:indexPath];
        if ([(NSObject *)cell respondsToSelector:@selector(didSelectedCell:tableView:atIndexPath:first:finally:)]) {
            BOOL last = [self gainLastJudgeWithIndexPath:indexPath type:LineRow];
            id <YXWListBinderViewModelProtocol> model = [self gainCurrentViewModel:indexPath type:LineRow];
            BOOL first = indexPath.row == 0 ? : NO;
            [cell didSelectedCell:model tableView:tableView atIndexPath:indexPath first:first finally:last];
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(willDisplayCell:viewModel:indexPath:)]) {
        id <YXWListBinderWidgetProtocol> listCell = cell;
        id <YXWListBinderViewModelProtocol> model = [self gainCurrentViewModel:indexPath type:LineRow];
        [listCell willDisplayCell:tableView viewModel:model indexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(didEndDisplayingCell:viewModel:indexPath:)]) {
        id <YXWListBinderWidgetProtocol> listCell = cell;
        [listCell didEndDisplayingCell:tableView viewModel:nil indexPath:indexPath];
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

- (NSDictionary *)extra {
    if (!_extra) {
        _extra = [NSDictionary dictionary];
    }
    return _extra;
}

@end
