//
//  VDHttpRequest.h
//  Regulat
//
//  Created by Donald on 17/4/5.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,VDHttpRequestMethod)
{
    VDHttpRequestMethodGet,
    VDHttpRequestMethodPost
};
typedef void(^resultBlock)(id);


@interface VDHttpRequest : NSObject


+ (void)requestMethod:(VDHttpRequestMethod)method requestURLString:(NSString *)urlString withRequestBlock:(resultBlock)block;



@end
