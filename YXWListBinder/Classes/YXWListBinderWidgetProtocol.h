//
//  YXWListBinderProtocol.h
//  YXWListBinder
//
//  Created by 原晓文 on 2018/2/22.
//  Copyright © 2018年 xiaowinner. All rights reserved.
//

#import "YXWListBinderViewModelProtocol.h"

/*
 用于Cell Header Footer
 */
@protocol YXWListBinderWidgetProtocol

@optional
/**
 数据绑定
 */
- (void)bindViewModel:(id<YXWListBinderViewModelProtocol>)viewModel
          atIndexPath:(NSIndexPath *)indexPath;

/**
 数据绑定
 finally是否是当前section中最后一个model
 */
- (void)bindViewModel:(id<YXWListBinderViewModelProtocol>)viewModel
          atIndexPath:(NSIndexPath *)indexPath
                first:(BOOL)first
              finally:(BOOL)finally
                extra:(NSDictionary *)extra;

/**
 数据绑定
 附带所属sectionModel
 section可能为nil
 */
- (void)bindViewModel:(id<YXWListBinderViewModelProtocol>)viewModel
     sectionViewModel:(id<YXWListBinderViewModelProtocol>)sectionViewModel
          atIndexPath:(NSIndexPath *)indexPath
                first:(BOOL)first
              finally:(BOOL)finally
                extra:(NSDictionary *)extra;

/**
 UITableView
 点击cell事件,如果控制器的点击delegate不实现的话，则执行该方法
 */
- (void)didSelectedCell:(id<YXWListBinderViewModelProtocol>)viewModel
              tableView:(UITableView *)tableView
            atIndexPath:(NSIndexPath *)indexPath
                  first:(BOOL)first
                finally:(BOOL)finally;

/**
 UITableView
 Cell即将显示
 */
- (void)willDisplayCell:(UITableView *)tableView
              viewModel:(id<YXWListBinderViewModelProtocol>)viewModel
              indexPath:(NSIndexPath *)indexPath;

/**
 UITableView
 Cell消失
 viewModel 为nil 暂不在EndDisplay中暴漏
 */
- (void)didEndDisplayingCell:(UITableView *)tableView
                   viewModel:(id<YXWListBinderViewModelProtocol>)viewModel
                   indexPath:(NSIndexPath *)indexPath;


/**
 UICollectionView
 点击cell事件,如果控制器的点击delegate不实现的话，则执行该方法
 */
- (void)didSelectedCell:(id<YXWListBinderViewModelProtocol>)viewModel
         collectionView:(UICollectionView *)collectionView
            atIndexPath:(NSIndexPath *)indexPath
                  first:(BOOL)first
                finally:(BOOL)finally;

/**
 UICollectionView
 Cell即将显示
 */
- (void)willDisplayCollectionCell:(UICollectionView *)collectionView
                        viewModel:(id<YXWListBinderViewModelProtocol>)viewModel
                        indexPath:(NSIndexPath *)indexPath;

/**
 UICollectionView
 Cell消失
 viewModel 为nil 暂不在EndDisplay中暴漏
 */
- (void)didEndDisplayingCollectionCell:(UICollectionView *)collectionView
                             viewModel:(id<YXWListBinderViewModelProtocol>)viewModel
                             indexPath:(NSIndexPath *)indexPath;

@end
