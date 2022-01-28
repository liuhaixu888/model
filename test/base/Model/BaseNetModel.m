//
//  BaseNetModel.m
//  MDisney
//
//  Created by wangws1990 on 2018/7/19. 
//  Copyright © 2018年 wangws1990. All rights reserved.
//

#import "BaseNetModel.h"

@implementation BaseNetModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{@"msg" : @[@"msg", @"err",@"error"],
             @"resultset":@[@"resultset",@"res",@"result"],
             @"code":@[@"code",@"errorCode"]};
}
//数据是否正常
-(BOOL)isDataSuccess
{
    return self.code == 0;
    
}
- (BOOL)isNetError
{
    return self.code != 0;
}
+ (instancetype)successModel:(id)response urlString:(NSString *)urlString params:(NSDictionary *)params headParams:(NSDictionary *)headParams
{
    BaseNetModel * model = [BaseNetModel modelWithJSON:response];
    model.allResultData = response;
    model.requestUrl = urlString;
    model.params = params;
    model.headParams = headParams;
    if (!model.resultset) {
        model.resultset = model.allResultData;
    }
    if(![model isDataSuccess])
    {
#ifdef DEBUG
        NSLog(@"url:%@\n params:%@\n headParams:%@\n result:%@\n",urlString,params,headParams,model.allResultData);
#endif
    }
    return model;
}
+ (NSDictionary *)analysisData:(id)response{
    NSError * error = nil;
    NSDictionary * obj  = nil;
    if ([response isKindOfClass:[NSString class]])
    {
        obj = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];

    }else if ([response isKindOfClass:[NSData class]])
    {
        obj = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            NSString *errorStr = error.userInfo[@"NSDebugDescription"];
            if ([errorStr containsString:@"Unable to convert data"]) {
                NSString* strdata = [[NSString alloc]initWithData:response encoding:NSISOLatin1StringEncoding];//在将NSString类型转为NSData
                NSData * data = [strdata dataUsingEncoding:NSUTF8StringEncoding];//这样解决的乱码问题。
                obj = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error ];
            }
        }
        
    }
    else if ([response isKindOfClass:[NSDictionary class]])
    {
        obj = response;
    }else if ([response isKindOfClass:[NSArray class]]){
        obj = response;
    }
    return obj;
}
+ (instancetype)netErrorModel:(NSString *)error
{
    BaseNetModel * model = [[[self class] alloc] init];
    model.msg = error;
    model.code = 404;
    model.resultset = nil;
    model.allResultData = nil;
    return model;
}
+ (NSString *)analysisError:(NSError *)error{
    NSString *info = @"";
    switch (error.code) {
        case NSURLErrorNotConnectedToInternet:
            info = @"无网络连接,请检查网络设置";
            break;
        case NSURLErrorTimedOut:
            info = @"服务器请求超时,请重试!";
            break;
        default:
            info = error.userInfo[@"NSLocalizedDescription"];
            break;
    }
    return info;
}
@end
