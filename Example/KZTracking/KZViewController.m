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

@property (nonatomic, assign) BOOL showsTitle;

@property (nonatomic, assign) NSString *name;


@end


@implementation KZViewController

{
    @private BOOL _showsTitle;
}

@synthesize showsTitle=_showsTitle;

- (void)setShowsTitle:(BOOL)showsTitle {
    _showsTitle = showsTitle;
}

- (BOOL)showsTitle {
    
    return _showsTitle;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [[AFHTTPSessionManager manager] GET:@"https://www.baidu.com" parameters:@{@"key":@"value"} headers:@{@"key":@"value"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
//    [[AFHTTPSessionManager manager] GET:@"https://www.baidu.com" parameters:@{@"key":@"value"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"res");
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"err");
//    }];
    
    self.showsTitle = YES;
    
    NSLog(@"%d, %d", self.showsTitle, _showsTitle);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
