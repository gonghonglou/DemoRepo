//
//  target_home.m
//  GHLHome
//
//  Created by 与佳期 on 2019/6/11.
//

#import "target_home.h"
#import "GHLHomeViewController.h"

@implementation target_home

- (UIViewController *)action_homePage:(NSDictionary *)params {
    GHLHomeViewController *vc = [GHLHomeViewController new];
    vc.page = params[@"page"];
    return vc;
}

@end
