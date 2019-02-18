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

### 概念
我们大多数构建页面 基本都可以使用TableView 或者 CollectionView来实现，binder的意义在于使用mvvm模式开发，更注重在viewmodel的数据流的控制来拼装页面的子视图，把viewcontroller只是作为一个通道。


一个简单的collection页面搭建
1.创建控制器 继承自YXWBaseCollectionViewController。
2.初始化控制器对应的viewmodel。
3.注册页面要展示的cell
   如：
  ```
  NSArray *cellNibs = @[
  [UICollectionViewCell nibFromModule]
  ];
  
  NSArray *cellIdentifiers = @[
  [UICollectionViewCell className]
  ];
  
  NSArray *headerNibs = @[
  [UICollectionViewHeader nibFromModule]
  ];
  
  NSArray *headerIdentifiers = @[
  [UICollectionViewHeader className]
  ];
  
  self.listBinder = [[YXWListBinder alloc] initBinder:self.collectionView
  nibsItem:cellNibs
  nibHeaders:headerNibs
  itemIdentifiers:cellIdentifiers
  headerIdentifiers:headerIdentifiers
  dataCommand:self.viewModel.dataCommand];
 ```
 4.重写requestAndCombinedData，给Viewmodel的默认请求command传参数。
 ```
 - (void)requestAndCombinedData {
    RACTuple *tuple = [RACTuple tupleWithObjects:self.category,more,nil];
    [self.viewModel.dataCommand execute:tuple];
 }
```

5.Viewmodel中重写requestData方法组装展示的视图。model的概念就是展示的控件，所以每个model应遵守YXWListBinderViewModelProtocol协议，实现对应控件的identifier方法，widgetHeight方法。
这样在viewmodel中请求到的model数据塞到数组里时就可以当成一个个需要展示的view塞到了数组中。
 
