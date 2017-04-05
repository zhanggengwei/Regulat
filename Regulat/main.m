//
//  main.m
//  Regulat
//
//  Created by Donald on 17/3/28.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestDemo.h"
//#import "RunTimeOBJC.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        //18863014571 188****4571
       // NSError * error;
        //NSRegularExpression * expression = [[NSRegularExpression alloc]initWithPattern:@"(\\d{3})\\d{4}(\\d{4})" options:NSRegularExpressionCaseInsensitive error:&error];
       // NSLog(@"%@",[expression stringByReplacingMatchesInString:@"18863014571" options:NSMatchingReportProgress range:NSMakeRange(0,@"18863014571".length) withTemplate:@"$1****$2"]);188****4571
       /*
        NSArray * IPArr = @[@"127.0.0.1",@"3.3.3.3",@"192.168.1.2",@"245.1.3.5"];
        //添加零
        NSMutableArray * dataArr = [NSMutableArray new];
        NSRegularExpression * expression = [[NSRegularExpression alloc]initWithPattern:@"(\\d+)" options:NSRegularExpressionCaseInsensitive error:&error];
        //添加零
        [IPArr enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString * content = [expression stringByReplacingMatchesInString:obj options:NSMatchingReportProgress range:NSMakeRange(0, obj.length) withTemplate:@"00$1"];
            NSRegularExpression * regex = [[NSRegularExpression alloc]initWithPattern:@"0*(\\d{3})" options:NSRegularExpressionCaseInsensitive error:nil];
            content = [regex stringByReplacingMatchesInString:content options:NSMatchingReportProgress range:NSMakeRange(0, content.length)  withTemplate:@"$1"];
            [dataArr addObject:content];
            NSLog(@"content==%@",content);
            
        }];
        [dataArr sortUsingSelector:@selector(compare:)];
        [dataArr enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSError * error;
            NSRegularExpression * regex = [[NSRegularExpression alloc]initWithPattern:@"0*(\\d)" options:NSRegularExpressionCaseInsensitive error:&error];
            NSString * str =[regex stringByReplacingMatchesInString:obj options:NSMatchingReportProgress range:NSMakeRange(0, obj.length) withTemplate:@"$1"];
            NSLog(@"str ==%@",str);
            
            
        }];
        
        
        
        NSLog(@"dataArr == %@",dataArr);
        */
        
//        NSString * content = @"+86(186-6301-4571)";
//        NSRegularExpression * expression = [[NSRegularExpression alloc]initWithPattern:@"\\+86" options:NSRegularExpressionCaseInsensitive error:&error];
//        NSLog(@"%@",[expression stringByReplacingMatchesInString:content options:NSMatchingReportProgress range:NSMakeRange(0, content.length) withTemplate:@""]);
  /*
        [[RunTimeOBJC new] addMethod];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
         [[RunTimeOBJC new]performSelector:sel_registerName("startEngine") withObject:nil];
#pragma clang diagnostic pop
      
        NSLog(@"%@",[RunTimeOBJC new]);
        
    
        NSLog(@"%@",[NSMutableArray arrayWithObject:@""].class);
        NSLog(@"%@",@[@"",@""].class);
        NSLog(@"%@",@[].class);
     
    
        //+86
   */
        /*NSRegularExpression * regex = [[NSRegularExpression alloc]initWithPattern:@"^http:s[a-z]*" options:NSRegularExpressionCaseInsensitive error:nil];
        NSString * str = @"http:s";
        NSString * str1 = @"http";
        
        
        NSArray<NSTextCheckingResult *> * resulst =[regex matchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
        
        NSArray<NSTextCheckingResult *> * resulst2 =[regex matchesInString:str1 options:NSMatchingReportProgress range:NSMakeRange(0, str1.length)];
        
        
        NSLog(@"%@",resulst);
        NSLog(@"%@",resulst2);
         */
        [RequestDemo loadRequestData];
        
        
        
    }
    return 0;
}

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


