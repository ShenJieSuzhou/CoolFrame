//
//  DownloadUtil.m
//  CoolFrame
//
//  Created by shenjie on 2017/8/14.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "DownloadUtil.h"
#import "JSONKit.h"

@implementation DownloadUtil

@synthesize delegate = _delegate;
@synthesize downloadTask = _downloadTask;
@synthesize resumeData = _resumeData;
@synthesize session = _session;
@synthesize fileLength = _fileLength;
@synthesize fileHandle = _fileHandle;
@synthesize downloadUrl = _downloadUrl;
@synthesize taskList = _taskList;

+ (DownloadUtil *)getInstance{
    static DownloadUtil *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[DownloadUtil alloc] init];
        [_instance initTaskList];
    });
    
    return _instance;
}

- (void)startDownload:(NSString *)URL{
    self.downloadUrl = URL;
    
    //添加下载文件到下载列表中。
    [self addTaskToList:URL];
    
    //获取文件名
    NSArray *array = [URL componentsSeparatedByString:@"/"];
    NSString *fileName = [array lastObject];
    //拿到Documentory文件夹路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *fpath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    
    NSInteger fileLen = [self fileLengthForPath:fpath];
    if(fileLen > 0){
        self.currentLength = fileLen;
    }
    
    [[self downloadTask] resume];
   
//    //创建session对象
//    NSURLSessionConfiguration *sessionCig = [NSURLSessionConfiguration defaultSessionConfiguration];
//    _session = [NSURLSession sessionWithConfiguration:sessionCig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
//    
//    //创建任务
}

- (void)stopDownLoad{
//    __weak typeof(self) selfvc = self;
//    [_downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
//        selfvc.resumeData = resumeData;
//        selfvc.downloadTask = nil;
//    }];
    [[self downloadTask] suspend];
    self.downloadTask = nil;
}

- (void)resumeDownload{
//    _downloadTask = [_session downloadTaskWithResumeData:_resumeData];
//    [_downloadTask resume];
//    _resumeData = nil;
    [[self downloadTask] resume];
}

- (NSURLSession *)session{
    if(!_session){
        NSURLSessionConfiguration *sessionCig = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:sessionCig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    
    return _session;
}

- (NSURLSessionDataTask *)downloadTask{
    if(!_downloadTask){
        //创建request 请求
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.downloadUrl]];
        //设置http请求头中的range
        NSString *range = [NSString stringWithFormat:@"bytes=%zd-", _currentLength];
        [request setValue:range forHTTPHeaderField:@"Range"];
        
        //下载
        _downloadTask = [[self session] dataTaskWithRequest:request];
    }
    
    return _downloadTask;
}

- (NSString *)downloadUrl{
    return _downloadUrl;
}

- (void)setDownloadUrl:(NSString *)downloadUrl{
    _downloadUrl = downloadUrl;
}

/*
 * 获取已下载文件的大小
 */
- (NSInteger)fileLengthForPath:(NSString *)path{
    NSInteger fileLen = 0;
    NSFileManager *fileManager = [[NSFileManager alloc] init];

    if([fileManager fileExistsAtPath:path]){
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if(!error && fileDict){
            fileLen = [fileDict fileSize];
        }
    }
    
    return fileLen;
}

/*
 * 初始化任务列表
 */
- (void)initTaskList{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *Paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [Paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"download.json"];
    self.taskList = [[NSMutableArray alloc] init];
    
    if(![fileManager fileExistsAtPath:path]){
        [self.taskList addObjectsFromArray:@[]];
        NSData *jsonData = [self.taskList JSONData];
        if(jsonData){
            [jsonData writeToFile:path atomically:YES];
        }
    }
    
    NSData *jsonData = [[NSFileManager defaultManager] contentsAtPath:path];
    NSArray *list = [jsonData objectFromJSONData];
    [self.taskList addObjectsFromArray:list];
}


/*
 * 添加任务到列表中
 */
- (void)addTaskToList:(NSString *)taskName{
    if (taskName && taskName.length > 0) {
        if(![_taskList containsObject:taskName]){
            [_taskList addObject:taskName];
        }
        
        NSData *jsonData = [_taskList JSONData];
        NSArray*paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString*documentsDirectory =[paths objectAtIndex:0];
        
        NSString*path =[documentsDirectory stringByAppendingPathComponent:@"download.json"];
        [jsonData writeToFile:path atomically:YES];
    }
}

/*
 * 下载完成后删除任务
 */
- (void)removeTaskFromList:(NSString *)taskName{
    for (int i = 0; i < _taskList.count; i++) {
        if([[_taskList objectAtIndex:i] containsString:taskName]){
            [_taskList removeObjectAtIndex:i];
        }
    }
    
    [_taskList removeObject:taskName];
    
    NSData *jsonData = [_taskList JSONData];
    NSArray*paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString*documentsDirectory =[paths objectAtIndex:0];
    
    NSString*path =[documentsDirectory stringByAppendingPathComponent:@"download.json"];
    [jsonData writeToFile:path atomically:YES];
}


#pragma mark - NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler{
    //获得下载文件的总长度
    self.fileLength = response.expectedContentLength + self.currentLength;
    
    
    //拿到Documentory文件夹路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *fpath = [paths objectAtIndex:0];
    
    //拿到cache文件夹和文件名
    NSString *file = [fpath stringByAppendingPathComponent:response.suggestedFilename];
    NSLog(@"File Name:%@", file);
    NSFileManager *manager = [NSFileManager defaultManager];
    if(![manager fileExistsAtPath:file]){
        [manager createFileAtPath:file contents:nil attributes:nil];
    }
    
    //创建文件句柄
    self.fileHandle = [NSFileHandle fileHandleForWritingAtPath:file];
    
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data{
    //指定数据写入到文件最后面
    [self.fileHandle seekToEndOfFile];
    
    //向指定路径中写入数据
    [self.fileHandle writeData:data];
    
    self.currentLength += data.length;
 
    [self.delegate downloadTask:self.currentLength totalBytesExpectedToWrite:self.fileLength];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    [self.fileHandle closeFile];
    self.fileHandle = nil;
    
    self.currentLength = 0;
    self.fileLength = 0;
    
    NSString *fileName = [task response].suggestedFilename;
    
    [self.delegate downloadTask:session task:task didCompleteWithError:error];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
 willCacheResponse:(NSCachedURLResponse *)proposedResponse
 completionHandler:(void (^)(NSCachedURLResponse * _Nullable cachedResponse))completionHandler{
    
   
}

#pragma mark - NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    

}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
//    [self.delegate downloadTask:totalBytesWritten totalBytesExpectedToWrite:totalBytesExpectedToWrite];
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes{
    
}


@end
