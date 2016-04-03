//
//  SuperClass.m
//  Initialize_load_demo
//
//  Created by Broccoli on 16/4/3.
//  Copyright © 2016年 youzan. All rights reserved.
//

#import "SuperClass.h"

@implementation SuperClass

+ (void) initialize {
    NSLog(@"%s", __FUNCTION__);
}

+ (void) load {
    NSLog(@"%s", __FUNCTION__);
}

@end
