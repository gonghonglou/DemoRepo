//
//  GHLMediator+Home.m
//  GHLHome
//
//  Created by 与佳期 on 2019/6/11.
//

#import "GHLMediator+Home.h"

@implementation GHLMediator (Home)

- (UIViewController *)ghlHomeViewControllerWithPage:(NSString *)page {
    return [self performTarget:@"home" action:@"homePage" params:@{@"page" : page}];
}

@end
