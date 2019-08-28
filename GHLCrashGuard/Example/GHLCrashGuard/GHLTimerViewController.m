//
//  GHLTimerViewController.m
//  GHLCrashGuard_Example
//
//  Created by 与佳期 on 2019/7/12.
//  Copyright © 2019 gonghonglou. All rights reserved.
//

#import "GHLTimerViewController.h"
#import <BlocksKit/BlocksKit.h>

@interface GHLTimerViewController ()

@property (nonatomic, strong) NSTimer *oldTimer;

@property (nonatomic, strong) NSTimer *nowTimer;

@property (nonatomic, strong) NSTimer *bkTimer;

@end

@implementation GHLTimerViewController


+ (void)initialize {
    NSLog(@"initialize------Son");
}

+ (void)load {
    NSLog(@"load------Son");
}

- (void)dealloc {
    [_oldTimer invalidate];
    [_nowTimer invalidate];
    [_bkTimer invalidate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.oldTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(repeatLog) userInfo:nil repeats:YES];
//    self.nowTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"nowTimer");
//    }];
    
//    __weak typeof(self) weakSelf = self;
//    self.bkTimer = [NSTimer bk_scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        [strongSelf repeatLog];
//    } repeats:YES];
}

- (void)repeatLog {
    NSLog(@"timer--self:%@", self);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
