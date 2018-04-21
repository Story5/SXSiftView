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
    SXSiftView *siftView = [[SXSiftView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 500)];
    siftView.backgroundColor = [UIColor whiteColor];
    siftView.dataArray = [self loadData];
    [self.view addSubview:siftView];
}

- (NSMutableArray *)loadData {
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"]];
    NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return array;
}


@end
