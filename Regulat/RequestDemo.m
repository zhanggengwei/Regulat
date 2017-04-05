//
//  RequestDemo.m
//  Regulat
//
//  Created by Donald on 17/4/5.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "RequestDemo.h"

@implementation RequestDemo

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
    }}

+ (void)loadRequestData
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    
#pragma clang diagnostic ignored "-Wunused-variable"

    
    // 创建请求
    CFStringRef url = CFSTR("https://www.baidu.com/");
    CFURLRef myURL = CFURLCreateWithString(kCFAllocatorDefault, url, NULL);// note: release
    CFStringRef requestMethod = CFSTR("GET");
    CFHTTPMessageRef myRequest = CFHTTPMessageCreateRequest(kCFAllocatorDefault, requestMethod, myURL, kCFHTTPVersion1_1);// note: release
    int a ;
    
    
    // 设置body
   // const UInt8 bytes[] = "12345";
   // CFDataRef bodyData = CFDataCreate(kCFAllocatorDefault, bytes, 5);// note: release
   // CFHTTPMessageSetBody(myRequest, bodyData);
    // 设置header
   // CFStringRef headerField = CFSTR("name");
   // CFStringRef value = CFSTR("daniate");
   // CFHTTPMessageSetHeaderFieldValue(myRequest, headerField, value);
    CFReadStreamRef requestReadStream = CFReadStreamCreateForHTTPRequest(kCFAllocatorDefault, myRequest);// note: release
    CFHTTPMessageRef response = CFHTTPMessageCreateEmpty(kCFAllocatorDefault, false);
    CFStreamClientContext clientContext = {0, response, NULL, NULL, NULL};
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
    CFRelease(myRequest);
    //CFRelease(bodyData);
#pragma clang diagnostic pop
}
@end
