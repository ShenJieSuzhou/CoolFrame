//
//  DownloadUtil.h
//  CoolFrame
//
//  Created by shenjie on 2017/8/14.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DownloadDelegate <NSObject>

- (void)downloadTask:(int64_t) totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite;

- (void)downloadTask:(NSURLSessionDataTask *)downloadTask didFinishDownloadingToURL:(NSString *)location;

- (void)downloadTask:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error;


@end

@interface DownloadUtil : NSObject<NSURLSessionDelegate, NSURLSessionDownloadDelegate, NSURLSessionDataDelegate, NSURLSessionTaskDelegate>

@property (nonatomic, strong) id<DownloadDelegate> delegate;

/** 下载任务 */
@property (nonatomic, strong) NSURLSessionDataTask* downloadTask;

/** resumeData记录下载位置*/
@property (nonatomic, strong) NSData* resumeData;

/*session*/
@property (nonatomic, strong) NSURLSession *session;

/** 离线下载 所需属性**/
/*文件总长度*/
@property (nonatomic, assign) NSInteger fileLength;

/*当前下载的长度*/
@property (nonatomic, assign) NSInteger currentLength;

/*文件操作句柄*/
@property (nonatomic, strong) NSFileHandle *fileHandle;

/*下载地址*/
@property (nonatomic, strong) NSString *downloadUrl;

/*任务列表*/
@property (nonatomic, strong) NSMutableArray *taskList;

+ (DownloadUtil *)getInstance;

/*
 *@brief 开始下载
 @param url 下载文件地址
 */
- (void)startDownload:(NSString *)URL;

/*
 *@brief 暂停下载
 */
- (void)stopDownLoad;

/*
 *@brief 恢复下载
 */
- (void)resumeDownload;

@end
