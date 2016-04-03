//
//  ChildClass+Category.m
//  Initialize_load_demo
//
//  Created by Broccoli on 16/4/3.
//  Copyright © 2016年 youzan. All rights reserved.
//

#import "ChildClass+Category.h"

@implementation ChildClass (Category)

+ (void) initialize {
    NSLog(@"%s", __FUNCTION__);
}

@end
