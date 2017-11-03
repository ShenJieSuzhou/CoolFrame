//
//  AFNetwork.m
//  Pods
//
//  Created by yunfenghan Ling on 3/13/17.
//
//

#ifdef DEBUG
#define AFPLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define AFPLog(format, ...)
#endif

#import "AFNetwork.h"

@implementation AFNetwork

+ (instancetype)shareManager {
    static AFNetwork *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [self manager];
        manager.requestSerializer.timeoutInterval = 15;
        manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", nil];
    });
    return manager;
}


#pragma -
#pragma mark
- (void)requestURL:(NSString *)url params:(NSMutableDictionary *)params success:(successBlock)success failure:(failureBlock)failure {
    [self requestWithMethod:GET url:url params:params success:success failure:failure finish:^{
        
    }];
}

- (void)requestWithMethod:(HTTPMethod)method url:(NSString *)url params:(NSMutableDictionary *)params success:(successBlock)success failure:(failureBlock)failure {
    [self requestWithMethod:method url:url params:params success:success failure:failure finish:^{
        
    }];
}

- (void)requestURL:(NSString *)url params:(NSMutableDictionary *)params success:(successBlock)success failure:(failureBlock)failure finish:(finishBlock)finish {
    [self requestWithMethod:GET url:url params:params success:success failure:failure finish:finish];
}

- (void)requestWithMethod:(HTTPMethod)method url:(NSString *)url params:(NSMutableDictionary *)params success:(successBlock)success failure:(failureBlock)failure finish:(finishBlock)finish {
    switch (method) {
        case GET:
            [self requestGETURL:url params:params success:success failure:failure finish:finish];
            break;
        case POST:
            [self requestPOSTURL:url params:params success:success failure:failure finish:finish];
            break;
        case PUT:
            [self requestPUTURL:url params:params success:success failure:failure finish:finish];
            break;
        case DELETE:
            [self requestDELETEURL:url params:params success:success failure:failure finish:finish];
            break;
        default:
            AFPLog(@"method %d, not support", method);
            break;
    }
}


#pragma -
#pragma mark
- (void)requestGETURL:(NSString *)url params:(NSMutableDictionary *)params success:(successBlock)success failure:(failureBlock)failure finish:(finishBlock)finish {
    [self GET:url
   parameters:params
     progress:nil
      success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
          AFPLog(@"afnetwork request success url = %@", url);
          if (finish) {
              finish();
          }
          if (success) {
              success(task, responseObject);
          }
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          AFPLog(@"request failure url = %@", url);
          if (finish) {
              finish();
          }
          if (failure) {
              failure(task, error);
          }
      }];
}

- (void)requestPOSTURL:(NSString *)url params:(NSMutableDictionary *)params success:(successBlock)success failure:(failureBlock)failure finish:(finishBlock)finish  {
    [self POST:url
    parameters:params
      progress:nil
       success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
           AFPLog(@"afnetwork request success url = %@", url);
           if (finish) {
               finish();
           }
           if (success) {
               success(task, responseObject);
           }
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           AFPLog(@"request failure url = %@", url);
           if (finish) {
               finish();
           }
           if (failure) {
               failure(task, error);
           }
       }];
}

- (void)requestPUTURL:(NSString *)url params:(NSMutableDictionary *)params success:(successBlock)success failure:(failureBlock)failure finish:(finishBlock)finish  {
    [self PUT:url
   parameters:params
      success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
          AFPLog(@"afnetwork request success url = %@", url);
          if (finish) {
              finish();
          }
          if (success) {
              success(task, responseObject);
          }
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          AFPLog(@"request failure url = %@", url);
          if (finish) {
              finish();
          }
          if (failure) {
              failure(task, error);
          }
      }];
}

- (void)requestDELETEURL:(NSString *)url params:(NSMutableDictionary *)params success:(successBlock)success failure:(failureBlock)failure finish:(finishBlock)finish  {
    [self DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        AFPLog(@"afnetwork request success url = %@", url);
        if (finish) {
            finish();
        }
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        AFPLog(@"request failure url = %@", url);
        if (finish) {
            finish();
        }
        if (failure) {
            failure(task, error);
        }
    }];
}

@end
