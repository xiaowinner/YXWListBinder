//响应参数
#define binderResponseKey_code @"code"
#define binderResponseKey_data @"data"
#define binderResponseKey_datas @"datas"
#define binderResponseKey_msg @"msg"
#define binderResponseKey_message @"message"
#define binderResponseKey_total @"total"

//错误域名
#define binderErrorDomain_Default @"ErrorDomain_Default"
#define binderErrorDomain_Category @"ErrorDomain_Category"
#define binderErrorDomain_NetNotReachable @"ErrorDomain_NetNotReachable"

//错误码
#define binderSuccessCode (1)  //操作成功
#define binderErrorCode_Default binderErrorCode_Fail
#define binderErrorCode_Fail (0)  //操作失败
#define binderErrorCode_Exception (-1)  //操作异常
#define binderErrorCode_InvalidParam (-2)  //参数错误
#define binderErrorCode_NoAccess (-3)  //您没有权限
#define binderErrorCode_NoLogin (-4)  //您还没有登录，请登录

//错误信息
#define binderErrorMsgKey @"msg"
#define binderErrorMsg_Default binderErrorMsg_Fail
#define binderErrorMsg_Fail @"服务器开小差了，请稍候重试"
#define binderErrorMsg_Exception @"网络连接异常，请检查网络设置"
#define binderErrorMsg_InvalidParam @"参数错误"
#define binderErrorMsg_NoAccess @"您没有权限"
#define binderErrorMsg_NoLogin @"您还没有登录，请登录"

#define binderNullSafe(value)\
({\
id tmp;\
if ([value isKindOfClass:[NSNull class]]) {\
tmp = nil; }\
else {\
tmp = value; }\
tmp;\
})\


@interface NSError (Binder)

+ (NSError *)initWithMessage:(NSString *)message;
- (NSString *)errorMsg;

@end
