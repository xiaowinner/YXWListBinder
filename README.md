# YXWListBinder

### 使用

只需要进行如下步骤:

- Podfile 中输入 pod 'YXWListBinder'
- 移动YXWListBinder文件夹下的所有文件到你的项目.
- 执行pod install.

### 注意
0.2.0 依赖的是老版本ReactiveCocoa >= 2.5，
0.3.0 之后依赖最新的ReactiveObjC

提示 :)

- 该项目依赖于ReactCocoa，请在Podfile中添加 pod 'ReactiveObjC'.

- 项目中包含Demo.

- 根据自己的需求制定自己的YXWListBinderWidgetProtocol 和 YXWListBinderViewModelProtocol

- Protocol中要有MVVM的绑定机制的方法，如：

```objective-c
/*
Cell
*/
- (void)bindViewModel:(id<YXWListBinderViewModelProtocol>)viewModel atIndexPath:(NSIndexPath *)indexPath;
/*
ViewModel
*/
@required
- (NSString *)identifier;
- (CGFloat)widgetHeight;

@optional
- (NSInteger)gainSubDataCount:(NSInteger)section;
- (id <YXWListBinderViewModelProtocol>)gainSubData:(NSInteger)index;
```

- 注意区分以下两个初始化方法：

```objective-c
/*
根据 nib 注册TableView Cell
*/
- (instancetype)initBinder:(UITableView *)tableView
dataCommand:(RACCommand *)dataCommand
hasSection:(BOOL)hasSection
nibsCell:(NSArray *)nibs
identifiers:(NSArray *)identifiers;
```

```objective-c
/*
根据 Class name 注册TableView Cell
*/
- (instancetype)initBinder:(UITableView *)tableView
dataCommand:(RACCommand *)dataCommand
hasSection:(BOOL)hasSection
cellClassNames:(NSArray *)names
identifiers:(NSArray *)identifiers;
```

```objective-c
/*
根据 nib 注册CollectionView Item
*/
- (instancetype)initBinder:(UICollectionView *)collectionView
nibsItem:(NSArray *)nibsItem
itemIdentifiers:(NSArray *)itemIdentifiers
dataCommand:(RACCommand *)dataCommand;
```

```objective-c
/*
根据 Class name 注册CollectionView Item
*/
- (instancetype)initBinder:(UICollectionView *)collectionView
itemClassNames:(NSArray *)itemClassNames
itemIdentifiers:(NSArray *)itemIdentifiers
dataCommand:(RACCommand *)dataCommand;
```

​
