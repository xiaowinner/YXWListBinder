//
//  YXWCLViewModel.m
//  YXWListBinder_Example
//
//  Created by 原晓文 on 2021/1/18.
//  Copyright © 2021 原晓文. All rights reserved.
//

#import "YXWCLViewModel.h"

#import "YXWClHeaderViewModel.h"
#import "YXWCLModel.h"
#import "YXWCLClassModel.h"

@interface YXWCLViewModel ()

@property (nonatomic, strong) YXWClHeaderViewModel *headerViewModel;

@end


@implementation YXWCLViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _headerViewModel = [[YXWClHeaderViewModel alloc] init];
    }
    return self;
}

- (RACSignal *)requestData:(RACTuple *)tuple {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        YXWCLModel *aModel = [YXWCLModel new];
        YXWCLClassModel *bModel = [YXWCLClassModel new];
        YXWCLClassModel *cModel = [YXWCLClassModel new];
        YXWCLClassModel *dModel = [YXWCLClassModel new];
        YXWCLClassModel *eModel = [YXWCLClassModel new];
        YXWCLClassModel *fModel = [YXWCLClassModel new];
        self.headerViewModel.subData = [NSMutableArray arrayWithObjects:aModel,bModel,cModel,dModel,eModel,fModel, nil];

        for (int i = 0; i<100; i++) {
            YXWCLClassModel *tModel = [YXWCLClassModel new];
            [self.headerViewModel.subData addObject:tModel];
        }
        
        self.data = [NSMutableArray arrayWithObjects:self.headerViewModel, nil];
        [subscriber sendNext:self.data];
        return nil;
    }];
}

@end
