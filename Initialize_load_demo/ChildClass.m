//
//  ChildClass.m
//  Initialize_load_demo
//
//  Created by Broccoli on 16/4/3.
//  Copyright © 2016年 youzan. All rights reserved.
//

#import "ChildClass.h"

@implementation ChildClass

+ (void) initialize {
    NSLog(@"%s", __FUNCTION__);
}

+ (void) load {
    NSLog(@"%s", __FUNCTION__);
}

@end
