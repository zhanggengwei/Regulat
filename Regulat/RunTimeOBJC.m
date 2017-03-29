//
//  RunTimeOBJC.m
//  Regulat
//
//  Created by Donald on 17/3/28.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import "RunTimeOBJC.h"
#import <objc/objc.h>
#import <objc/runtime.h>
#import <objc/message.h>
@implementation RunTimeOBJC

- (NSArray *)propertyList
{
    return nil;
}

- (void)msg_forward
{
    //强制类型的转换
    ((void (*) (id, SEL)) (void *)objc_msgSend)(self, sel_registerName("run"));
    //objc_msgSend

}

- (void)run
{
    NSLog(@"eat Methods");
}


@end
