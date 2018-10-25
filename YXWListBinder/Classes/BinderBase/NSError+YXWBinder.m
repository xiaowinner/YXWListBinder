#import "NSError+YXWBinder.h"

@implementation NSError (YXWBinder)

+ (NSError *)initWithMessage:(NSString *)message {
    if (message) {
        return [self errorWithDomain:binderErrorDomain_Default code:binderErrorCode_Fail userInfo:@{@"msg":message}];
    }else {
        return nil;
    }
}

- (NSString *)errorMsg
{
    NSString *errorMsg = binderNullSafe(self.userInfo[binderErrorMsgKey]);
    if (errorMsg.length) {
        return errorMsg;
    }
    errorMsg = self.localizedDescription;
    if (errorMsg.length) {
        return errorMsg;
    }
    return binderErrorMsg_Default;
}

@end
