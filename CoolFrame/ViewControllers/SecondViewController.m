//
//  SecondViewController.m
//  CoolFrame
//
//  Created by silicon on 2017/7/25.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "SecondViewController.h"


@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize downloadView = _downloadView;
@synthesize cancelBtn = _cancelBtn;
@synthesize controlBtn = _controlBtn;
@synthesize processView = _processView;
@synthesize imageV = _imageV;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"B";
    
    [[self label] setFrame:CGRectMake(roundf(self.view.frame.size.width - 100)/2, roundf(self.view.frame.size.height - 100)/2, 100, 100)];
    
    [self.label setTextAlignment:NSTextAlignmentCenter];
    [self.label setFont:[UIFont fontWithName:@"HiraKakuProN-W3" size:40.0f]];
    [self.label setText:@"B"];
    
    [self.view addSubview:[self label]];
    
    self.flag = NO;
    
    UIButton *startTask = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200) / 2, self.view.frame.size.height - 150, 200, 60)];
    [startTask setBackgroundColor:[UIColor orangeColor]];
    [startTask addTarget:self action:@selector(startDownloadTask) forControlEvents:UIControlEventTouchUpInside];
    [startTask setTitle:@"开始下载" forState:UIControlStateNormal];
    [self.view addSubview:startTask];
    
    [self initUI];
}

- (void)startDownloadTask{
    NSString *url = @"https://res.wx.qq.com/open/zh_CN/htmledition/res/dev/download/sdk/WXVoice_iOS_3.0.2221cbf.zip";
    [DownloadUtil getInstance].delegate = self;
    [[DownloadUtil getInstance] startDownload:url];
}

- (void)initUI{
    [[self downloadView] setFrame:CGRectMake(0, 100, self.view.frame.size.width, 200)];
    [self.downloadView setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:self.downloadView];
    
    [[self imageV] setFrame:CGRectMake(30, 50, 100, 100)];
    [self.imageV setImage:[UIImage imageNamed:@"no_searchresult"]];
    [self.downloadView addSubview:self.imageV];
    
    [[self controlBtn] setFrame:CGRectMake(self.view.frame.size.width - 160 - 40, 50, 80, 60)];
    [self.controlBtn setTitle:@"暂停" forState:UIControlStateNormal];
    [self.controlBtn setBackgroundColor:[UIColor blueColor]];
    [self.controlBtn addTarget:self action:@selector(pauseResumeController) forControlEvents:UIControlEventTouchUpInside];
    [self.downloadView addSubview:self.controlBtn];
    
    [[self cancelBtn] setFrame:CGRectMake(self.view.frame.size.width - 20 - 80, 50, 80, 60)];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn setBackgroundColor:[UIColor redColor]];
    [self.controlBtn addTarget:self action:@selector(deleteDownloadTask) forControlEvents:UIControlEventTouchUpInside];
    [self.downloadView addSubview:self.cancelBtn];
    
    [self.processView setFrame:CGRectMake(20, 160, self.view.frame.size.width - 40, 10)];
    [self.downloadView addSubview:self.processView];
    
    [[self progressLabel] setFrame:CGRectMake((self.view.frame.size.width - 100)/2, 180, 100, 16)];
    [self.progressLabel setFont:[UIFont systemFontOfSize:10.0f]];
    [self.progressLabel setTextColor:[UIColor whiteColor]];
    [self.downloadView addSubview:self.progressLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pauseResumeController{
    if(!_flag){
        [_controlBtn setTitle:@"恢复" forState:UIControlStateNormal];
        [[DownloadUtil getInstance] stopDownLoad];
        _flag = YES;
    }else{
        [_controlBtn setTitle:@"暂停" forState:UIControlStateNormal];
        [[DownloadUtil getInstance] resumeDownload];
        _flag = NO;
    }
}

- (void)deleteDownloadTask{
    
}

#pragma mark - DownloadDelegate
- (void)downloadTask:(int64_t) totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{

    dispatch_async(dispatch_get_main_queue(), ^{
        [_processView setProgress:totalBytesWritten * 1.0 / totalBytesExpectedToWrite animated:YES];
        NSLog(@"%.2f%%", totalBytesWritten * 1.0 / totalBytesExpectedToWrite * 100);
        self.progressLabel.text = [NSString stringWithFormat:@"下载进度:%.2f%%",100 * totalBytesWritten * 1.0 / totalBytesExpectedToWrite];
    });
    
}

- (void)downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    
}

- (void)downloadTask:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    
}

- (UILabel *)label{
    if(!_label){
        _label = [[UILabel alloc] init];
    }
    
    return _label;
}

- (UIButton *)cancelBtn{
    if(!_cancelBtn){
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    
    return _cancelBtn;
}

- (UIButton *)controlBtn{
    if(!_controlBtn){
        _controlBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    
    return _controlBtn;
}

- (UIView *)downloadView{
    if(!_downloadView){
        _downloadView = [[UIView alloc] init];
    }
    
    return _downloadView;
}

- (UIProgressView *)processView{
    if(!_processView){
        _processView = [[UIProgressView alloc] init];
    }
    
    return _processView;
}

- (UIImageView *)imageV{
    if(!_imageV){
        _imageV = [[UIImageView alloc] init];
    }
    
    return _imageV;
}

- (UILabel *)progressLabel{
    if(!_progressLabel){
        _progressLabel = [[UILabel alloc] init];
    }
    
    return _progressLabel;
}

@end
