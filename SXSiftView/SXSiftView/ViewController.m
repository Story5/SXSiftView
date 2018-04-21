//
//  ViewController.m
//  SXSiftView
//
//  Created by Story5 on 2018/4/21.
//  Copyright © 2018年 Story5. All rights reserved.
//

#import "ViewController.h"
#import "SXSiftView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    float height = 200;
    UIView *siftView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), height)];
    siftView.backgroundColor = [UIColor redColor];
    [self.view addSubview:siftView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
