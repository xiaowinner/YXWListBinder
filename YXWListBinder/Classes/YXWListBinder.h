//
//  YXWListBinder.h
//  YXWListBinder
//
//  Created by 原晓文 on 2018/2/22.
//  Copyright © 2018年 xiaowinner. All rights reserved.
//

#import <ReactiveObjC/ReactiveObjC.h>

#import "YXWListBinderWidgetProtocol.h"
#import "YXWListBinderViewModelProtocol.h"

/*
 Delegate
 */

@protocol YXWListBinderTableViewDelegate <NSObject>

- (void)YXWTableViewSelected:(UITableView *)tableView
                   indexPath:(NSIndexPath*)indexPath
                       model:(id<YXWListBinderViewModelProtocol>)model;

@end


@protocol YXWListBinderCollectionViewDelegate <NSObject>

- (void)YXWCollectionViewSelected:(UICollectionView *)collectionView
                        indexPath:(NSIndexPath*)indexPath
                            model:(id<YXWListBinderViewModelProtocol>)model;

@end


@interface YXWListBinder : NSObject

/*
 获取滑动的偏移量
 */
typedef void(^YXWListViewScrollOffsetBlock)(CGPoint offset);

/*
 每次请求获得的models，用于外部控制显示细节
 */
typedef void(^YXWListRefreshSuccessBlock)(void);

/*
 每次请求失败的Blcok
 */
typedef void(^YXWListRefreshErrorBlock)(NSError *error);

/*
 不使用默认刷新，自定义刷新机制
 */
typedef void(^YXWListRefreshCustomBlock)(void);

/*
 当前TableView这一行的类型
 */
typedef NS_ENUM(NSInteger,YXWLineType) {
    IsSection = 1,
    IsRow = 2
};

#pragma mark UITableView

/*
 根据nib注册Cell
 */
- (instancetype)initBinder:(UITableView *)tableView
                  nibsCell:(NSArray *)nibsCell
          nibHeaderFooters:(NSArray *)nibHeaderFooters
           cellIdentifiers:(NSArray *)cellIdentifiers
   headerFooterIdentifiers:(NSArray *)headerFooterIdentifiers
               dataCommand:(RACCommand *)dataCommand;

/*
 根据name注册Cell
 */
- (instancetype)initBinder:(UITableView *)tableView
            cellClassNames:(NSArray *)cellClassNames
    headerFooterClassNames:(NSArray *)headerFooterClassNames
           cellIdentifiers:(NSArray *)cellIdentifiers
   headerFooterIdentifiers:(NSArray *)headerFooterIdentifiers
               dataCommand:(RACCommand *)dataCommand;




#pragma mark UICollectionView

/*
 根据nib注册Item
 */
- (instancetype)initBinder:(UICollectionView *)collectionView
                  nibsItem:(NSArray *)nibsItem
                nibHeaders:(NSArray *)nibHeaders
           itemIdentifiers:(NSArray *)itemIdentifiers
         headerIdentifiers:(NSArray *)headerIdentifiers
               dataCommand:(RACCommand *)dataCommand;

/*
 根据name注册Item
 */
- (instancetype)initBinder:(UICollectionView *)collectionView
            itemClassNames:(NSArray *)itemClassNames
          headerClassNames:(NSArray *)headerClassNames
           itemIdentifiers:(NSArray *)itemIdentifiers
         headerIdentifiers:(NSArray *)headerIdentifiers
               dataCommand:(RACCommand *)dataCommand;


/*
 添加TableView数据获取机制以及成功和失败的监听
 */
- (void)addTableViewDatasSubscribe:(YXWListRefreshSuccessBlock)success errorSubcribe:(YXWListRefreshErrorBlock)errorSubcribe;

/*
 添加CollectionView数据获取机制以及成功和失败的监听
 */
- (void)addCollectionViewDatasSubscribe:(YXWListRefreshSuccessBlock)successBlock errorSubcribe:(YXWListRefreshErrorBlock)errorSubcribe;


/*
 滑动值的 Block
 */
@property (nonatomic, copy) YXWListViewScrollOffsetBlock offsetBlock;

@property (nonatomic, copy) YXWListRefreshCustomBlock customRefreshBlock;

@property (nonatomic, weak) id<YXWListBinderTableViewDelegate> tableViewDelegate;

@property (nonatomic, weak) id<YXWListBinderCollectionViewDelegate> collectionViewDelegate;

@property (nonatomic, copy) NSArray *data;

@property (nonatomic, assign) BOOL needAnimation;

@end
