//
//  AFNetwork.h
//  Pods
//
//  Created by yunfenghan Ling on 3/13/17.
//
//

#import <AFNetworking/AFNetworking.h>

@interface AFNetwork : AFHTTPSessionManager

typedef void (^successBlock)(NSURLSessionDataTask *task, NSDictionary *dict);
typedef void (^failureBlock)(NSURLSessionDataTask *task, NSError *error);
typedef void (^finishBlock)();

typedef enum {
    GET,
    POST,
    PUT,
    DELETE
} HTTPMethod;

+ (instancetype)shareManager;
- (void)requestWithMethod:(HTTPMethod)method url:(NSString *)url params:(NSMutableDictionary *)params success:(successBlock)success failure:(failureBlock)failure;
- (void)requestURL:(NSString *)url params:(NSMutableDictionary *)params success:(successBlock)success failure:(failureBlock)failure;

#pragma mark -
- (void)requestWithMethod:(HTTPMethod)method url:(NSString *)url params:(NSMutableDictionary *)params success:(successBlock)success failure:(failureBlock)failure finish:(finishBlock)finish;
- (void)requestURL:(NSString *)url params:(NSMutableDictionary *)params success:(successBlock)success failure:(failureBlock)failure finish:(finishBlock)finish;


@end

