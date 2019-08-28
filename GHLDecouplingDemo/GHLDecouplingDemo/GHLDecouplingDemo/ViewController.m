//
//  ViewController.m
//  GHLDecouplingDemo
//
//  Created by 与佳期 on 2019/6/11.
//  Copyright © 2019 与佳期. All rights reserved.
//

#import "ViewController.h"
#import "GHLRouter.h"
#import "GHLMediator+Home.h"
#import "GHLSelectorService.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIViewController *vc = [[GHLRouter sharedInstance] routerWithUrlString:@"home/homePage?page=1"];
    NSLog(@"vc:%@", vc);
    
    UIViewController *vc2 = [[GHLMediator sharedInstance] ghlHomeViewControllerWithPage:@"1"];
    NSLog(@"vc2:%@", vc2);
    
    UIViewController *vc3 = [[GHLRouter sharedInstance] openURLString:@"home/homePage?page=1"];
    NSLog(@"vc3:%@", vc3);
    
    [GHLSelectorService call:@"home/homeLog" withParams:@{@"page":@"1"}];
}


@end
