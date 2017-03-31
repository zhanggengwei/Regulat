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
void startEngine(id _id,SEL _cmd) {
    NSLog(@"my car starts the engine");
}

@implementation RunTimeOBJC

+(void)load
{
    //导入后会执行
    [super load];
    NSLog(@"%s",__func__);
    
    Method method =  class_getInstanceMethod(self, @selector(description));
    Method replaceMethod = class_getInstanceMethod(self, @selector(descriptionMain));
    method_exchangeImplementations(method, replaceMethod);
  
    
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
    }
  
    return self;
}

- (void)addMethod
{

     class_addMethod([self class],sel_registerName("startEngine"),(IMP)startEngine, "v@:@");
}

+ (void)initialize
{
    //initialize
    //这个调用的时间发生在你的类接收到消息之前，但是在它的超类接收到initialize之后。
    [super initialize];
    NSLog(@"%s",__FUNCTION__);
}


- (NSArray *)propertyList
{
    return nil;
}

- (void)msg_forward
{
    
     /*
     (1)第一种解决方案:
     在项目配置文件 -> Build Settings -> Enable Strict Checking of objc_msgSend Calls 这个字段设置为 NO, 默认为YES. 在编译你的项目就会发现问题解决了
     
     Person *person = [[Person alloc]init];
     objc_msgSend(person, sel_registerName("say"));
     objc_msgSend(person, @selector(say));
     */
    //(2)第一种解决方案:
    //强制类型的转换
    ((void (*) (id, SEL)) (void *)objc_msgSend)(self, sel_registerName("run"));
    ((void (*) (id, SEL)) (void *)objc_msgSend)(self.class, sel_registerName("run"));
    //class_addMethod(<#__unsafe_unretained Class cls#>, <#SEL name#>, IMP imp, <#const char *types#>)
    
    
   
    
    
    //objc_msgSend

}

- (void)run
{
    NSLog(@"eat Methods");
}
+ (void)run
{
    NSLog(@"+(void)run");
}

- (NSString *)descriptionMain
{
    [self  descriptionMain];
    unsigned int count = 0;
    objc_property_t * propertyList  = class_copyPropertyList(self.class, &count);
    NSMutableString * content = [NSMutableString stringWithString:@"{"];
    for (int i =0; i < count; i++)
    {
        objc_property_t property = propertyList[i];
        const char * name = property_getName(property);
//        id obj =[self valueForKey:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
        [content appendString:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
        [content appendString:[NSString stringWithCString:":value" encoding:NSUTF8StringEncoding]];
    }
    free(propertyList);
    [content appendString:@"}"];
    return content;
    
}
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    if (sel == sel_registerName("startEngine")) {//@:@
//        class_addMethod([self class], sel, (IMP)startEngine, "v@:@");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}



@end
