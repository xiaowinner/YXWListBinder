#import "YXWBaseViewModel.h"

@implementation YXWBaseViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _data = [NSMutableArray array];
        @weakify(self);
        _dataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(RACTuple *tuple) {
            @strongify(self);
            return [[self requestData:tuple] materialize];
        }];
    }
    return self;
}

- (RACSignal *)requestData:(RACTuple *)tuple {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSMutableArray *models = [NSMutableArray array];
        [subscriber sendNext:models];
        [subscriber sendCompleted];
        return nil;
    }];
}


//CollectionView
- (NSMutableArray *)collectionNormalPlaceHolderWith:(NSString *)title height:(CGFloat)height imageType:(YXWPlaceHolderImageType)imageType {
    
    NSMutableArray *resultArray = [NSMutableArray array];
    YXWCollectionTitleImagePlaceHolderViewModel *titleImageViewModel = [[YXWCollectionTitleImagePlaceHolderViewModel alloc] init];
    titleImageViewModel.title = title;
    titleImageViewModel.height = height;
    titleImageViewModel.imageName = [self gainImageNameWithType:imageType];
    [resultArray addObject:titleImageViewModel];
    return resultArray;
    
}

- (NSMutableArray *)collectionHaveHeaderPlaceHolderWith:(NSString *)title height:(CGFloat)height imageType:(YXWPlaceHolderImageType)imageType {
    
    NSMutableArray *resultArray = [NSMutableArray array];
    YXWCollectionPlaceHolderHeaderViewModel *headerViewModel = [[YXWCollectionPlaceHolderHeaderViewModel alloc] init];
    YXWCollectionTitleImagePlaceHolderViewModel *titleImageViewModel = [[YXWCollectionTitleImagePlaceHolderViewModel alloc] init];
    titleImageViewModel.title = title;
    titleImageViewModel.height = height;
    titleImageViewModel.imageName = [self gainImageNameWithType:imageType];
    headerViewModel.subData = [NSMutableArray arrayWithArray:@[titleImageViewModel]];
    [resultArray addObject:headerViewModel];
    return resultArray;
    
}


// TableView
- (NSMutableArray *)generateHaveHeaderPlaceHolderWith:(NSString *)title cellHeight:(CGFloat)cellHeight type:(YXWPlaceHolderType)type imageType:(YXWPlaceHolderImageType)imageType {
    switch (type) {
        case YXWPlaceHolderTitleType:
        {
            NSMutableArray *resultArray = [NSMutableArray array];
            YXWPlaceHolderHeaderViewModel *headerViewModel = [[YXWPlaceHolderHeaderViewModel alloc] init];
            YXWTitlePlaceHolderViewModel *titleViewModel = [[YXWTitlePlaceHolderViewModel alloc] init];
            titleViewModel.title = title;
            titleViewModel.height = cellHeight;
            headerViewModel.subData = [NSMutableArray arrayWithArray:@[titleViewModel]];
            [resultArray addObject:headerViewModel];
            return resultArray;
        }
            break;
        case YXWPlaceHolderTitleAndImageType:
        {
            NSMutableArray *resultArray = [NSMutableArray array];
            YXWPlaceHolderHeaderViewModel *headerViewModel = [[YXWPlaceHolderHeaderViewModel alloc] init];
            YXWTitleImagePlaceHolderViewModel *titleImageViewModel = [[YXWTitleImagePlaceHolderViewModel alloc] init];
            titleImageViewModel.title = title;
            titleImageViewModel.height = cellHeight;
            titleImageViewModel.imageName = [self gainImageNameWithType:imageType];
            headerViewModel.subData = [NSMutableArray arrayWithArray:@[titleImageViewModel]];
            [resultArray addObject:headerViewModel];
            return resultArray;
        }
            break;
    }
}


- (NSMutableArray *)generateNormalPlaceHolderWith:(NSString *)title cellHeight:(CGFloat)cellHeight type:(YXWPlaceHolderType)type imageType:(YXWPlaceHolderImageType)imageType {
    switch (type) {
        case YXWPlaceHolderTitleType:
        {
            NSMutableArray *resultArray = [NSMutableArray array];
            YXWTitlePlaceHolderViewModel *titleViewModel = [[YXWTitlePlaceHolderViewModel alloc] init];
            titleViewModel.title = title;
            titleViewModel.height = cellHeight;
            [resultArray addObject:titleViewModel];
            return resultArray;
        }
            break;
        case YXWPlaceHolderTitleAndImageType:
        {
            NSMutableArray *resultArray = [NSMutableArray array];
            YXWTitleImagePlaceHolderViewModel *titleImageViewModel = [[YXWTitleImagePlaceHolderViewModel alloc] init];
            titleImageViewModel.title = title;
            titleImageViewModel.height = cellHeight;
            titleImageViewModel.imageName = [self gainImageNameWithType:imageType];
            [resultArray addObject:titleImageViewModel];
            return resultArray;
        }
            break;
    }
}


- (NSString *)gainImageNameWithType:(YXWPlaceHolderImageType)type {
    switch (type) {
        case YXWPlaceHolderNoNetType:
        {
            return @"no_netWorkDefault";
        }
            break;
        case YXWPlaceHolderNoDataType:
        {
            return @"noContentDefault";
        }
            break;
        default:
            return @"noContentDefault";
            break;
    }
}

@end
