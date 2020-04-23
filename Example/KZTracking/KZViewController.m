//
//  KZViewController.m
//  KZTracking
//
//  Created by gujianxing on 08/02/2019.
//  Copyright (c) 2019 gujianxing. All rights reserved.
//

#import "KZViewController.h"
#import <AFNetworking/AFNetworking.h>

#import "AFHTTPSessionManager+Tracking.h"

@interface KZViewController ()<NSURLSessionTaskDelegate, NSURLSessionDelegate, NSURLSessionDataDelegate>

@end

@implementation KZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[AFHTTPSessionManager manager] GET:@"https://www.baidu.com" parameters:@{@"key":@"value"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"res");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"err");
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
