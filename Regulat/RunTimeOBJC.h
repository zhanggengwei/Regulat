//
//  RunTimeOBJC.h
//  Regulat
//
//  Created by Donald on 17/3/28.
//  Copyright © 2017年 Susu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunTimeOBJC : NSObject


@property (nonatomic,strong) NSString * name;

- (void)msg_forward;

- (void)addMethod;

@end
