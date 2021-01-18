# YXWListBinder

## 🏁集成

- podfile 中输入 pod 'YXWListBinder'
- 执行pod update.

## 🏃‍♂️开始

### 提示

- 该项目依赖于ReactCocoa.
- 项目中包含TableView和CollectionView的使用Demo.
- 根据自己的需求实现自己的YXWListBinderWidgetProtocol 和 YXWListBinderViewModelProtocol

### 实现步骤

- 头文件声明
``` objective-c
#import <YXWListBinder/YXWListBinder.h>
#import <YXWListBinder/YXWListBinderKit.h>
```

```objective-c
/*
一、创建控制器的ViewModel,继承自YXWBaseViewModel
1.重写- (RACSignal *)requestData:(RACTuple *)tuple;
2.初始化CellModel和HeaderModel(因HeaderModel要实现的协议较多，建议继承自YXWBaseHeaderModel)
3.向self.data中塞入model，并发送出去.
*/

- (RACSignal *)requestData:(RACTuple *)tuple {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        YXWClassModel *aModel = [YXWClassModel new];
        YXWNibModel *bModel = [YXWNibModel new];
        YXWNibHeaderModel *headerModel = [YXWNibHeaderModel new];
        
        headerModel.subData = [NSMutableArray arrayWithObjects:aModel,bModel, nil];

        for (int i = 0; i<100; i++) {
            YXWNibModel *tModel = [YXWNibModel new];
            [headerModel.subData addObject:tModel];
        }
        
        self.data = [NSMutableArray arrayWithObjects:self.headerModel, nil];
        
        [subscriber sendNext:self.data];
        [subscriber sendCompleted];
        return nil;
    }];
}
```

```objective-c
/*
二、在控制器ViewDidLoad初始化ViewModel、TableView、YXWListBinder
*/
- (void)viewDidLoad
{
    [super viewDidLoad];

    //初始化Binder
    self.tableViewBinder = [[YXWListBinder alloc] initBinderWithTableView:self.tableView hasSection:YES command:self.viewModel.dataCommand];
    
    [self.tableViewBinder addTableViewDatasSubscribe:^{
    //数据刷新完成后....
    } errorSubcribe:^(NSError *error) {
    //请求错误...
    }];

  	//触发viewmodel中的数据请求
    [self.viewModel.dataCommand execute:@(1)];
}
```

```objective-c
/*
三、Cell中实现bindViewModel方法，绑定数据源.
*/
- (void)bindViewModel:(id<YXWListBinderViewModelProtocol>)viewModel
     sectionViewModel:(id<YXWListBinderViewModelProtocol>)sectionViewModel
          atIndexPath:(NSIndexPath *)indexPath
                first:(BOOL)first
              finally:(BOOL)finally
                extra:(NSDictionary *)extra;
```

```objective-c
/*
CellModel必须实现的协议.
*/
- (CGFloat)widgetHeight {
    return 高度;
}
    
- (NSString *)identifier {
    return cell标识;
}

- (YXWLineType)lineType {
    return 类型;
}

- (id)showWidget {
    return 要展示的cell class字符串或者nib;
}
```


## 🌗 理念

- 我们大多数构建页面 基本都可以使用TableView 或者 CollectionView来实现，Binder的意义在于使用MVVM模式开发，更注重在viewmodel的数据流的控制来拼装页面的子视图，把viewcontroller只是作为一个通道。

