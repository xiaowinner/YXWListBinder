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

/*
 Delegate
 */
@protocol YXWListBinderTableViewDelegate <NSObject>

- (void)YXWTableViewSelected:(UITableView *_Nullable)tableView
                   indexPath:(NSIndexPath *_Nullable)indexPath
                       model:(id<YXWListBinderViewModelProtocol> _Nullable)model;

@end


@protocol YXWListBinderCollectionViewDelegate <NSObject>

- (void)YXWCollectionViewSelected:(UICollectionView *_Nullable)collectionView
                        indexPath:(NSIndexPath *_Nullable)indexPath
                            model:(id<YXWListBinderViewModelProtocol> _Nullable)model;

@end


/*
 ScrollView Delegate
 */
@protocol YXWListBinderScrollViewDelegate <NSObject>

@optional

- (void)YXWScrollViewDidScroll:(UIScrollView *_Nullable)scrollView;

- (void)YXWScrollViewDidZoom:(UIScrollView *_Nullable)scrollView;

- (void)YXWScrollViewWillBeginDragging:(UIScrollView *_Nullable)scrollView;

- (void)YXWScrollViewWillEndDragging:(UIScrollView *_Nullable)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *_Nullable)targetContentOffset;

- (void)YXWScrollViewDidEndDragging:(UIScrollView *_Nullable)scrollView willDecelerate:(BOOL)decelerate;

- (void)YXWScrollViewWillBeginDecelerating:(UIScrollView *_Nullable)scrollView;

- (void)YXWScrollViewDidEndDecelerating:(UIScrollView *_Nullable)scrollView;

- (void)YXWScrollViewDidEndScrollingAnimation:(UIScrollView *_Nullable)scrollView;

- (UIView *_Nullable)YXWViewForZoomingInScrollView:(UIScrollView *_Nullable)scrollView;

- (void)YXWScrollViewWillBeginZooming:(UIScrollView *_Nullable)scrollView withView:(nullable UIView *)view;

- (void)YXWScrollViewDidEndZooming:(UIScrollView *_Nullable)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale;

- (BOOL)YXWScrollViewShouldScrollToTop:(UIScrollView *_Nullable)scrollView;

- (void)YXWScrollViewDidScrollToTop:(UIScrollView *_Nullable)scrollView;

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
typedef void(^YXWListRefreshErrorBlock)(NSError * _Nullable error);

/**
 不使用默认刷新，自定义刷新机制
 */
typedef void(^YXWListRefreshCustomBlock)(void);

#pragma mark UITableView
/**
 初始化binder，但不预注册cell
 */
- (instancetype _Nullable)initBinder:(UITableView *_Nullable)tableView command:(RACCommand *_Nullable)command;


/**
 根据nib注册Cell
 */
- (instancetype _Nullable )initBinder:(UITableView *_Nullable)tableView
                             nibsCell:(NSArray *_Nullable)nibsCell
                     nibHeaderFooters:(NSArray *_Nullable)nibHeaderFooters
                      cellIdentifiers:(NSArray *_Nullable)cellIdentifiers
              headerFooterIdentifiers:(NSArray *_Nullable)headerFooterIdentifiers
                          dataCommand:(RACCommand *_Nullable)dataCommand;

/**
 根据name注册Cell
 */
- (instancetype _Nullable )initBinder:(UITableView *_Nullable)tableView
                       cellClassNames:(NSArray *_Nullable)cellClassNames
               headerFooterClassNames:(NSArray *_Nullable)headerFooterClassNames
                          dataCommand:(RACCommand *_Nullable)dataCommand;


/**
 根据name或者nib注册Cell
 */
- (instancetype _Nullable )initBinder:(UITableView *_Nullable)tableView
                                cells:(NSArray *_Nullable)cells
                        headerFooters:(NSArray *_Nullable)headerFooters
                      cellIdentifiers:(NSArray *_Nullable)cellIdentifiers
              headerFooterIdentifiers:(NSArray *_Nullable)headerFooterIdentifiers
                          dataCommand:(RACCommand *_Nullable)dataCommand;


#pragma mark UICollectionView
/**
 初始化binder，但不预注册cell
 */
- (instancetype _Nullable)initBinder:(UICollectionView *_Nullable)collectionView commend:(RACCommand *_Nullable)commend;


/**
 根据nib注册Item
 */
- (instancetype _Nullable)initBinder:(UICollectionView *_Nullable)collectionView
                            nibsItem:(NSArray *_Nullable)nibsItem
                          nibHeaders:(NSArray *_Nullable)nibHeaders
                     itemIdentifiers:(NSArray *_Nullable)itemIdentifiers
                   headerIdentifiers:(NSArray *_Nullable)headerIdentifiers
                         dataCommand:(RACCommand *_Nullable)dataCommand;

/**
 根据name注册Item
 */
- (instancetype _Nullable )initBinder:(UICollectionView *_Nullable)collectionView
                       itemClassNames:(NSArray *_Nullable)itemClassNames
                     headerClassNames:(NSArray *_Nullable)headerClassNames
                          dataCommand:(RACCommand *_Nullable)dataCommand;


/**
 添加TableView数据获取机制以及成功和失败的监听
 */
- (void)addTableViewDatasSubscribe:(YXWListRefreshSuccessBlock _Nullable )success errorSubcribe:(YXWListRefreshErrorBlock _Nullable )errorSubcribe;

/**
 添加CollectionView数据获取机制以及成功和失败的监听
 */
- (void)addCollectionViewDatasSubscribe:(YXWListRefreshSuccessBlock _Nullable )successBlock errorSubcribe:(YXWListRefreshErrorBlock _Nullable )errorSubcribe;


/**
 滑动值的 Block
 */
@property (nonatomic, copy) YXWListViewScrollOffsetBlock _Nullable offsetBlock;

@property (nonatomic, copy) YXWListRefreshCustomBlock _Nullable customRefreshBlock;

@property (nonatomic, weak) id<YXWListBinderTableViewDelegate> _Nullable tableViewDelegate;

@property (nonatomic, weak) id<YXWListBinderCollectionViewDelegate> _Nullable collectionViewDelegate;

@property (nonatomic, weak) id<YXWListBinderScrollViewDelegate> _Nullable scrollViewDelegate;

@property (nonatomic, copy) NSArray * _Nullable data;

/**
 带一些特殊参数给cell的特殊通道
 */
@property (nonatomic, copy) NSDictionary * _Nullable extra;

@property (nonatomic, assign) BOOL needAnimation;

@end
