//
//  ViewController.m
//  FHImageTextViewDemo
//
//  Created by imac on 2018/4/12.
//  Copyright © 2018年 com.GodL.github. All rights reserved.
//

#import "ViewController.h"
#import "FHImageTextView.h"
#import <Masonry/Masonry.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    FHImageTextView *view = [[FHImageTextView alloc] initWithType:FHImageTextTypeTextLeft];
    view.backgroundColor = UIColor.redColor;
    [self.view addSubview:view];
    [view setText:@"北京" forState:FHImageTextContronStateNormal];
    [view setText:@"北京这个地方不咋地" forState:FHImageTextContronStateSelected];

    [view setImage:[UIImage imageNamed:@"cd_p2_time expand"] forState:FHImageTextContronStateNormal];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.centerOffset(CGPointZero);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        view.selected = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            view.selected = NO;
        });
    });;
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
