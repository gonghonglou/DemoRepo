//
//  UIResponder+GHLEvent.m
//  GHLDecouplingDemo
//
//  Created by 与佳期 on 2019/6/13.
//  Copyright © 2019 与佳期. All rights reserved.
//

#import "UIResponder+GHLEvent.h"

@implementation UIResponder (GHLEvent)

- (void)ghl_event:(NSString *)event params:(NSDictionary *)params {
    
    [self.nextResponder ghl_event:event params:params];
}

@end
