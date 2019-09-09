//
//  MyScrollView.m
//  ScrollViewDemo
//
//  Created by gonghonglou on 2018/2/11.
//  Copyright © 2018年 Troy. All rights reserved.
//

#import "MyScrollView.h"

@interface MyScrollView () <UIGestureRecognizerDelegate>

@end

@implementation MyScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer.state != 0) {
        return YES;
    } else {
        return NO;
    }
}

@end
