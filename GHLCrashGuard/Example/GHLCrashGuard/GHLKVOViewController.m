//
//  GHLKVOViewController.m
//  GHLCrashGuard_Example
//
//  Created by 与佳期 on 2019/7/13.
//  Copyright © 2019 gonghonglou. All rights reserved.
//

#import "GHLKVOViewController.h"
#import "GHLTestObject.h"
#import <FBKVOController.h>

@interface GHLKVOViewController ()

@property (nonatomic, strong) GHLTestObject *obj;

@property (nonatomic, strong) FBKVOController *kvo;

@end

@implementation GHLKVOViewController

- (void)dealloc {
    NSLog(@"GHLKVOViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.obj = [GHLTestObject new];
    self.obj.name = @"123";
    
//    [self.kvoObject addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//    self.kvoObject.name = @"111";
    
    self.kvo = [FBKVOController controllerWithObserver:self];
    [self.kvo observe:self.obj keyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {

        NSLog(@"oldName:%@", [change objectForKey:NSKeyValueChangeOldKey]);
        NSLog(@"newName:%@", [change objectForKey:NSKeyValueChangeNewKey]);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(log) name:@"log" object:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.obj.name = @"111";
//    [self.kvoObject removeObserver:self forKeyPath:@"name"];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    NSLog(@"oldName:%@", [change objectForKey:NSKeyValueChangeOldKey]);
    NSLog(@"newName:%@", [change objectForKey:NSKeyValueChangeNewKey]);
}

@end
