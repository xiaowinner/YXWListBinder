//
//  YXWViewModel.m
//  YXWListBinder_Example
//
//  Created by 原晓文 on 2019/6/17.
//  Copyright © 2019 原晓文. All rights reserved.
//

#import "YXWViewModel.h"
#import "YXWClassModel.h"
#import "YXWNibModel.h"
#import "YXWNibHeaderModel.h"


@interface YXWViewModel ()

@property (nonatomic, strong) YXWNibHeaderModel *headerModel;

@end


@implementation YXWViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _headerModel = [[YXWNibHeaderModel alloc] init];
    }
    return self;
}

- (RACSignal *)requestData:(RACTuple *)tuple {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        YXWClassModel *aModel = [YXWClassModel new];
        YXWNibModel *bModel = [YXWNibModel new];
        YXWNibModel *cModel = [YXWNibModel new];
        YXWNibModel *dModel = [YXWNibModel new];
        YXWNibModel *eModel = [YXWNibModel new];
        YXWNibModel *fModel = [YXWNibModel new];
        YXWNibModel *gModel = [YXWNibModel new];
        YXWNibModel *hModel = [YXWNibModel new];
        YXWNibModel *iModel = [YXWNibModel new];
        YXWNibModel *jModel = [YXWNibModel new];

        self.headerModel.subData = [NSMutableArray arrayWithObjects:aModel,bModel,cModel,dModel,eModel,fModel,gModel,hModel,iModel,jModel, nil];
        self.data = [NSMutableArray arrayWithObjects:self.headerModel, nil];
        
        [subscriber sendNext:self.data];
        
        self.headerModel.subData = nil;
        [subscriber sendNext:self.data];
        
        self.headerModel.subData = [NSMutableArray arrayWithObjects:aModel,bModel,cModel,dModel,eModel,fModel,gModel,hModel,iModel,jModel, nil];
        [subscriber sendNext:self.data];
        
        self.headerModel.subData = [NSMutableArray arrayWithObjects:aModel,bModel,cModel,dModel,eModel,fModel,gModel,hModel,iModel,jModel, nil];
        [subscriber sendNext:self.data];
        
        self.headerModel.subData = nil;
        [subscriber sendNext:self.data];
        
        self.headerModel.subData = [NSMutableArray arrayWithObjects:aModel,bModel,cModel,dModel,eModel,fModel,gModel,hModel,iModel,jModel, nil];
        [subscriber sendNext:self.data];
        [subscriber sendCompleted];
        return nil;
    }];
}
    
@end
