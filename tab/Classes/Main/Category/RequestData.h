//
//  RequestCategory.h
//  tab
//
//  Created by 王军 on 15/4/12.
//  Copyright (c) 2015年 WANG. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface RequestData : AFHTTPSessionManager

- (void)getLiveData:(void(^)(id responseData))loadAndRefresh;

+ (instancetype)sharedRequestData;

@end
