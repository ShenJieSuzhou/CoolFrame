//
//  FouthViewController.m
//  CoolFrame
//
//  Created by silicon on 2017/7/25.
//  Copyright © 2017年 com.snailgames.coolframe. All rights reserved.
//

#import "FouthViewController.h"

@interface FouthViewController ()

@end

@implementation FouthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"D";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [[self label] setFrame:CGRectMake(roundf(self.view.frame.size.width - 100)/2, roundf(self.view.frame.size.height - 100)/2, 100, 100)];
    [self.label setTextAlignment:NSTextAlignmentCenter];
    [self.label setFont:[UIFont fontWithName:@"HiraKakuProN-W3" size:40.0f]];
    [self.label setText:@"D"];
    
    [self.view addSubview:[self label]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UILabel *)label{
    if(!_label){
        _label = [[UILabel alloc] init];
    }
    
    return _label;
}

@end
