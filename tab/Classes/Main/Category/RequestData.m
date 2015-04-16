//
//  RequestCategory.m
//  tab
//
//  Created by 王军 on 15/4/12.
//  Copyright (c) 2015年 WANG. All rights reserved.
//

#import "RequestData.h"

@implementation RequestData

- (void)getLiveData:(void(^)(id responseData))loadAndRefresh
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [self GET:@"http://api.taoshij.com:80/user/live/living?source=iOS_3.0.0_AMCustomer" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //回调
        loadAndRefresh(responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"getLiveData失败-%@", error);
        
    }];
}

+ (instancetype)sharedRequestData
{
    static RequestData *sharedRequestData = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedRequestData = [[self alloc] init];
    });
    return sharedRequestData;
}

@end




