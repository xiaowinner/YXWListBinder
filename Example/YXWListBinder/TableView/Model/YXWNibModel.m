//
//  YXWNibModel.m
//  YXWListBinder_Example
//
//  Created by 原晓文 on 2019/6/17.
//  Copyright © 2019 原晓文. All rights reserved.
//

#import "YXWNibModel.h"

@implementation YXWNibModel

- (CGFloat)widgetHeight {
    return 100;
}
    
- (NSString *)identifier {
    return @"YXWNibTableViewCell";
}

- (YXWLineType)lineType {
    return LineRow;
}


- (id)showWidget {
    UINib *aNib = [UINib nibWithNibName:@"YXWNibTableViewCell" bundle:[NSBundle mainBundle]];
    return aNib;
}

    
@end
