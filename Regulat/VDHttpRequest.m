//
//  VDHttpRequest.m
//  Regulat
//
//  Created by Donald on 17/4/5.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "VDHttpRequest.h"
#import <CFNetwork/CFNetwork.h>

static void myCFReadStreamClientCallBack1(CFReadStreamRef stream, CFStreamEventType type, void *clientCallBackInfo) {
    CFHTTPMessageRef response = (CFHTTPMessageRef)clientCallBackInfo;
    if (type == kCFStreamEventEndEncountered) {
        CFIndex statusCode = CFHTTPMessageGetResponseStatusCode(response);
        if (statusCode == 200) {
            CFDataRef responseData = CFHTTPMessageCopyBody(response);
            CFStringRef responseWebPage = CFStringCreateWithBytes(kCFAllocatorDefault, CFDataGetBytePtr(responseData), CFDataGetLength(responseData), kCFStringEncodingUTF8, YES);
            NSLog(@"方式2:\n%@", responseWebPage);
            CFRelease(responseData);
            CFRelease(responseWebPage);
        }
    } else if (type == kCFStreamEventErrorOccurred) {
        CFReadStreamUnscheduleFromRunLoop(stream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
        CFReadStreamClose(stream);
        CFRelease(stream);
        stream = NULL;
    } else if (type == kCFStreamEventHasBytesAvailable) {
        
        //获取http response的header，转换成字典
        
        CFTypeRef message =
        CFReadStreamCopyProperty(stream, kCFStreamPropertyHTTPResponseHeader);
        NSDictionary* httpHeaders =
        (__bridge NSDictionary *)CFHTTPMessageCopyAllHeaderFields((CFHTTPMessageRef)message);
        NSLog(@"dic:%@",httpHeaders);
        CFRelease(message);
        UInt8 buffer[2048];
        //回调读取数据时，读取的都是body的内容，response header自动被封装处理好的。
        CFIndex length = CFReadStreamRead(stream, buffer, sizeof(buffer));        CFHTTPMessageAppendBytes(response, buffer, length);
    }
}

@implementation VDHttpRequest
+ (void)requestMethod:(VDHttpRequestMethod)method requestURLString:(NSString *)urlString withRequestBlock:(resultBlock)block
{
    NSString * requestMethod = method?@"POST":@"GET";
    CFStringRef strignURL = (__bridge CFStringRef)(urlString);
    CFURLRef myURL = CFURLCreateWithString(kCFAllocatorDefault,strignURL, NULL);// note: release
   
    CFHTTPMessageRef messageRequest = CFHTTPMessageCreateRequest(kCFAllocatorDefault,(__bridge CFStringRef)requestMethod,myURL, kCFHTTPVersion2_0);
    
    CFReadStreamRef requestReadStream = CFReadStreamCreateForHTTPRequest(kCFAllocatorDefault, messageRequest);// note: release
    CFHTTPMessageRef response = CFHTTPMessageCreateEmpty(kCFAllocatorDefault, false);
    CFStreamClientContext clientContext = {0,response, NULL, NULL, NULL};
    CFOptionFlags flags = kCFStreamEventHasBytesAvailable | kCFStreamEventEndEncountered | kCFStreamEventErrorOccurred;
    Boolean result = CFReadStreamSetClient(requestReadStream, flags, myCFReadStreamClientCallBack1, &clientContext);
    if (result) {
        CFReadStreamScheduleWithRunLoop(requestReadStream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
        if (CFReadStreamOpen(requestReadStream)) {
            CFRunLoopRun();
        } else {
            CFReadStreamUnscheduleFromRunLoop(requestReadStream, CFRunLoopGetCurrent(), kCFRunLoopCommonModes);
        }
    }
    CFRelease(myURL);
    CFRelease(messageRequest);
    
    
    
}



@end
