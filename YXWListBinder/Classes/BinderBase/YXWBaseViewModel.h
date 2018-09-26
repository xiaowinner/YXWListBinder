//占位Model
#import "YXWPlaceHolderHeaderViewModel.h"
#import "YXWTitlePlaceHolderViewModel.h"
#import "YXWTitleImagePlaceHolderViewModel.h"
#import "YXWCollectionPlaceHolderHeaderViewModel.h"
#import "YXWWhitePlaceHolderViewModel.h"
#import "YXWCollectionTitleImagePlaceHolderViewModel.h"

//占位Widget
#import "YXWTitleImagePlaceHolderCell.h"
#import "YXWTitlePlaceHolderCell.h"
#import "YXWPlaceHolderHeaderView.h"
#import "YXWWhitePlaceHolderCell.h"
#import "YXWCollectionTitleImagePlaceHolderCell.h"
#import "YXWCollectionPlaceHolderHeaderView.h"

typedef NS_ENUM(NSUInteger, YXWPlaceHolderType) {
    YXWPlaceHolderTitleType,
    YXWPlaceHolderTitleAndImageType,
};

typedef NS_ENUM(NSUInteger, YXWPlaceHolderImageType) {
    YXWPlaceHolderNoNetType,
    YXWPlaceHolderNoDataType,
    YXWPlaceHolderNormalType
};


@interface YXWBaseViewModel : NSObject

@property (strong, nonatomic) RACCommand *dataCommand;
@property (strong, nonatomic) NSMutableArray *data;

/*
 子类重写该请求方法
*/
- (RACSignal *)requestData:(RACTuple *)tuple;


//获取collectionView的占位
- (NSMutableArray *)collectionNormalPlaceHolderWith:(NSString *)title height:(CGFloat)height imageType:(YXWPlaceHolderImageType)imageType;


- (NSMutableArray *)collectionHaveHeaderPlaceHolderWith:(NSString *)title height:(CGFloat)height imageType:(YXWPlaceHolderImageType)imageType;


//获取tableView的占位
- (NSMutableArray *)generateNormalPlaceHolderWith:(NSString *)title cellHeight:(CGFloat)cellHeight type:(YXWPlaceHolderType)type imageType:(YXWPlaceHolderImageType)imageType;


- (NSMutableArray *)generateHaveHeaderPlaceHolderWith:(NSString *)title cellHeight:(CGFloat)cellHeight type:(YXWPlaceHolderType)type imageType:(YXWPlaceHolderImageType)imageType;


//重写设置自己的图片
- (NSString *)gainImageNameWithType:(YXWPlaceHolderImageType)type;

@end
