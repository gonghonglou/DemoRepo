//
//  GHLRouter.m
//  GHLHome
//
//  Created by 与佳期 on 2019/6/11.
//

#import "GHLRouter.h"
#import "GHLMediator.h"
#import <objc/runtime.h>

@interface GHLRouter ()

@property (nonatomic, strong) NSDictionary *targetDict;

@end

@implementation GHLRouter

+ (instancetype)sharedInstance {
    
    static GHLRouter *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [GHLRouter new];
    });
    return sharedInstance;
}

- (id)routerWithUrlString:(NSString *)urlString {
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    for (NSString *param in [url.query componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if ([elts count] < 2) continue;
        NSString *key = [elts.firstObject stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *value = [elts.lastObject stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        params[key] = value;
    }
    
    return [self routerWithUrlString:url.path params:params];
}

- (id)routerWithUrlString:(NSString *)urlString params:(NSDictionary *)params {
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *target = url.pathComponents[0];
    NSString *actionName = url.pathComponents[1];
    id result = [[GHLMediator sharedInstance] performTarget:target action:actionName params:params];
    return result;
}

- (id)openURLString:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    for (NSString *param in [url.query componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if ([elts count] < 2) continue;
        NSString *key = [elts.firstObject stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *value = [elts.lastObject stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        params[key] = value;
    }
    
    return [self openURLString:url.path params:params];
}

- (nullable id)openURLString:(NSString *)urlString params:(NSDictionary *)params {
    NSString *classString = self.targetDict[urlString];
    if (classString.length) {
        Class controllerClass = NSClassFromString(classString);
        UIViewController *viewController = [controllerClass new];
        
        objc_setAssociatedObject(viewController, @selector(params), [params copy], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return viewController;
    }
    return nil;
}

#pragma mark - getter
- (NSDictionary *)targetDict {
    if (!_targetDict) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"GHLRouter" withExtension:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithURL:url];
        NSString *path = [bundle pathForResource:@"target" ofType:@"plist"];
        _targetDict = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return _targetDict;
}

@end


#pragma mark - UIViewController Category

@implementation UIViewController (GHLRouter)

- (NSDictionary *)params {
    return objc_getAssociatedObject(self, @selector(params));
}

@end
