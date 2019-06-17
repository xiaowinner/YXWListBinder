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


@implementation YXWViewModel

- (RACSignal *)requestData:(RACTuple *)tuple {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        YXWClassModel *aModel = [YXWClassModel new];
        YXWNibModel *bModel = [YXWNibModel new];
        self.data = [NSMutableArray arrayWithObjects:aModel,bModel, nil];
        [subscriber sendNext:self.data];
        return nil;
    }];
}
    
@end
