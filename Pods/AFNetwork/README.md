# AFNetwork

[![CI Status](http://img.shields.io/travis/lingyfh/AFNetwork.svg?style=flat)](https://travis-ci.org/lingyfh/AFNetwork)
[![Version](https://img.shields.io/cocoapods/v/AFNetwork.svg?style=flat)](http://cocoapods.org/pods/AFNetwork)
[![License](https://img.shields.io/cocoapods/l/AFNetwork.svg?style=flat)](http://cocoapods.org/pods/AFNetwork)
[![Platform](https://img.shields.io/cocoapods/p/AFNetwork.svg?style=flat)](http://cocoapods.org/pods/AFNetwork)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.
```ruby
typedef enum {
    GET,
    POST,
    PUT,
    DELETE
} HTTPMethod;

+ (instancetype)shareManager;

- (void)requestWithMethod:(HTTPMethod)method 
                      url:(NSString *)url 
                   params:(NSMutableDictionary *)params 
                  success:(successBlock)success 
                  failure:(failureBlock)failure;

- (void)requestURL:(NSString *)url 
            params:(NSMutableDictionary *)params 
           success:(successBlock)success 
           failure:(failureBlock)failure;

- (void)requestWithMethod:(HTTPMethod)method 
                      url:(NSString *)url 
                   params:(NSMutableDictionary *)params 
                  success:(successBlock)success 
                  failure:(failureBlock)failure 
                   finish:(finishBlock)finish;

- (void)requestURL:(NSString *)url 
            params:(NSMutableDictionary *)params 
           success:(successBlock)success 
           failure:(failureBlock)failure 
            finish:(finishBlock)finish;
```

## Requirements
AFNetworking

## Installation

AFNetwork is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AFNetwork"
```

## Author

lingyfh, LingYFH@gmail.com

## License

AFNetwork is available under the MIT license. See the LICENSE file for more info.
