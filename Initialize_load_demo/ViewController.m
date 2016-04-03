//
//  ViewController.m
//  Initialize_load_demo
//
//  Created by Broccoli on 16/4/3.
//  Copyright © 2016年 youzan. All rights reserved.
//

#import "ViewController.h"
#import "ChildClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ChildClass *child = [[ChildClass alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
