//
//  GHLViewController.m
//  GHLCrashGuard
//
//  Created by gonghonglou on 07/07/2019.
//  Copyright (c) 2019 gonghonglou. All rights reserved.
//

#import "GHLViewController.h"
#import "GHLTestObject.h"
#import "GHLTimerViewController.h"
#import "GHLKVOViewController.h"
#import "GHLTestView.h"
#import "GHLTestViewA.h"
#import "GHLTestViewB.h"

#import "GHLViewController+A.h"

__attribute__((constructor)) static void beforeMain() {
    NSLog(@"before main");
}
__attribute__((destructor)) static void afterMain() {
    NSLog(@"after main");
}

@interface GHLViewController ()

@property (nonatomic, strong) GHLTestObject *obj;

@end

@implementation GHLViewController

+ (void)initialize {
    NSLog(@"initialize------Father");
}

+ (void)load {
    NSLog(@"load------Father");
}

+ (void)testlog1 {
    NSLog(@"1------");
}

+ (void)testlog2 {
    NSLog(@"2------");
}

+ (void)testlogMain {
    NSLog(@"---main---");
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    for (int i = 0; i < 10000; i++) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            self.obj = [GHLTestObject new];
//        });
//    }
    
    GHLTestView *view = [[GHLTestView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    GHLTestViewA *viewA = [[GHLTestViewA alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    viewA.backgroundColor = [UIColor blueColor];
    
    view.viewA = viewA;
    [view addSubview:viewA];
    
    GHLTestView *viewB = [[GHLTestView alloc] initWithFrame:CGRectMake(100, 100, 200, 400)];
    viewB.backgroundColor = [UIColor purpleColor];
    [viewA addSubview:viewB];
    
//    __weak typeof (view) weakView = view;
//    view.testBlock = ^{
//        NSLog(@"test block--%@", weakView);
//    };
    
//    // YES if the receiver is an instance of aClass or an instance of any class that inherits from aClass, otherwise NO.
//    BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
//    // YES if the receiver is an instance of aClass, otherwise NO.
//    BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
//    BOOL res3 = [(id)[GHLViewController class] isKindOfClass:[GHLViewController class]];
//    BOOL res4 = [(id)[GHLViewController class] isMemberOfClass:[GHLViewController class]];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    GHLTimerViewController *vc = [GHLTimerViewController new];
//    [self presentViewController:vc animated:YES completion:nil];
//}

// Unrecognized Selector
- (void)unrecognizedSelector {
    UIView *view = [UIView new];
    [view performSelector:@selector(log)];
}

// EXC_BAD_ACCESS
- (void)excAadAccess {
    self.obj = [GHLTestObject new];
    [self.obj log];

    self.obj = [NSNull null];
    [self.obj log];
}

// Container
- (void)container {
//    NSArray *array = @[@1];
//    NSLog(@"%@", array[2]);
    
    // NSArray
    NSLog(@"arr alloc:%@", [NSArray alloc].class); // __NSPlaceholderArray
    NSLog(@"arr init:%@", [[NSArray alloc] init].class); // __NSArray0
    
    NSLog(@"arr:%@", [@[] class]); // __NSArray0
    NSLog(@"arr:%@", [@[@1] class]); // __NSSingleObjectArrayI
    NSLog(@"arr:%@", [@[@1, @2] class]); // __NSArrayI
    
    // NSMutableArray
    NSLog(@"mutA alloc:%@", [NSMutableArray alloc].class); // __NSPlaceholderArray
    NSLog(@"mutA init:%@", [[NSMutableArray alloc] init].class); // __NSArrayM
    
    NSLog(@"mutA:%@", [@[].mutableCopy class]); // __NSArrayM
    NSLog(@"mutA:%@", [@[@1].mutableCopy class]); // __NSArrayM
    NSLog(@"mutA:%@", [@[@1, @2].mutableCopy class]); // __NSArrayM
    
    // NSDictionary
    NSLog(@"dict alloc:%@", [NSDictionary alloc].class); // __NSPlaceholderDictionary
    NSLog(@"dict init:%@", [[NSDictionary alloc] init].class); // __NSDictionary0
    
    NSLog(@"dict:%@", [@{} class]); // __NSDictionary0
    NSLog(@"dict:%@", [@{@1:@1} class]); // __NSSingleEntryDictionaryI
    NSLog(@"dict:%@", [@{@1:@1, @2:@2} class]); // __NSDictionaryI
    
    // NSMutableDictionary
    NSLog(@"mutD alloc:%@", [NSMutableDictionary alloc].class); // __NSPlaceholderDictionary
    NSLog(@"mutD init:%@", [[NSMutableDictionary alloc] init].class); // __NSDictionaryM
    
    NSLog(@"mutD:%@", [@{}.mutableCopy class]); // __NSDictionaryM
    NSLog(@"mutD:%@", [@{@1:@1}.mutableCopy class]); // __NSDictionaryM
    NSLog(@"mutD:%@", [@{@1:@1, @2:@2}.mutableCopy class]); // __NSDictionaryM
    
    // NSString
    NSLog(@"str:%@", [@"" class]); // __NSCFConstantString
    
    // NSNumber
    NSLog(@"num:%@", [@1 class]); // __NSCFNumber
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [self presentViewController:[GHLKVOViewController new] animated:YES completion:nil];
//}

@end
