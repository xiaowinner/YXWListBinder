//
//  YXWListBinder.h
//  YXWListBinder
//
//  Created by 原晓文 on 2018/2/22.
//  Copyright © 2018年 xiaowinner. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "YXWListBinderViewModelProtocol.h"
#import "YXWListBinderWidgetProtocol.h"
#import "YXWListBinderGeneralType.h"

NS_ASSUME_NONNULL_BEGIN


/*
 Delegate
 */
@protocol YXWListBinderTableViewDelegate <NSObject>

@optional

- (void)YXWTableViewSelected:(UITableView *)tableView
                   indexPath:(NSIndexPath *)indexPath
                       model:(id<YXWListBinderViewModelProtocol>)model;

- (NSArray<UITableViewRowAction *> *)YXWTableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)YXWTableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath;

- (BOOL)YXWTableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol YXWListBinderCollectionViewDelegate <NSObject>

- (void)YXWCollectionViewSelected:(UICollectionView *)collectionView
                        indexPath:(NSIndexPath *)indexPath
                            model:(id<YXWListBinderViewModelProtocol>)model;

@end


/*
 ScrollView Delegate
 */
@protocol YXWListBinderScrollViewDelegate <NSObject>

@optional

- (void)YXWScrollViewDidScroll:(UIScrollView *)scrollView;

- (void)YXWScrollViewDidZoom:(UIScrollView *)scrollView;

- (void)YXWScrollViewWillBeginDragging:(UIScrollView *)scrollView;

- (void)YXWScrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;

- (void)YXWScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

- (void)YXWScrollViewWillBeginDecelerating:(UIScrollView *)scrollView;

- (void)YXWScrollViewDidEndDecelerating:(UIScrollView *)scrollView;

- (void)YXWScrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;

- (UIView *)YXWViewForZoomingInScrollView:(UIScrollView *)scrollView;

- (void)YXWScrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view;

- (void)YXWScrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale;

- (BOOL)YXWScrollViewShouldScrollToTop:(UIScrollView *)scrollView;

- (void)YXWScrollViewDidScrollToTop:(UIScrollView *)scrollView;

@end


@interface YXWListBinder : NSObject

/**
 获取滑动的偏移量
 */
typedef void(^YXWListViewScrollOffsetBlock)(CGPoint offset);

/**
 每次请求获得的models，用于外部控制显示细节
 */
typedef void(^YXWListRefreshSuccessBlock)(void);

/**
 每次请求失败的Blcok
 */
typedef void(^YXWListRefreshErrorBlock)(NSError *error);

/**
 不使用默认刷新，自定义刷新机制
 */
typedef void(^YXWListRefreshCustomBlock)(void);

#pragma mark UITableView

/**
 初始化binder，但不预注册cell
 */
- (instancetype)initBinderWithTableView:(UITableView *)tableView hasSection:(BOOL)hasSection command:(RACCommand *)command;


#pragma mark UICollectionView
/**
 初始化binder，但不预注册cell
 */
- (instancetype)initBinderWithCollectionView:(UICollectionView *)collectionView hasSection:(BOOL)hasSection command:(RACCommand *)command;

/**
 添加TableView数据获取机制以及成功和失败的监听
 */
- (void)addTableViewDatasSubscribe:(YXWListRefreshSuccessBlock)success errorSubcribe:(YXWListRefreshErrorBlock)errorSubcribe;

/**
 添加CollectionView数据获取机制以及成功和失败的监听
 */
- (void)addCollectionViewDatasSubscribe:(YXWListRefreshSuccessBlock)successBlock errorSubcribe:(YXWListRefreshErrorBlock)errorSubcribe;


/**
 滑动值的 Block
 */
@property (nonatomic, copy) YXWListViewScrollOffsetBlock offsetBlock;

@property (nonatomic, copy) YXWListRefreshCustomBlock customRefreshBlock;

@property (nonatomic, weak) id<YXWListBinderTableViewDelegate> tableViewDelegate;

@property (nonatomic, weak) id<YXWListBinderCollectionViewDelegate> collectionViewDelegate;

@property (nonatomic, weak) id<YXWListBinderScrollViewDelegate> scrollViewDelegate;

@property (nonatomic, copy) NSArray *data;

/**
 带一些特殊参数给cell的特殊通道
 */
@property (nonatomic, copy) NSDictionary *extra;

@property (nonatomic, assign) BOOL needAnimation;

@end

NS_ASSUME_NONNULL_END
